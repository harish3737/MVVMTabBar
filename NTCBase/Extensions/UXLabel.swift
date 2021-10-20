

import Foundation
import UIKit


public enum YesNoType {
    case yes
    case no
}

public enum inputType{
    case password
    case phoneNumber
    case email
    case none
}

class SelectableLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = true
        addGestureRecognizer(
            UILongPressGestureRecognizer(
                target: self,
                action: #selector(handleLongPress(_:))
            )
        )
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }

    // MARK: - UIResponderStandardEditActions

    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }

    // MARK: - Long-press Handler

    @objc func handleLongPress(_ recognizer: UIGestureRecognizer) {
        if recognizer.state == .began,
            let recognizerView = recognizer.view,
            let _ = recognizerView.superview {
            
            UIMenuController.shared.showMenu(from: recognizerView, rect: recognizerView.frame)
//            UIMenuController.shared.isMenuVisible = true
//            UIMenuController.shared.setMenuVisible(true, animated:true)
            recognizerView.becomeFirstResponder()
        }
    }

}



extension UILabel{

    func imageWithText(image : UIImage , textKey : String){
        let imageAttribute = NSTextAttachment()
        imageAttribute.image = image
        
        let attributedText = NSAttributedString(attachment: imageAttribute)
        
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(attributedText)
        fullString.append(NSMutableAttributedString(string: "  "))
        fullString.append(NSMutableAttributedString(string: textKey.localize))
        
        self.attributedText = fullString
        self.textColor = UIColor.white
    }
    
   
}

class PaddingLabel: UILabel {

   @IBInspectable var topInset: CGFloat = 10.0
   @IBInspectable var bottomInset: CGFloat = 10.0
   @IBInspectable var leftInset: CGFloat = 10.0
   @IBInspectable var rightInset: CGFloat = 10.0

   override func drawText(in rect: CGRect) {
      let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: rect.inset(by: insets))
   }

   override var intrinsicContentSize: CGSize {
      get {
         var contentSize = super.intrinsicContentSize
         contentSize.height += topInset + bottomInset
         contentSize.width += leftInset + rightInset
         return contentSize
      }
   }
}
