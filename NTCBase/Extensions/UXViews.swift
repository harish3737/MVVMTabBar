//
//  UXViews.swift
//  Wddi
//
//  Created by Shyamala's MacBook Pro on 05/05/21.
//  Copyright © 2021 AppleMac. All rights reserved.
//

import UIKit

private var AssociatedObjectHandle: UInt8 = 25
private var ButtonAssociatedObjectHandle: UInt8 = 10
var selectedLanguage : Language = .english

public enum closureActions : Int{
    case none = 0
    case tap = 1
    case swipe_left = 2
    case swipe_right = 3
    case swipe_down = 4
    case swipe_up = 5
}

public struct closure {
    typealias emptyCallback = ()->()
    static var actionDict = [Int:[closureActions : emptyCallback]]()
    static var btnActionDict = [Int:[String: emptyCallback]]()
}

extension UIView{
    
    var closureId:Int{
        get {
            let value = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? Int ?? Int()
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTap(Action action:@escaping ()->Void){
        self.actionHandleBlocks(.tap,action:action)
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(triggerTapActionHandleBlocks))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
    
    func actionHandleBlocks(_ type : closureActions = .none,action:(() -> Void)? = nil) {
        
        if type == .none{
            return
        }
        var actionDict : [closureActions : closure.emptyCallback]
        if self.closureId == Int(){
            self.closureId = closure.actionDict.count + 1
            closure.actionDict[self.closureId] = [:]
        }
        if action != nil {
            actionDict = closure.actionDict[self.closureId]!
            actionDict[type] = action
            closure.actionDict[self.closureId] = actionDict
        } else {
            let valueForId = closure.actionDict[self.closureId]
            if let exe = valueForId![type]{
                exe()
            }
        }
    }
    
    @objc func triggerTapActionHandleBlocks() {
        self.actionHandleBlocks(.tap)
    }
}


// MARK: - custom UI appearance

extension UIView{
    
    var identifiers : String{
          return "\(self)"
      }
    
    @objc func initView(view: UIView , vc : UIViewController) -> UIView{
          return self
      }
    
    @objc func deInitView(view: UIView , vc : UIViewController) -> UIView{
        removeFromSuperview()
        return self
    }
}


extension UIView{
    func setCorneredElevation(shadow With : Int = 2 , corner radius : Int = 20 , color : UIColor = UIColor.clear){
//        self.layer.masksToBounds = false
//        self.clipsToBounds  = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = .zero//CGSize(width: With, height: With)
        self.layer.shadowRadius = CGFloat(With)
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func blurViews(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.5
        self.addSubview(blurEffectView)
    }
    
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowRadius = CGFloat(15)
    }
    
    func circleView(){
        self.layer.cornerRadius = self.layer.frame.width/2
        self.clipsToBounds = true
    }
    
    func setCorneredElevation(shadow With : Int = 1, corner radius : Int = 0 , color : UIColor = .clear , clipstobound : YesNoType = .no , borderColor: UIColor = .clear , borderWidth: CGFloat = 0){
        self.layer.masksToBounds = false
        self.clipsToBounds = clipstobound == .no ? false : true
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: With, height: With)
        self.layer.shadowRadius = CGFloat(With)
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
    }
    
    func setGradientLayer(colorsuperTop : UIColor ,colorTop : UIColor , colormiddle : UIColor , colorBottom : UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: -10, y: 0, width: self.frame.width + 10, height: self.frame.height + 70)
        gradientLayer.colors = [colorsuperTop.cgColor,colorTop.cgColor, colormiddle.cgColor, colorBottom.cgColor]
        self.layer.addSublayer(gradientLayer)
        self.backgroundColor = .clear
    }
    
    func setGradientLayer(colorTop : UIColor , colormiddle : UIColor , colorBottom : UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: -10, y: 0, width: self.frame.width + 10, height: self.frame.height + 70)
        gradientLayer.colors = [colorTop.cgColor, colormiddle.cgColor, colorBottom.cgColor]
        self.layer.addSublayer(gradientLayer)
        self.backgroundColor = .clear
    }
    
    
    
    
    func addDashedBorder(color : UIColor = .red) {
        let color = color.cgColor

       let shapeLayer:CAShapeLayer = CAShapeLayer()
       let frameSize = self.frame.size
       let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

       shapeLayer.bounds = shapeRect
       shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
       shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
       shapeLayer.lineWidth = 1
       shapeLayer.lineJoin = CAShapeLayerLineJoin.round
       shapeLayer.lineDashPattern = [6,3]
       shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

       self.layer.addSublayer(shapeLayer)
       }
    
    
    func setText(_ textKey : String , _ size : Int = 16 , fontStyle type : FontType = .regular , textColor color : UIColor = UIColor.blackColor){
       
        let viewType = self
        let font = UIFont(name: type.rawValue, size: CGFloat(size))

        switch (viewType.self) {
        case is UITextField:
            (viewType as? UITextField)?.font = font
            (viewType as? UITextField)?.text = textKey
            (viewType as? UITextField)?.textColor = color
            if [NSTextAlignment.left, .right].contains((viewType as! UITextField).textAlignment) {
                (viewType as? UITextField)?.textAlignment = (selectedLanguage == .arabic) ? .right : .left
            }
        case is UILabel:
            (viewType as? UILabel)?.font = font//UIFont(name: isTitle ? FontCustom.avenier_Heavy.rawValue : FontCustom.avenier_Medium.rawValue, size: customSize)
            (viewType as? UILabel)?.text = textKey
            (viewType as? UILabel)?.textColor = color
            if [NSTextAlignment.left, .right].contains((viewType as! UILabel).textAlignment) {
                (viewType as? UILabel)?.textAlignment = (selectedLanguage == .arabic) ? .right : .left
            }
            
        case is UIButton:
            (viewType as? UIButton)?.titleLabel?.font = font
            (viewType as? UIButton)?.setTitle(textKey, for: .normal)
            (viewType as? UIButton)?.setTitleColor(color, for: .normal)
            if [UIControl.ContentHorizontalAlignment.left, .right].contains((viewType as! UIButton).contentHorizontalAlignment) {
                (viewType as! UIButton).contentHorizontalAlignment = (selectedLanguage == .arabic) ? .right : .left
            }
            
        
            
        case is UITextView:
            (viewType as? UITextView)?.font = font
            (viewType as? UITextView)?.text = textKey
            (viewType as? UITextView)?.textColor = color
            //(field as? UITextView)?.textAlignment = (selectedLanguage == .arabic && (field as! UITextView).textAlignment == .left) ? .right : .left


        default:
            break
        }
      }
    
    
}

extension UIView {
    func createDottedLine(width: CGFloat, color: CGColor) {
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = color
        lineLayer.lineWidth = width
        lineLayer.lineDashPattern = [2,3]
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: self.frame.width / 2, y: 0),
                                CGPoint(x: self.frame.width / 2, y: self.frame.height)])
        lineLayer.path = path
        self.layer.addSublayer(lineLayer)
    }
}


//Mark:- Animation
extension UIView{
    func removeView(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.alpha = 0.8
            var height = self.frame.height;
            self.frame = CGRect(x: Int(self.frame.minX), y: Int(self.superview?.frame.height ?? 0), width: Int(self.frame.maxX), height: Int(height))
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    func showView(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.alpha = 0.8
            var height = self.frame.height;
            self.frame = CGRect(x: Int(self.frame.minX), y: Int(self.superview?.frame.height ?? 0), width: Int(self.frame.maxX), height: Int(height))
        }) { _ in
            self.superview?.addSubview(self)
        }
    }

    func hiddeShowView(ishide : Bool){
        self.alpha = CGFloat(ishide ? 1 : 0)
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.showHideTransitionViews, animations: { () -> Void in
            self.alpha = CGFloat(!ishide ? 1 : 0)
            self.isHidden = ishide
        }, completion: { (Bool) -> Void in  }
        )
    }
    
    
    func dottedBorder(){
        var yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.black.cgColor
        yourViewBorder.lineDashPattern = [4, 4]
        yourViewBorder.frame = self.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(yourViewBorder)
    }
}

extension UIView {
    
    //Set view corner radius with given value
    func setCornerRadiuswithValue(value: CGFloat) {
        self.maskToBounds = true
        self.layer.cornerRadius = value
    }
                                                                   
    //MARK:- Mask To Bounds
    
    @IBInspectable
    var maskToBounds : Bool {
        get {
            return self.layer.masksToBounds
        }
        set(newValue) {
            
            self.layer.masksToBounds = newValue
            
        }
    }
}
                                                                                                  
