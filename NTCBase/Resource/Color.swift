
import Foundation
import UIKit

extension UIColor {
    public static var primaryColor : UIColor{
        return  UIColor(named: R.Color.primary_color)!
    }
    public static var secondaryColor : UIColor{
           UIColor(named: R.Color.offer_red)!
       }
    
    public static var offerColor : UIColor{
           UIColor(named: R.Color.offer_red)!
       }
       
    public static var whiteColor : UIColor{
        if #available(iOS 13.0, *) {
           return UIColor(named: R.Color.white_color)!
        } else {
           return UIColor.white
        }
    }
    
    public static var blackColor : UIColor{
          if #available(iOS 13.0, *) {
             return UIColor(named: R.Color.black_color)!
          } else {
             return UIColor.black
          }
      }
    
    public static var grayColor : UIColor{
        if #available(iOS 13.0, *){
            return UIColor.systemGray
        }else{
            return UIColor(named: R.Color.gray_color)!
        }
    }
    
    public static var lightGrayColor : UIColor{
           if #available(iOS 13.0, *){
               return UIColor.systemGray2
           }else{
               return UIColor(named: R.Color.light_gray)!
           }
       }
    
    public static var unReadNotifyColor : UIColor{
        return UIColor(named: R.Color.unread_notify)!
    }
    
    // Secondary Color
    static var rating : UIColor {
        return #colorLiteral(red: 0.9921568627, green: 0.7882352941, blue: 0.1568627451, alpha: 1) //UIColor(red: 238/255, green: 98/255, blue: 145/255, alpha: 1)
    }
    public static var MenuGradiansuperTop : UIColor{
       Color(hex: "#2E6A18")//Color(hex: "#67A600") //1D8259
    }
    public static var MenuGradianTop : UIColor{
        UIColor(named: R.Color.primary_color)!//Color(hex: "#67A600") //1D8259
    }
    public static var MenuGradianMiddle : UIColor{
       Color(hex: "#67A600")// UIColor(named: R.Color.primary_color)!
    }
    public static var unReadNotify : UIColor{
        UIColor(named: R.Color.unread_notify)!
    }
    public static var MenuGradianBottom : UIColor{
        Color(hex: "#9EB936") //67A600
    }
    public static var yellowishGreen : UIColor{
        Color(hex: "#9EB936")
    }
    
    public static var infowWindow : UIColor{
        Color(hex: "#1F2124")
    }
    
   public static func randomColor() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 0.8
        )
    }
    
}


func Color (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)//scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
    
    
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
