
import Foundation

struct HttpError{
    static let noInternet = "Please check your internet connection"
    static let apiConnection = "Check api Method, network connetion , this error from app side only"
    static let serverError = "Api server Error , Check with backend Geeks"
    static let somthingWentWrong = "SomeThing Went Wrong"
    static let decodeError = "Cannot Decode the Response. "
}

struct Api{
    static let baseURL   = "http://35.203.108.237/"
    static let imageURL = ""
    static let tc = ""
    static let socketURL = ""
    
    static let googleGeocodeURL = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
    static let googleRouteBaseUrl = "https://maps.googleapis.com/maps/api/directions/json?origin="
    static let userAppStoreLink = "https://apps.apple.com/us/app/id1465261707"
    
     struct LoginSignup{
        static let login = "oauth/token"
        static let signup = "api/user/signup"
        static let forgot = "api/user/forgot/password"
        static let resetPassword = "api/user/reset/password"
    }
    
    struct RequestFlow {
        static let serviceList = "api/user/services"
        static let estimatedFare = "api/user/estimated/fare"
    }
    
    struct profile {
        static let getProfile = "api/user/details"
    }
}


extension Int{
    func isResponseOK() -> Bool{
        return (200...299).contains(self)
    }
}
