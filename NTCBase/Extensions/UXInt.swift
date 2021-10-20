//
//  UXInt.swift
//  Base
//
//  Created by Basha's MacBook Pro on 26/03/21.
//  Copyright © 2021 AppleMac. All rights reserved.
//

import Foundation

extension Int {
    
    static func removeNil(_ val : Int?)->Int{
    
         return val ?? 0
    }
    
}


extension Float {
    
    static func removeNil(_ val : Float?)->Float{
        
        return val ?? 0
    }
    
}

extension Double {
    // Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
