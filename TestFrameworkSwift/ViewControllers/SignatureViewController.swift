//
//  SignatureView.swift
//  TestFrameworkSwift
//
//  Created by Mario Ramirez on 1/31/19.
//  Copyright © 2019 Mario Ramirez. All rights reserved.
//


import UIKit
import NPBTSPaymentConnector


class SignatureViewController: UIViewController {
    
    @IBOutlet weak var eraseBtn: UIButton!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var signView: UIImageView!
    
    var isSigned = false
    var cgContext : CGContext?
    var authDate : String?
    var authTime : String?
    var authCode : String?
    var total : String?
    var storeId : String?
    var userName : String?
    var password : String?
    var orderId : String?
    var amount : Double?
    var totalAcum = 0.0
    var npMessage : NPMessage?
    
    var vSpinner : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        //        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        eraseAction(nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var topSafeArea: CGFloat
        var bottomSafeArea: CGFloat
        
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        
        //signView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        finishBtn.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        eraseBtn.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        signView.frame = view.frame
        finishBtn.frame = CGRect(x: view.frame.width - 60, y: topSafeArea, width: 60, height: view.frame.height - topSafeArea - bottomSafeArea)
        eraseBtn.frame = CGRect(x: 0, y: topSafeArea, width: 50, height: 150)
        
        //        finishBtn.backgroundColor = UIColor(red: 12/255, green: 233/255, blue: 148/255, alpha:1)
       
        //        finishBtn.roundCorners(cornerRadius: 16.0)
    }
    
    func handleTouches(touches: Set<UITouch>) {
        for touch in touches {
            isSigned = true
            
            if touch.phase == .began {
                let currentLocation = touch.location(in: signView)
                let previousLocation = touch.previousLocation(in: signView)
                
                drawLineRect(startPoint: previousLocation, endPoint: currentLocation)
            } else if touch.phase == .moved {
                let currentLocation = touch.location(in: signView)
                let previousLocation = touch.previousLocation(in: signView)
                
                drawLineRect(startPoint: previousLocation, endPoint: currentLocation)
            }
        }
    }
    
    func drawLineRect(startPoint: CGPoint, endPoint: CGPoint) {
        UIGraphicsBeginImageContext(signView.frame.size)
        
        cgContext = UIGraphicsGetCurrentContext()!
        
        signView.image?.draw(in: CGRect(x: 0, y: 0, width: signView.frame.width, height: signView.frame.height))
        
        cgContext!.move(to: startPoint)
        cgContext!.addLine(to: endPoint)
        cgContext!.setLineWidth(3.0)
        cgContext!.setBlendMode(.normal)
        cgContext!.setLineCap(.round)
        cgContext!.setStrokeColor(UIColor.black.cgColor)
        cgContext!.strokePath()
        
        self.signView.image = UIGraphicsGetImageFromCurrentImageContext()
        self.signView.alpha = 1.0
        UIGraphicsEndImageContext()
    }
    
    func addWaterMark() {
        let waterMarkText = "\(authDate!) \(authTime!) \(authCode!)  \(authDate!) \(authTime!) \(authCode!) \(authDate!) \(authTime!) \(authCode!)"
        
        var waterMarkTextExt = waterMarkText
        
        for _ in 0...15 {
            waterMarkTextExt = "\(waterMarkTextExt)\n\(waterMarkText)"
        }
        
        signView.image = drawText(text: waterMarkTextExt as NSString, image: signView.image!, point: CGPoint(x: 0, y: 0))
    }
    
    
    func drawText(text: NSString, image: UIImage, point: CGPoint)->UIImage {
        UIGraphicsGetCurrentContext()
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .left
        
        let font = UIFont.systemFont(ofSize: 14)
        
        let attributes : Dictionary = [NSAttributedString.Key.font: font ,
                                       NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                       NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                       ]
        
        text.draw(at: point, withAttributes: attributes as [NSAttributedString.Key : Any])
        
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        newImage = newImage?.rotate(radians: -CGFloat.pi / 2)
        
        return newImage!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches: touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches: touches)
    }
    
    @IBAction func eraseAction(_ sender: Any?) {
        isSigned = false
        signView.image = UIImage(named: "signBlank")
        addWaterMark()
    }
    
    @IBAction func finishAction(_ sender: Any) {
        if isSigned {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 300, width: 200, height: 200))
            imageView.image = signView.image
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
            
            // NPMyTransaction.sharedSingleton().signatureImage = imageView.image
            NPAPIClient.saveSign(orderId: self.orderId, totalAmount: self.total, imageTicket: getImageBase64(image: imageView.image!), user: self.userName, password: self.password) { result in
                switch result {
                case .success(_):
           
                    self.dismiss(animated: true) {}

                case .failure(_):
                    //error
                    
                    //Manejo de Error
                    let a = ""
                }
            }
            

        } else {
            //   ADVICE favor de firmar
        }
    }
    
    func getImageBase64(image: UIImage)-> String {
        let newImage = image.rotate(radians: CGFloat.pi / 2)
        
        let signatureImg = newImage!.pngData()
        var imageBase64 = ""
        if let _ = signatureImg {
            imageBase64 = signatureImg!.base64EncodedString()
            let escapeSet = NSCharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ")
            imageBase64 = imageBase64.addingPercentEncoding(withAllowedCharacters: escapeSet.inverted)!
        }
        
        return imageBase64
    }
    
    

    
 
    func changeToCurrency(price: String)->String {
        let val = Double(price)
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let amountStr = formatter.string(from: NSNumber(value: val!))
        return amountStr!
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

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}




