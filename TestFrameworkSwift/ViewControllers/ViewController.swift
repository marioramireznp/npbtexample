//
//  ViewController.swift
//  TestFrameworkSwift
//
//  Created by Mario Ramirez on 12/14/18.
//  Copyright © 2018 Mario Ramirez. All rights reserved.
//

import UIKit
import NPBTSPaymentConnector

class ViewController: UIViewController {
    var btDeviceSelected = ""
    var btDevicesArray: [AnyHashable] = []
    
    var readerBT: NPReaderBTConnector?
    var orderId : String?
    var amount : String?
    var transactionId : String?
    var isTransaction : Bool!
    var responseNPMessage : NPMessage?
    
    var authCode : String?
    var terminalTime: String!
    var npSignatureDelegate : NPReaderBTSignatureDelegate?
    
    var PrimaryHost = ""
    var vSpinner : UIView?
    var waitingForConnectTransaction : Bool = false
    var deviceConnected : Bool = false
    
    //Variables de usuario
//    let userName = "sergio.zorrila@bsdenterprise.com"
//    let storeId = ""
//    let passWord = "prueba123"
    
        let userName = "mau@.net"
        let storeId = ""
        let passWord = "adm0n2"


    
    var terminalId : String?
    
    @IBOutlet weak var amountTxt: UITextField!
    @IBOutlet weak var lastDigitsTxt: UITextField!
    @IBOutlet weak var orderNumberTxt: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // NPSession.sharedSingleton().url = "http://34.214.58.23:8895"
        NPSession.sharedSingleton().url = "http://172.31.48.52:8895"
     
        isTransaction = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        UserDefaults.standard.removeObject(forKey: "CancelPending")
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    //Funcion de inicializacion del conector
    @IBAction func connectBT(_ sender: Any) {
        readerBT = NPReaderBTConnector()
        readerBT?.delegate = self
        readerBT?.connect()
        logMessage("Instancia creada")
        
    }
    
    //Funcion de desconexión del conector
    @IBAction func disconnectBT(_ sender: Any) {
        if readerBT != nil{
            self.readerBT?.resetPos()
            deviceConnected = false
            logMessage("Desconectado")
        }
        else {
            deviceConnected = false
            logMessage("No hay conexion")
        }
    }
    
    //Funcion de escaneado de dispositivos
    @IBAction func scanBT(_ sender: Any) {
        readerBT?.scanDevices()
        logMessage("Escaneando....")
        showSpinner(onView: self.view)
    }
    
    //Funcion de conexion con el dispositivo seleccionado,
    @IBAction func connectDevice(_ sender: Any) {
        readerBT?.connect(btDeviceSelected)
        deviceConnected = true
        showSpinner(onView: self.view)
    }
    //Funcion que regresa el porcentaje de bateria
    @IBAction func battery(_ sender: Any) {
        readerBT?.checkBattery()
    }
    
    //Empezar transaccion
    @IBAction func startTrans(_ sender: Any) {
        
        if(btDeviceSelected.count != 0 && deviceConnected ){
            doTransaction()
        } else {
            waitingForConnectTransaction = true
            readerBT?.connect(btDeviceSelected)
        }
    }
    
    
    func doTransaction(){
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
        orderId = storeId + datetime
        isTransaction = true
        amount = amountTxt.text
        
        readerBT?.processTransaction("Auth",  withUser: userName, andPass: passWord, andTerminalId: terminalId, andPromotion: "000000", andAmount: amountTxt.text, andOrderId: orderId, andMode: "P", andHost1: PrimaryHost, andHost2: PrimaryHost)
        // showSpinner(onView: self.view)
    }
    
    //Funcion que recibe los datos de una compra y se hace el rembolso
    @IBAction func refundBT(_ sender: Any) {
        if (isTransaction) {
            let oId = orderId ?? "0"
            let transId = transactionId ?? "0"
            readerBT?.processRefund( withUser: userName, andPass: passWord, andAmount: amount, andOrderId: orderId, andTransactionId: transactionId )
            showSpinner(onView: self.view)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "No se ha realizado alguna transacción", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel ))
            self.present(alert, animated: true)
        }
    }
    
    func logMessage(_ format: String?) {
        let block: (() -> Void)? = {
            print("\(format ?? "")")
            self.textView.text = self.textView.text + ("\(format ?? "")\n")
            self.textView.scrollRangeToVisible(NSRange(location: self.textView.text.count, length: 0))
        }
        if Thread.isMainThread {
            block?()
        }
        else {
            DispatchQueue.main.async(execute: block!)
        }
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        self.vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}

extension ViewController: NPReaderBTConnectorDelegate {
    func receivedTransactionBTNRMessage(_ message: NPRMessage?, isSignatureNeeded: Bool) {
        
        print("Mesage: \(String(describing: message))")
        self.authCode = message?.response?.responseCode
        if(message?.response?.responseCode == "00"){
            
            //Save transaction id to cancel sale
            transactionId = message?.order?.transaction?.transactionId
            orderId = message?.order?.orderId
            
            if(isSignatureNeeded){
                //Necesita firma, se enviara a una vista para firmar y guardar la firma
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "sign_segue", sender: self)
                })
            } else {
                //No necesita firma
                log(message: message)
            }
        } else {
            //Rechazada
            log(message: message)
        }
        self.readerBT?.resetPos()
        deviceConnected = false
        removeSpinner()
    }
    
    
    
    func receivedBTNRMessage(_ message: NPRMessage?) {
        self.readerBT?.resetPos()
        deviceConnected = false
        log(message: message)
        removeSpinner()
    }
    
    
    
    func transactionCancelled(message: String?) {
        removeSpinner()
        self.readerBT?.resetPos()
        deviceConnected = false
        
    }
    
    
    func log ( message: NPRMessage?){
        print("ResCode: \(String(describing: message?.response?.responseCode))")
        print("ResMessage: \(String(describing: message?.response?.responseMsg))")
        print("AuthCode: \(String(describing: message?.order?.transaction?.authCode))")
        print("Digits: \(String(describing: message?.order?.customer?.paymentMethod?.creditCard))")
        print("Customer: \(String(describing: message?.order?.hostName))")
        if let anAID = message?.order?.transaction?.aid{
            print("AID: \(anAID)")
        }
        print("ARQC: \(String(describing: message?.order?.transaction?.arqc))")
        print("transactionId: \(String(describing: message?.order?.transaction?.transactionId))")
        print("orderId: \(String(describing: message?.order?.orderId))")
        
        
        logMessage(":::::::::::::::::::::::::::::::::: Resp Demo ::::::::::::::::::::::::::::::::::")
        logMessage(message?.response?.responseCode)
        logMessage(message?.response?.responseMsg)
        logMessage(message?.order?.customer?.paymentMethod?.creditCard?.cardNumber)
        logMessage(message?.order?.transaction?.arqc)
        logMessage("::::::::::::::::::::::::::::::::::: Fin Resp :::::::::::::::::::::::::::::::::::")
        
        
        
        var string: String? = nil
        
        string = "Code:\(String(describing: message?.response?.responseCode)) \n Message:\(String(describing: message?.response?.responseMsg)) \n AuthCode:\(String(describing: message?.order?.transaction?.authCode)) \n Card:\(String(describing: message?.order?.customer?.paymentMethod?.creditCard?.cardNumber)) \n    \n AID:\(String(describing: message?.order?.transaction?.aid)) \n ARQC:\(String(describing: message?.order?.transaction?.arqc))"
        
        DispatchQueue.main.async(execute: {
            let alertView = UIAlertView(title: "Respuesta", message: string ?? "", delegate: self as UIAlertViewDelegate, cancelButtonTitle: "Cancel", otherButtonTitles: "")
            alertView.show()
        })
        
    }
    
    func viewReaderBTLog(_ message: String?) {
        
    }
    
    func onReturnObjects(_ objets: [AnyHashable]?) {
        removeSpinner()
        btDevicesArray = objets!
        print(String(format: "onReturnObjects: %lu", UInt(btDevicesArray.count)))
        if btDevicesArray.count > 0 {
            let alert = UIAlertController(title: "BT Devices", message: "Selecciona el dispositivo", preferredStyle: .actionSheet)
            for object in btDevicesArray {
                let action = UIAlertAction(title: object.description, style: .default) { (action) in
                    self.btDeviceSelected = object.description
                    self.terminalId = object.description
                    print("BT Selected: \(self.btDeviceSelected)")
                    let dvSelected = "BT Device Selected: \(self.btDeviceSelected)"
                    self.logMessage(dvSelected)
                    //Conect selected device
                    self.readerBT?.connect(self.btDeviceSelected)
                    self.showSpinner(onView: self.view)
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
    
    func onNoDeviceBTDetected() {
        logMessage("Dispositivo no detectado")
    }
    
    func onDeviceBTDetected() {
        removeSpinner()
        logMessage("Dispositivo conectado")
        deviceConnected = true
        if(waitingForConnectTransaction){
            waitingForConnectTransaction = false
            doTransaction()
        }
    }
    
    func onBatteryBTPercent(_ percent: String?) {
        logMessage("Bateria " + percent! + "%")
    }
    
    func onWaitingCardBT(_ cardResult: CardBTResult) {
        switch cardResult {
        case CardBTResult.cardResult_InsertOrSwipe:
            logMessage("Deslice o inserte tarjeta.")
        case CardBTResult.cardResult_BadSwipe:
            logMessage("Error de lectura. Deslice nuevamente.")
        case CardBTResult.cardResult_NoCard:
            logMessage("No se detectó tarjeta. Intentar nuevamente.")
        case CardBTResult.cardResult_UseIccCard:
            logMessage("Inserte el chip de la tarjeta.")
        case CardBTResult.cardResult_NotIccCard:
            logMessage("Error de lectura en Chip. Intentar nuevamente.")
        case CardBTResult.cardResult_NoResponse:
            logMessage("Sin respuesta. Intentar nuevamente.")
        case CardBTResult.cardResult_Declined:
            logMessage("Transacción declidada. Intentar nuevamente.")
        case CardBTResult.cardResult_PleaseWait:
            logMessage("Procesando transacción... Por favor espere.")
        case CardBTResult.cardResult_RemoveCard:
            logMessage("Remueva la tarjeta.")
        default:
            break
        }
    }
    
    func didResponseTransaction() {
        //Need to be declared to work
    }
    
    func onReturnDualCardTransaction(_ objects: [AnyHashable]?) {
        //Method for more than one card selection
        self.removeSpinner()
        let applicationAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        for (index, obj) in (objects?.enumerated())! {
            if let app = obj as? String {
                applicationAlert.addAction(UIAlertAction(title: app as String, style: .default, handler: { (action: UIAlertAction!) in
                    self.readerBT?.setSelectEmvApp(index)
                    self.showSpinner(onView: self.view)
                }))
            }
        }
        
        applicationAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: {
                self.readerBT?.resetPos()
                self.deviceConnected = false
            })
        }))
        present(applicationAlert, animated: true, completion: nil)
    }
}

extension ViewController : UIAlertViewDelegate {
    
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
            destination.npReader = self.readerBT
            destination.storeId = storeId
            destination.userName = userName
            destination.password = passWord
            destination.total = amount
            destination.orderId = orderId
            self.readerBT?.signatureDelegate = destination
            
            
        }
    }
}

extension ViewController :BTTransactionDelegate{
    
    func doTransactionWhenConnected() {
        doTransaction()
    }
}

public protocol BTTransactionDelegate {
    func doTransactionWhenConnected()
}

