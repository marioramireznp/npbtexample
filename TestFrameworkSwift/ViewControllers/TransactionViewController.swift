//
//  TransactionViewController.swift
//  TestFrameworkSwift
//
//  Created by Mario Ramirez on 9/5/19.
//  Copyright © 2019 Mario Ramirez. All rights reserved.
//

import UIKit
import NPBTSPaymentConnector



class TransactionViewController: UIViewController , CBCentralManagerDelegate {
    
    @IBOutlet weak var amountTextField: UITextField!
    
    var batchData = ""
    var terminalTime: String!
    var deviceName = ""
    var bt: BTDeviceFinder?
    var isBtConnected = false
    var transactionError = ""
    var authCode: String!
    var transactionId: String?
    var cancelRequest: Data?
    var terminalId : String?
    var scanBluetoothTime1: Int = 5
    var objects :  [AnyObject] = []
    var isScanning = false
    var btDeviceSelected = ""
    var btDevicesArray: [AnyHashable] = []
    var mPosType : PosType!
    var lastTransactionAmount : String = ""
    
    var isChip: Bool?
    var amount: Double?
    var promotion: String?
    var retryCountB: Int?
    var tip: Double?
    var reference: String?
    var isChipSwipe = false
    var orderId = ""
    var isJackReader = false
    var transactionCompleted = false
    var isSignatureNeeded = true
    var manager: CBCentralManager!
    var cvvAlert: UIAlertController!
    
    //    let userName = "prueba@netpay.com"
    //    let storeId = ""
    //    let passWord = "adm0n2"
    
    let userName = "sergio.zorrila@bsdenterprise.com"
    let storeId = ""
    let passWord = "prueba123"
    
    
        var isSendingTransaction = false
    
    let pinHexValues = ["01", "02", "03", "04", "41", "42", "43", "44"]
    var timer = Timer()
    var seconds = 0
    
    lazy var pos: QPOSService = {
        let pos = QPOSService.sharedInstance()
        return pos!
    }()
    
    override public func viewDidLoad() {
        //Set
        NPSession.sharedSingleton().url = "http://34.210.252.31:8895"
        amount = 1.0
        super.viewDidLoad()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        checkReader()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        resetPos()
        UserDefaults.standard.removeObject(forKey: "CancelPending")
        super.viewWillDisappear(true)
    }
    
    
    
    
    func checkReader() {
        if let readerStr = UserDefaults.standard.string(forKey: "reader_device") {
            deviceName = readerStr
            if readerStr == "Jack Reader" {
                isJackReader = true
            } else {
                connectBluetooth()
            }
        } else {
            
        }
    }
    @IBAction func initBt(_ sender: Any) {
        
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.pos.cancelSetAmount()
        onRequest(TransactionResult.CANCEL)
    }
    
    
    @IBAction func scanBt(_ sender: Any) {
        scanBluetooth()
    }
    @IBAction func connectBt(_ sender: Any) {
        self.initPos(reader: btDeviceSelected)
        
    }
    @IBAction func processSale(_ sender: Any) {
        doPrepareTransaction()
        pos.doTrade(20)
    }
    @IBAction func cancelLastSale(_ sender: Any) {

            if(!lastTransactionAmount.isEmpty){
                
                NPAPIClient.processRefund( userName: userName, pass: passWord, amount: self.lastTransactionAmount, orderId: orderId, transactionId: transactionId, terminalId: self.terminalId) { (result) in
                    
                    switch result {
                    case .success(let message):
                        self.lastTransactionAmount = ""
                        print("cancelTrxConnection")
                        print(message)
                        
                    case .failure(_):
                        //error
                        print ("Error")
                    }
                    
                }
                
            } else {
                print("No hay transaccion a regresar")
        }

        
    }
    @IBAction func disconect(_ sender: Any) {
        if nil == pos{
            
        } else {
            self.bt!.stopQPos2Mode()
            self.bt!.setBluetoothDelegate2Mode(nil)
            self.pos.disconnectBT()
            self.pos.resetPosStatus()
            self.pos.setDelegate(nil)
        }
    }
    @IBAction func bateryLevel(_ sender: Any) {
        pos.getQPosInfo()

    }
    
    
    func connectBluetooth() {
        if bt == nil {
            bt = BTDeviceFinder.init()
        }
        //MOSTRAR MENSAJE DE CONECTANDO A LECTOR
        print("Conectando a Lector")
        bt?.setBluetoothDelegate2Mode(self)
        manager = CBCentralManager()
        
        manager.delegate = self
    }
    
    public   func connect(_ device: String?) {
        print("Connect Address")
        if nil == pos {
            pos = QPOSService.sharedInstance()
        }
        pos.setDelegate(self)
        pos.setQueue(nil)
        isScanning = false
        
        if device != nil {
            mPosType = PosType.bluetooth_2mode
            pos.setPosType(PosType.bluetooth_2mode)
            print("Conectando BT...")
            pos.connectBT(device)
        } else {
            print(" No existe dispositivo configurado.")
        }
    }
    
    public   func scanBluetooth() {
        print("*-*-*-*-*-  " + #file + String(#line) )
        objects.removeAll()
        if bt == nil {
            print("Asigning bt instance")
            bt = BTDeviceFinder()
        }
        self.isScanning = true
        manager = CBCentralManager()
        manager.delegate = self
        var delay: Int = 0
        print(String(format: "BT DEVICES:%ld", Int(Float((bt?.getCBCentralManagerState())!.rawValue))))
        bt?.setBluetoothDelegate2Mode(self)
        if bt?.getCBCentralManagerState() == .unknown {
            while bt?.getCBCentralManagerState() != .poweredOn {
                print("Bluetooth state is not power on")
                sleepMs(msec: 10.0)
                if delay == 10 {
                    return
                }
                delay += 1
            }
        }
        bt?.scanQPos2Mode(scanBluetoothTime1)
        print("*-*-*-*-*- ending scan")
    }
    
    public    func sleepMs(msec: Double) {
        let sec = msec / 1000.0
        Thread.sleep(forTimeInterval: sec)
    }
    
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            bt?.scanQPos2Mode(5)
            break
        case .poweredOff:
            //Error de BTAPAGADO
            break
        case .resetting:
            break
        case .unauthorized:
            break
        case .unsupported:
            break
        case .unknown:
            break
        default:
            break
        }
    }
    
    
    
    func initPos(reader: String) {
        let dateFormatter = DateFormatter.init()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        terminalTime = dateFormatter.string(from: Date())
        pos.setDelegate(self)
        pos.setPosType(PosType.bluetooth_2mode)
        pos.setQueue(nil)
        pos.connectBT(reader)
        self.isScanning = false
        
    }
    
   
    
    
    func sendMCR(decodeData: [AnyHashable : Any]) {
        //MOSTRAR INDICACIONES DE HACIENDO TRANSACCION
        //
        print("Leyendo tarjeta por banda ")
        
        let pan = decodeData["maskedPAN"] as! String
        let expDate = decodeData["expiryDate"] as! String
        let cardHolderName = decodeData["cardholderName"] as! String
        let serviceCode = decodeData["serviceCode"] as! String
        let track1 = decodeData["encTrack1"] as! String
        let track2 = decodeData["encTrack2"] as! String
        var ksn = ""
        if isJackReader {
            ksn = decodeData["ksn"] as? String ?? ""
        } else {
            ksn = decodeData["trackksn"] as? String ?? ""
        }
        
        isSignatureNeeded = true
        
        let cardPinHex = decodeData["9F34"] as? String
        
        if let cardPinHex = cardPinHex {
            let indexPin = cardPinHex.index(cardPinHex.startIndex, offsetBy: 2)
            let cardPin = String(cardPinHex[..<indexPin])
            isSignatureNeeded = !pinHexValues.contains(cardPin)
        }
        
        //        if (NPMyTransaction.sharedSingleton().retryCountFB)! < 2 && (serviceCode.hasPrefix("2") || serviceCode.hasPrefix("6")){
        if !isSendingTransaction {
            self.dismiss(animated: true, completion: {
                //ADVICE: ERROR INSERTAR CHIP
            })
        }
        //            return
        //        }
        
        var index = expDate.index(expDate.startIndex, offsetBy: 4)
        
        var expDateSubs = String(expDate[..<index])
        index = expDateSubs.index(expDateSubs.startIndex, offsetBy: 2)
        
        let upperStr = String(expDateSubs[index...])
        let bottomStr = String(expDateSubs[..<index])
        expDateSubs = "\(upperStr)/\(bottomStr)"
        
        //ADVICE: AVISAR REALIZANDO TRANSACCION
        
        var emvTagsEncType = ""
        
        if ksn.isEmpty {
                emvTagsEncType = "DSPREADICC"
        } else {
            
            if pan.first == "3" {
                cvvAlert = UIAlertController(title: "", message: "Introduce CVV", preferredStyle: UIAlertController.Style.alert)
                
                cvvAlert.addTextField(configurationHandler: {(textField : UITextField) in
                    textField.placeholder = "CVV"
                    textField.keyboardType = .numberPad
                    textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
                })
                
                cvvAlert.addAction(UIAlertAction(title: "Enviar", style: .default, handler: { (action: UIAlertAction!) in
                    let textField = self.cvvAlert.textFields![0] as UITextField
                    
                    self.processTransactionRequest(orderId: self.orderId, transType: "Auth", mode: "P", track1: track1, track2: track2, cvv2: textField.text!, emvTags: nil, emvTagsEncType: emvTagsEncType, amount: self.amount, ksn: ksn, cardHolderPresentCode: "2", cardHolderName: cardHolderName, isSignatureNeeded: self.isSignatureNeeded)
                }))
                
                cvvAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
                    
                        // "cancelled_transaction_error" )
                   
                }))
                
                cvvAlert?.actions[0].isEnabled = false
                present(cvvAlert, animated: true, completion: nil)
            } else {
      
                self.processTransactionRequest(orderId: self.orderId, transType: "Auth", mode: "P", track1: track1, track2: track2, cvv2: nil, emvTags: nil, emvTagsEncType: emvTagsEncType, amount: self.amount, ksn: ksn, cardHolderPresentCode: "2", cardHolderName: cardHolderName, isSignatureNeeded: self.isSignatureNeeded)
            }
        }
    }
    
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        cvvAlert?.actions[0].isEnabled = sender.text!.count == 3 || sender.text!.count == 4
    }
    
    func resetPos() {
        
        bt?.stopQPos2Mode()
        bt?.setBluetoothDelegate2Mode(nil)
        bt = nil
        
        if !isSendingTransaction {
            pos.resetPosStatus()
        }
        
        pos.disconnectBT()
        pos.setDelegate(nil)
        
        
    }
    
    func resetAsyncPos() {
        DispatchQueue.global().async {
            self.pos.resetPosStatus()
        }
    }
    
    func doPrepareTransaction(){
        var datetime = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMddHHmmss"
        formatter.timeZone = NSTimeZone.local
        var enUSPOSIXLocale: NSLocale?
        enUSPOSIXLocale = NSLocale(localeIdentifier: "en_US_POSIX")
        if let aLocale = enUSPOSIXLocale {
            formatter.locale = aLocale as Locale
        }
        datetime = formatter.string(from: Date())
        
        //Se agrega el OrderID + Timestamp
        self.orderId = storeId + datetime
        //Efecto de demostracion tomar el amount del textfield
        self.amount = Double( self.amountTextField.text as! String )
        
    }
    
    
    func processTransactionRequest(orderId:String?, transType: String?, mode: String?, track1: String?, track2: String?, cvv2: String?, emvTags: String?, emvTagsEncType: String?,amount:Double?, ksn: String?, cardHolderPresentCode: String?, cardHolderName: String?, isSignatureNeeded: Bool) {
        
        let stringAmount = String(amount!)
        resetAsyncPos()
        
        isSendingTransaction = true
        if let cancelPendingData = UserDefaults.standard.object(forKey: "CancelPending") as? Data {
            
            NPAPIClient.cancelPending(jsonData: cancelPendingData) { result in
                switch result {
                case .success(_):
                    UserDefaults.standard.removeObject(forKey: "CancelPending")
                    //NPMyTransaction.sharedSingleton().resetOrderId()
                    self.processTransactionRequest(orderId: orderId, transType: transType, mode: mode, track1: nil, track2: nil, cvv2: nil, emvTags: emvTags, emvTagsEncType: emvTagsEncType, amount: amount, ksn: nil, cardHolderPresentCode: "5", cardHolderName: cardHolderName, isSignatureNeeded: isSignatureNeeded)
                case .failure(_):
                    //error
                    print("Error ")
                    //Manejo de Error
                    let a = ""
                }
            }
            
        } else {
            
            
            cancelRequest = NPHelper.getCancelPendingString(mode: mode, orderId: orderId, track2: track2, track1: track1, cvv2: cvv2, emvTags: emvTags, emvTagsEncType: emvTagsEncType, amount: stringAmount, cardHolderPresentCode: cardHolderPresentCode, ksn: ksn, terminalId: self.terminalId, promotion: "000000", remTraceAudit: "1", latitude: 0, longitude: 0, attribute1: "1", cardHolderName: cardHolderName, user: self.userName, password: self.passWord)
            
            
            UserDefaults.standard.set(cancelRequest, forKey: "CancelPending")
            
            //track1 y 2 solo para banda
            NPAPIClient.transaction(mode: mode, orderId: orderId, track2: track2, track1: track1, cvv2: cvv2, emvTags: emvTags , emvTagsEncType: emvTagsEncType, amount: stringAmount, cardHolderPresentCode: cardHolderPresentCode, ksn: ksn, terminalId: terminalId, promotion: "000000", remTraceAudit: "1", latitude: 0, longitude: 0, attribute1: "1", cardHolderName: cardHolderName, user: self.userName, password: self.passWord ) { result in
                switch result {
                case .success(let message):
                    UserDefaults.standard.removeObject(forKey: "CancelPending")
                    
                    if message.response?.responseCode == "00" {
                        //ADVICE: TRANSACCION COMPLETA Y CORRECTA
                        print(message)
                        self.transactionId = message.order?.transaction?.transactionId
                        
                        if isSignatureNeeded {
                            print("Necesita Firma ")
                            
                            self.authCode = message.order?.transaction?.authCode
                            self.lastTransactionAmount = self.amountTextField.text!
                            DispatchQueue.main.async(execute: {
                                self.performSegue(withIdentifier: "sign_segue", sender: self)
                            })
                            
                        } else {
                            print("Terminada ")
                            
                        }
                    } else {
                        if let response = message.response?.responseMsg {
                            print(response)
                            //ADVICE: TRANSACCION COMPLETA Y RECHAZDA
                            print("Rechazada ")
                            
                        } else {
                            print("Error de conexion")
                            
                            //ADVICE: FALLO DE CONEXION
                            
                            
                        }
                    }
                case .failure(_):
                    //ADVICE: FALLO DE CONEXION
                    print("Error de conexion")
                    
                    let a = ""
                    
                }
            }
            
            
            
        }
    }
    
}

extension TransactionViewController: BluetoothDelegate2Mode {
    func onBluetoothName2Mode(_ bluetoothName: String!) { // Delegado
        if(isScanning){
            print("Insertando")
            DispatchQueue.main.async(execute: {
                self.insertNewObject(bluetoothName)
            })
        } else {
            print("Conectando")
            DispatchQueue.main.async {
                if bluetoothName == self.deviceName {
                    self.initPos(reader: self.deviceName)
                    self.bt?.stopQPos2Mode()
                    self.isBtConnected = true
                }
            }
            
        }
        
    }
    
    func finishScanQPos2Mode() {
        //        if let _ = self.bt {
        //            if !self.isBtConnected {
        //                //AVISAR QUE SE VA A ESCANEAR O ENCENDER EL LECTOR
        //                bt?.scanQPos2Mode(5)
        //            }
        //        }
        
        DispatchQueue.main.async(execute: {
            if self.pos.isQposPresent() {
                print("POS IS CONNECTED SUCCESSFULLY")
            } else {
                print("POS IS NOT CONNECTED")
            }
            self.bt?.stopQPos2Mode()
            if self.isScanning {
                self.onReturnObjects(self.objects as? [AnyHashable])
            }
        })
    }
    
    
    func insertNewObject(_ sender: Any?) {
        print("insertNewObject")
        
        if sender != nil {
            objects.insert(sender as AnyObject, at: 0)
        }
    }
    
    func bluetoothIsPowerOff2Mode() {
        DispatchQueue.main.async {
            if let _ = self.bt {
                if !self.isSendingTransaction {
                    //ERROR BT APAGADO
                }
            }
        }
    }
}

extension TransactionViewController: QPOSServiceListener {
    func onRequestQposConnected() {
        print("onRequestQposConnected")
        seconds = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        DispatchQueue.global(qos: .background).async {
            self.pos.resetPosStatus()
            
        }
    }
    
    @objc func updateTimer() {
        seconds += 1
        if seconds == 5 {
            onRequest(TransactionResult.DEVICE_ERROR)
            //ERROR DISPOSITIVO
        }
    }
    
    func onQposIdResult(_ posId: [AnyHashable : Any]!) {
        print("onQposIdResult")
        pos.getQPosInfo()
    }
    
    func onQposInfoResult(_ posInfoData: [AnyHashable : Any]!) {
        print("onQposInfoResult")
        self.pos.doTrade(20)
    }
    
    func onRequestGetCardNoResult(_ result: String!) {
        print("onRequestGetCardNoResult")
        if !isSendingTransaction {
            self.dismiss(animated: true, completion: {
                print("card_no_response_error")
            })
        }
    }
    
    func onRequestQposDisconnected() {
        print("onRequestQposDisconnected")
        if !isSendingTransaction {
            //ADVICE DESCONECTADO
        }
    }
    
    func onRequestNoQposDetected() {
        print("onRequestNoQposDetected")
        if !isSendingTransaction {
            //ADVICE NO DETECTADO
        }
    }
    
    func onAsyncResetPosStatus(_ isReset: String!) {
        print("onAsyncResetPosStatus: ", isReset)
    }
    
    func onRequestTime() {
        print("onRequestTime")
        self.pos.sendTime(self.terminalTime)
    }
    
    func onRequest(_ displayMsg: Display) {
        print("onRequest: ", displayMsg)
    }
    
    
    func onRequestIsServerConnected() {
        print("onRequestIsServerConnected")
        pos.isServerConnected(true)
    }
    
    func onRequestSetAmount() {
        print("onRequestSetAmount")
        timer.invalidate()
        
        var amountStr = changeToCurrency(price: amount!)
        
        amountStr = amountStr.replacingOccurrences(of: ".", with: "")
        amountStr = amountStr.replacingOccurrences(of: " ", with: "")
        amountStr = amountStr.replacingOccurrences(of: "$", with: "")
        amountStr = amountStr.replacingOccurrences(of: ",", with: "")
        amountStr = amountStr.replacingOccurrences(of: "MX", with: "")
        //            DispatchQueue.global(qos: .background).async {
        self.pos.setAmount("\(amountStr)", aAmountDescribe: "0", currency: "484", transactionType: .GOODS)
        //            }
        
    }
    
    func changeToCurrency(price: Double)->String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let amountStr = formatter.string(from: NSNumber(value: price))
        return amountStr!
    }
    
    func onRequestWaitingUser() {
        print("onRequestWaitingUser")
        //AVISAR DE INSERTAR TARJETA
    }
    
    func onRequestTransactionLog(_ tlv: String!) {
        print("onRequestTransactionLog")
    }
    
    func onDHError(_ errorState: DHError) {
        print("onDHError")
        if errorState == DHError.TIMEOUT {
            transactionError = "timeout_error"
            print(transactionError)
        } else if errorState == DHError.APDU_ERROR {
            transactionError = "device_error"
            print(transactionError)
        } else if (errorState == DHError.UNKNOWN) {
            transactionError = "damaged_device_error"
            print(transactionError)
        } else if (errorState == DHError.DEVICE_BUSY) {
            transactionError = "busy_device_error"
            print(transactionError)
        } else if (errorState == DHError.DEVICE_RESET) {
            transactionError = "reset_device_error"
            print(transactionError)
        } else if (errorState == DHError.INPUT_INVALID) {
            transactionError = "invalid_input_error"
            print(transactionError)
        } else if (errorState == DHError.WR_DATA_ERROR) {
            transactionError = "data_error"
            print(transactionError)
        } else if errorState == DHError.EMV_APP_CFG_ERROR {
            transactionError = "configuration_error"
            print(transactionError)
        } else if errorState == DHError.INPUT_ZERO_VALUES {
            transactionError = "data_nil_error"
            print(transactionError)
        } else if errorState == DHError.DIGITS_UNAVAILABLE {
            transactionError = "digits_unavailable_error"
            print(transactionError)
        } else if errorState == DHError.EMV_CAPK_CFG_ERROR {
            transactionError = "configuration_error"
            print(transactionError)
        } else if errorState == DHError.ICC_ONLINE_TIMEOUT {
            transactionError = "online_timeout_error"
            print(transactionError)
        } else if errorState == DHError.INPUT_OUT_OF_RANGE {
            transactionError = "input_out_of_range_error"
            print(transactionError)
        } else if errorState == DHError.AMOUNT_OUT_OF_LIMIT {
            transactionError = "amount_exceeded_error"
            print(transactionError)
        } else if errorState == DHError.QPOS_MEMORY_OVERFLOW {
            transactionError = "memory_overflow_error"
            print(transactionError)
        } else if errorState == DHError.CMD_TIMEOUT {
            transactionError = "cmd_timeout_error"
            print(transactionError)
        } else if errorState == DHError.CASHBACK_NOT_SUPPORTED {
            transactionError = "cashback_not_supported_error"
            print(transactionError)
        } else if errorState == DHError.COMM_ERROR {
            transactionError = "comm_error"
            print(transactionError)
        } else {
            transactionError = "reading_card_error"
            print(transactionError)
        }
        
        if !isSendingTransaction {
            dismiss(animated: true, completion: {
                //     self.errorTransactionDelegate.transactionDidFail(message: self.transactionError)
            })
        }
    }
    
    func onDoTradeResult(_ result: DoTradeResult, decodeData: [AnyHashable : Any]!) {
        print("onDoTradeResult")
        if result == DoTradeResult.ICC {
            //insert card
            isChip = true
            // processLbl.text = "reading_chip"
            //            DispatchQueue.global(qos: .background).async {
            self.pos.doEmvApp(EmvOption.START)
            //            }
            
        }else if result == DoTradeResult.MCR{
            //swipe card
            
            isChip = false
            sendMCR(decodeData: decodeData)
            
        } else if result == DoTradeResult.NFC_ONLINE{
            //NFC card
            onRequestOnlineProcessNFC(pos.getNFCBatchData()!["tlv"] as? String)
        }
        else {
            if result == DoTradeResult.NOT_ICC {
                transactionError = "reading_chip_error"
            }else if result == DoTradeResult.NONE{
                transactionError = "reading_card_error"
            }else if result == DoTradeResult.NFC_OFFLINE{
                transactionError = "nfc_offline_error"
            }else if result == DoTradeResult.NO_RESPONSE{
                transactionError = "no_response_error"
            }else if result == DoTradeResult.NFC_DECLINED{
                transactionError = "nfc_declined_error"
            } else {
                transactionError = "reading_card_error"
            }
            
            if !isSendingTransaction {
                self.dismiss(animated: true, completion: {
                    //      self.errorTransactionDelegate.transactionDidFail(message: self.transactionError)
                })
            }
        }
    }
    
    func onReturnEmvCardDataResult(_ tlv: String!) {
        print("onReturnEmvCardDataResult")
    }
    
    func onDeviceHere(_ isHere: Bool) {
        print("onDeviceHere")
    }
    
    func onReturnPowerOffIccResult(_ isSuccess: Bool) {
        print("onReturnPowerOffIccResult")
    }
    
    func onRequestOnlineProcess(_ tlv: String!) {
        print("onRequestOnlineProcess")
        
        
        
        //            DispatchQueue.global(qos: .background).async {
        self.pos.sendOnlineProcessResult("8A023030")
        //            }
        
        
        //AVISAR ESTADO DE ENVIANDO TRANSACCION
        
        
        let range = tlv.range(of: "C282")
        var index = tlv.index(tlv.startIndex, offsetBy: (range?.lowerBound.encodedOffset)!)
        let tlvLocal = String(tlv[..<index])
        
        if let obj = TLVDecode.decode(with: tlvLocal) {
            let tags = obj as Dictionary
            
            let cardHolderName = getString(hexTag: tags["5F20"] as? String ?? "")
            
            isSignatureNeeded = true
            
            let cardPinHex = tags["9F34"] as? String
            
            if let cardPinHex = cardPinHex {
                let indexPin = cardPinHex.index(cardPinHex.startIndex, offsetBy: 2)
                let cardPin = String(cardPinHex[..<indexPin])
                isSignatureNeeded = !pinHexValues.contains(cardPin)
            }
            
            let rawTokens = tlv.data(using: String.Encoding.utf8)
            
            var emvTokenB64 = rawTokens?.base64EncodedString()
            
            let byte0A : CUnsignedChar = 0x0A
            let byte0D : CUnsignedChar = 0x0D
            
            emvTokenB64 = emvTokenB64!.replacingOccurrences(of: "\(byte0A)", with: "")
            emvTokenB64 = emvTokenB64!.replacingOccurrences(of: "\(byte0D)", with: "")
            
            let escapeSet = NSCharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ")
            let emvTokensB64URLEncoded = emvTokenB64!.addingPercentEncoding(withAllowedCharacters: escapeSet.inverted)!
            
            let emvTagsEncrypted = emvTokensB64URLEncoded
            
            var emvTagsEncType = ""
            
            emvTagsEncType = "DSPREADICC"
            
            doPrepareTransaction()
            
            processTransactionRequest(orderId: self.orderId, transType: "Auth", mode: "P", track1: nil, track2: nil, cvv2: nil, emvTags: emvTokensB64URLEncoded, emvTagsEncType: emvTagsEncType, amount: self.amount, ksn: nil, cardHolderPresentCode: "5", cardHolderName: cardHolderName, isSignatureNeeded: isSignatureNeeded)
            
        } else {
            
        }
    }
    
    func onRequestOnlineProcessNFC(_ tlv: String!) {
        print("onRequestOnlineProcessNFC")
        
        
        
        pos.sendOnlineProcessResult("8A023030")
        
        
        //Avisar realizando transaccion
        
        let range = tlv.range(of: "C282")
        var index = tlv.index(tlv.startIndex, offsetBy: (range?.lowerBound.encodedOffset)!)
        let tlvLocal = String(tlv[..<index])
        
        if let obj = TLVDecode.decode(with: tlvLocal) {
            let tags = obj as Dictionary
            
            let cardHolderName = getString(hexTag: tags["5F20"] as? String ?? "")
            
            isSignatureNeeded = true
            
            let cardPinHex = tags["9F34"] as? String
            
            if let cardPinHex = cardPinHex {
                let indexPin = cardPinHex.index(cardPinHex.startIndex, offsetBy: 2)
                let cardPin = String(cardPinHex[..<indexPin])
                isSignatureNeeded = !pinHexValues.contains(cardPin)
            }
            
            let rawTokens = tlv.data(using: String.Encoding.utf8)
            
            var emvTokenB64 = rawTokens?.base64EncodedString()
            
            let byte0A : CUnsignedChar = 0x0A
            let byte0D : CUnsignedChar = 0x0D
            
            emvTokenB64 = emvTokenB64!.replacingOccurrences(of: "\(byte0A)", with: "")
            emvTokenB64 = emvTokenB64!.replacingOccurrences(of: "\(byte0D)", with: "")
            
            let escapeSet = NSCharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ")
            let emvTokensB64URLEncoded = emvTokenB64!.addingPercentEncoding(withAllowedCharacters: escapeSet.inverted)!
            
            let emvTagsEncrypted = emvTokensB64URLEncoded
            
            var emvTagsEncType = ""
            
            emvTagsEncType = "DSPREADICC"
            
            
            
            doPrepareTransaction()
            
            processTransactionRequest(orderId: self.orderId, transType: "Auth", mode: "P", track1: nil, track2: nil, cvv2: nil, emvTags: emvTokensB64URLEncoded, emvTagsEncType: emvTagsEncType, amount: self.amount, ksn: nil, cardHolderPresentCode: "7", cardHolderName: cardHolderName, isSignatureNeeded: isSignatureNeeded)
            
            
        } else {
            
        }
    }
    
    func getString(hexTag: String)->String {
        let data : Data? = hexTag.dataFromHexString()
        var newStr = String(data: data!, encoding: String.Encoding.utf8)
        newStr = newStr?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return newStr!
    }
    
    func onRequestBatchData(_ tlv: String!) {
        print("onRequestBatchData")
        batchData = tlv
    }
    
    
    func onRequest(_ transactionResult: TransactionResult) {
        print("onRequest")
        if transactionResult == TransactionResult.APPROVED {
        } else {
            if transactionResult == TransactionResult.TERMINATED{
                transactionError = "incomplete_transaction_error"
            } else if transactionResult == TransactionResult.DECLINED{
                transactionError = "declined_transaction_error"
            } else if transactionResult == TransactionResult.CANCEL{
                transactionError = "cancelled_transaction_error"
            } else if transactionResult == TransactionResult.CAPK_FAIL{
                transactionError = "comm_error"
            } else if transactionResult == TransactionResult.NOT_ICC{
                transactionError = "icc_error"
            } else if transactionResult == TransactionResult.SELECT_APP_FAIL{
                transactionError = "select_app_fail_error"
            } else if transactionResult == TransactionResult.DEVICE_ERROR{
                transactionError = "device_error"
            } else if transactionResult == TransactionResult.CARD_NOT_SUPPORTED{
                transactionError = "card_not_supported_error"
            } else if transactionResult == TransactionResult.MISSING_MANDATORY_DATA{
                transactionError = "missing_mandatory_data_error"
            } else if transactionResult == TransactionResult.CARD_BLOCKED_OR_NO_EMV_APPS{
                transactionError = "blocked_card_error"
            } else if transactionResult == TransactionResult.INVALID_ICC_DATA{
                transactionError = "invalid_icc_data_error"
            } else if transactionResult == TransactionResult.FALLBACK{
                transactionError = "fallback_error"
            } else if transactionResult == TransactionResult.NFC_TERMINATED{
                transactionError = "nfc_terminated"
            } else if transactionResult == TransactionResult.TRADE_LOG_FULL{
                transactionError = "full_log_error"
            } else {
                transactionError = "reading_card_error"
            }
            
            if !isSendingTransaction {
                self.dismiss(animated: true, completion: {
                    //     self.errorTransactionDelegate.transactionDidFail(message: self.transactionError)
                })
            }
        }
    }
    
    func onRequestSelectEmvApp(_ appList: [Any]!) {
        if appList.count > 1 {
            let applicationAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.alert)
            
            for (index, obj) in appList.enumerated() {
                if let app = obj as? String {
                    applicationAlert.addAction(UIAlertAction(title: app as String, style: .default, handler: { (action: UIAlertAction!) in
                        //                        DispatchQueue.global(qos: .background).async {
                        self.pos.selectEmvApp(index)
                        //                        }
                    }))
                }
            }
            
            applicationAlert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: {
                    //  self.errorTransactionDelegate.transactionDidFail(message: "cancelled_transaction_error" )
                })
            }))
            
            present(applicationAlert, animated: true, completion: nil)
        } else {
            //            DispatchQueue.global(qos: .background).async {
            self.pos.selectEmvApp(0)
            //            }
        }
    }
    
    
    func onReturnObjects(_ objets: [AnyHashable]?) {
        btDevicesArray = objets!
        //print(String(format: "onReturnObjects: %lu", UInt(btDevicesArray.count)))
        if btDevicesArray.count > 0 {
            let alert = UIAlertController(title: "BT Devices", message: "Selecciona el dispositivo", preferredStyle: .actionSheet)
            for object in btDevicesArray {
                let action = UIAlertAction(title: object.description, style: .default) { (action) in
                    self.btDeviceSelected = object.description
                    self.terminalId = object.description
                    print("BT Selected: \(self.btDeviceSelected)")
                    let dvSelected = "BT Device Selected: \(self.btDeviceSelected)"
                    
                    //Conect selected device
                    
                    self.initPos(reader: self.btDeviceSelected)                   // self.readerBT?.connect(self.btDeviceSelected)
                    
                }
                
                if let popoverController = alert.popoverPresentationController {
                    popoverController.sourceView = self.view
                    popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                    popoverController.permittedArrowDirections = []
                }
                alert.addAction(action)
                
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel ))
            self.present(alert, animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sign_segue" {
            let destination = segue.destination as! SignatureViewController
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            terminalTime = dateFormatter.string(from: Date())
            let dateArray : [String] = terminalTime.components(separatedBy: " ")
            
            let authDate = dateArray[0]
            let authTime = dateArray[1]
            
            destination.authDate =  authDate
            destination.authTime =  authTime
            destination.authCode = authCode
            destination.storeId = storeId
            destination.userName = userName
            destination.password = passWord
            destination.amount = amount
            destination.total = String( format: "%.2f", self.amount!)
            destination.orderId = orderId
            
            
        }
    }
}
