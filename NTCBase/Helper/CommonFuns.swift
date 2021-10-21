//
//  CommonFuns.swift
//  Gron
//
//  Created by Abservetech on 06/03/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit


enum DateTimeFormatter : String{
    case Y_D_M = "yyyy-MM-dd"
    case YMD_T_HHSS = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case dYDM = "EEE,dd MMM yyyy"
    case DMY = "dd MMM YYYY"
    case MY = "MM/YYYY"
    case R_hour = "HH:mm"
    case N_hour = "hh:mm a"
    case date_time = "yyyy-MM-dd HH:mm"
    case date__time = "yyyy-MM-dd-HH:mm"
    case date_N_time = "yyyy-MM-dd hh:mm a"
    case N_date_time = "dd MMM , hh:mm a"
}


func showToast(msg : String ) {
    let window = UIApplication.shared.windows.first!
    let toastLabel = PaddingLabel()

    toastLabel.backgroundColor = UIColor.blackColor.withAlphaComponent(0.8)
    toastLabel.textColor = UIColor.whiteColor
    toastLabel.translatesAutoresizingMaskIntoConstraints = false
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont.systemFont(ofSize: 15)
    toastLabel.text = msg
    
    toastLabel.alpha = 1.0
    toastLabel.numberOfLines = 0
    toastLabel.lineBreakMode = .byWordWrapping
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    toastLabel.removeFromSuperview()
    window.addSubview(toastLabel)
    toastLabel.bringSubviewToFront(window)
    NSLayoutConstraint.activate([
        toastLabel.leadingAnchor.constraint(greaterThanOrEqualTo: window.leadingAnchor, constant: 20),
        toastLabel.trailingAnchor.constraint(lessThanOrEqualTo: window.trailingAnchor,constant: -20),
        toastLabel.bottomAnchor.constraint(greaterThanOrEqualTo: window.bottomAnchor, constant:  -55),
        toastLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
        toastLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
        toastLabel.centerXAnchor.constraint(equalTo: window.centerXAnchor)
        
    ])
    UIView.animate(withDuration: 4.0, delay: 0.0, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}




//MARK:- Past or Future date
func relativePast(for date : Date?) -> String {
    
    guard let date = date else {
        return .Empty
    }
    
    let units = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfYear])
    let components = Calendar.current.dateComponents(units, from: date, to: Date())
    
    if components.year! > 0 {
        return "\(components.year!) " + (components.year! > 1 ? "years ago" : "year ago")
        
    }
    else if components.month! > 0 {
        return "\(components.month!) " + (components.month! > 1 ? "months ago" : "month ago")
        
    }
    else if components.weekOfYear! > 0 {
        return "\(components.weekOfYear!) " + (components.weekOfYear! > 1 ? "weeks ago" : "week ago")
        
    }
    else if (components.day! > 0) {
        return (components.day! > 1 ? "\(components.day!) days ago" : "Yesterday")
        
    }
    else if components.hour! > 0 {
        return "\(components.hour!) " + (components.hour! > 1 ? "hours ago" : "hour ago")
        
    }
    else if components.minute! > 0 {
        return "\(components.minute!) " + (components.minute! > 1 ? "minutes ago" : "minute ago")
        
    }
    else {
        return "\(components.second!) " + (components.second! > 1 ? "seconds ago" : "second ago")
    }
}

func timeConvertor (time : String , _input: DateTimeFormatter, _output: DateTimeFormatter) -> String
   {
    if !time.isEmpty{
    var temp = time
    let strArr = time.split{$0 == ":"}.map(String.init)
        var hour : Int = 0
        var min : Int = 0
        if strArr.count >= 1{
            hour = Int(strArr[0]) ?? 0
          
        }
        if strArr.count >= 2{
            hour = Int(strArr[0]) ?? 0
             min = Int(strArr[1]) ?? 0
              
        }
      if(hour > 12){
        
          temp = "\((hour - 12)):\(min) " + "PM"
      }
      else{
          temp = temp + "AM"
      }
      return temp
    }
    return ""

   }
   
   func dateConvertor(_ date: String, _input: DateTimeFormatter, _output: DateTimeFormatter) -> String
   {
       let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = _input.rawValue
       let dates = dateFormatter.date(from: date)
      dateFormatter.dateFormat = _output.rawValue
    _ = dateFormatter.string(from: dates ?? Date())
       
       return  dateFormatter.string(from: dates ?? Date())
   }

func strToDate(_ strdate: String, _input: DateTimeFormatter, _output: DateTimeFormatter) -> Date{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = _input.rawValue
    _ = dateFormatter.date(from: strdate)
    dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT") as TimeZone?
    dateFormatter.dateFormat = _output.rawValue
    return dateFormatter.date(from:strdate) ?? Date()
}

func getcurrentDateTime(formate : DateTimeFormatter) -> String{
       let date = Date()
       let formatter = DateFormatter()
      formatter.dateFormat = formate.rawValue
       let result = formatter.string(from: date)
       return result
   }

func getcurrentTime(formate : DateTimeFormatter = .N_hour) -> String{
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = formate.rawValue
    let result = formatter.string(from: date)
    return result
}

func convertDateformate_24_to12 (_ time : String ,_input: DateTimeFormatter, _output: DateTimeFormatter) -> String
 {
     let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = _input.rawValue
    dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: Int(+5.30)) as TimeZone?
     
     let date = dateFormatter.date(from: time)
     dateFormatter.dateFormat = _output.rawValue
     let datestr = dateFormatter.string(from: date ?? Date())
     
     return datestr
 }


//MARK:- Create a ChatID

func getChatId(with requestId : Int?) -> String {

    guard  let requestId = requestId else {
        return ProcessInfo().globallyUniqueString }

    return "\(requestId)" //userId <= providerId ? "u\(userId)_p\(providerId)" : "p\(providerId)_u\(userId)"

}

//MARK:- ShowLoader

internal func createActivityIndicator(_ uiView : UIView)->UIView{
    
    let container: UIView = UIView(frame: CGRect.zero)
    container.layer.frame.size = uiView.frame.size
    container.center = CGPoint(x: uiView.bounds.width/2, y: uiView.bounds.height/2)
    container.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
    
    let loadingView: UIView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = container.center
    loadingView.backgroundColor = .primaryColor//UIColor(white:0.1, alpha: 0.7)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    loadingView.layer.shadowRadius = 5
    loadingView.layer.shadowOffset = CGSize(width: 0, height: 4)
    loadingView.layer.opacity = 2
    loadingView.layer.masksToBounds = false
    loadingView.layer.shadowColor = UIColor.gray.cgColor
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    actInd.clipsToBounds = true
    actInd.style = .large
    
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    container.isHidden = true
    uiView.addSubview(container)
    actInd.startAnimating()
    
    return container
    
}

 func setFont(to field :Any,isTitle : Bool = false, size : CGFloat = 0, fontType : FontCustom = .bold) {
    
    let customSize = size > 0 ? size : (isTitle ? size : 14)
    let font = UIFont(name: fontType.rawValue, size: customSize)
    
    switch (field.self) {
    case is UITextField:
        (field as? UITextField)?.font = font
    case is UILabel:
        (field as? UILabel)?.font = font
    case is UIButton:
        (field as? UIButton)?.titleLabel?.font = font
    case is UITextView:
        (field as? UITextView)?.font = font
    default:
        break
    }

}

//MARK:- Initilizing Number Formatter
private var numberFormatter : NumberFormatter?

private func initializeNumberFormatter(){
    
    if numberFormatter == nil {
        numberFormatter = NumberFormatter()
    }
//
//    func setFont(toField: Any?, size: CGFloat?, title: String?, isBold: Bool?,  textColor: UIColor?, backgroundColor: UIColor?, borderWidth: CGFloat?, borderColor: UIColor?, cornerRadius: CGFloat?){
//        
//        switch (toField) {
//        case is UILabel:
//            (toField as? UILabel)?.text = title
//            (toField as? UILabel)?.textColor = textColor
//            (toField as? UILabel)?.font = UIFont(name: isBold! ? FontCustom.Bold.rawValue : FontCustom.Regular.rawValue, size: size ?? 0)
//        case is UIButton:
//            (toField as? UIButton)?.setTitle(title, for: .normal)
//            (toField as? UIButton)?.setTitleColor(textColor, for: .normal)
//            (toField as? UIButton)?.backgroundColor = backgroundColor
//            (toField as? UIButton)?.layer.borderWidth = borderWidth ?? 0
//            (toField as? UIButton)?.layer.borderColor = borderColor!
//            (toField as? UIButton)?.layer.cornerRadius = cornerRadius
//
//
//        default:
//            <#code#>
//        }
//
//    }
//
//
//}
}


enum FontCustom : String {
    
    case meduim = "Quicksand-Medium"
    case bold = "Quicksand-Bold"
    case regular = "Quicksand-Regular"
    case light = "Quicksand-Light"
    
}
