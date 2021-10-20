//
//  EnumConstant.swift
//  Gron
//
//  Created by Abservetech on 11/03/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation

enum Gender : String{
    case female
    case male
}


// ENUM Chat Type

enum ChatType : Int {
    
    case single = 1
    case group = 2
    case media = 3
    
}

enum Language : String, CaseIterable {
    case english = "en"
    case arabic = "ar"
    
    var code : String {
        switch self {
        case .english:
            return "en"
        case .arabic:
            return "ar"
    }
    }
    
    var title : String {
        switch self {
        case .english:
            return StaticText.english
        case .arabic:
            return StaticText.arabic
       
        }
    }
    
      static var count: Int{ return 2 }
    }
    

enum RouteLocation {
    case PickupLocation
    case DropLocation
}


//MARK:- Constant KEYS

//Defaults Keys

struct Keys {
    
    static let list = Keys()
    
}


struct LocationManager : Equatable{
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var address : String = ""
    
    public static func ==(lhs: LocationManager, rhs: LocationManager) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && lhs.address == rhs.address
    }
}
