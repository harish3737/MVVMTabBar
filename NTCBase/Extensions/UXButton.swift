
import UIKit
import Foundation

public enum FontType : String{
    case bold = "Calibri-Bold"
    case light = "Calibri-Light"
    case regular = "Calibri-Regular.ttf"
}




extension UIButton{
    
    func setText(string:String?) {
        
        self.setTitle(string, for: .normal)
    }
    
    public func setAttributedText(_ textKey : String , _ size : Int = 20 , _ type : FontType = .bold,textColor color : UIColor = UIColor.white , bgColor : UIColor = UIColor.primaryColor,isUnderline:Bool = false){

        self.backgroundColor = bgColor
        let textRange = NSRange(location: 0, length: textKey.count)
        let customButtonTitle = NSMutableAttributedString(string: Localizations.instance.stringForKey(key: textKey), attributes:                                                            [
            NSAttributedString.Key.font:UIFont(name: type.rawValue, size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size)),
            NSAttributedString.Key.foregroundColor : color
        ])
        if isUnderline{
            customButtonTitle.addAttributes([NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue], range:textRange)
        }
        
        self.setAttributedTitle(customButtonTitle, for: .normal)
    }
    
    
    func setImage(_ name : AssetName , _ withTint : YesNoType = .no, _ withTintColor : UIColor = UIColor.whiteColor ){
            if withTint == .no{
                self.setImage((UIImage(named: name.rawValue) ?? UIImage()), for: .normal)
               
            }else{
                if #available(iOS 13.0, *) {
                    self.setImage((UIImage(named: name.rawValue) ?? UIImage()).withTintColor(withTintColor), for: .normal)
                   
                } else {
                    if let TintImage = (UIImage(named: name.rawValue)){
                        let tintableImage = TintImage.withRenderingMode(.alwaysTemplate)
                      
                        self.setImage(tintableImage, for: .normal)
                    }
                    self.tintColor = withTintColor
                    self.setImage(self.image(for: .normal)?.imageWithColor(color: UIColor.white ), for: .normal)
                }
            }
        }
}
