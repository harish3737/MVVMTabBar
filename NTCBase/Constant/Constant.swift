
import Foundation
import UIKit

struct R {
    struct Color {
       static var primary_color = "Primary"
        static var secondary_color = "Secondary"
       static var black_color = "Black"
       static var white_color = "White"
       static var gray_color = "Gray"
        static var light_gray = "PlaceHolder"
        static var offer_red = "Offer"
        static var unread_notify = "UnreaduNotify"
    }}



struct Constant {
    static var home = "Home"
    static var stats = "Stats"
    static var search = "Search"
    static var profile = "Profile"
    static var more = "More"
    
}

//MARK:- XIB Cell Names

struct XIB {
    
    static let Names = XIB()
    static var HomeTableViewCell = "HomeTableViewCell"
    static var CategoriesCollectionViewCell = "CategoriesCollectionViewCell"
    
}

extension Notification.Name {
    static let NotifyCount = Notification.Name("NotifyCount")
}
