

import Foundation
import SystemConfiguration
import UIKit

struct Resource<T>{
//    var vc : UIViewController
    var url : String
    var method : HTTPMethods
    var params : [String : Any]? = nil
//    var parse : (Data) -> T?
}

enum isBaseApiURL {
    case yes
    case no
    case settingurl
}

enum HTTPMethods : String{
    case get     = "GET"
    case post    = "POST"
    case delete  = "DELETE"
    case put     = "PUT"
    case patch   = "PATCH"
    
}

enum ApiClientError : Error{
    case noInternet
    case apiConnection
    case serverError
    case DecodeError
    
}

extension ApiClientError : LocalizedError{
    var errorDescription : String?{
        switch self {
        case .noInternet :
            return HttpError.noInternet.localize
        case .apiConnection :
            return HttpError.apiConnection.localize
        case .serverError :
            return HttpError.serverError.localize
            
        case .DecodeError :
            return HttpError.decodeError.localize
        }
    }
}

public class Reachability {
    public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        if flags.isEmpty {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
}

class WebService {
    public static var shared = WebService()
    private static var ContentType_HeaderKey = "Content-Type"
    private static var Authorization_HeaderKey = "Authorization"
//    Resource<T>

    func loadData<T : Codable>(resource : Resource<T> , withAppURL isbase : isBaseApiURL = .yes , isLoaderNeed : YesNoType = .yes ,complition : @escaping (Swift.Result<T,ApiClientError> , _ statusCode : Int ) -> Void){
       
        
//        let loader  : UIView = {
//            return createActivityIndicator(resource.vc.view)
//        }()
        
        if Reachability().isConnectedToNetwork(){

            
            var urlString : String = isbase == .yes ? (Api.baseURL + resource.url) : (Api.baseURL + resource.url)
         
            if resource.method == .get{
                let getParam = resource.params ?? ["" : ""]
                urlString = urlString + "?" + getParam.queryString
            }
            guard let url : URL = URL(string: urlString) else {
                Log.er("URLError,\(urlString)")
                return}
         
               
            var request  = URLRequest(url:url)
            request.httpMethod = resource.method.rawValue
            if isLoaderNeed == .yes {
//                loader.isHidden = false
//                resource.vc.view.endEditing(true)
            }
            
            guard let httpbody = try? JSONSerialization.data(withJSONObject: resource.params ?? ["" : ""], options: []) else {return}
            if resource.method != .get{
                request.httpBody = httpbody
            }
            request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(UserDefaultConfig.Token)", forHTTPHeaderField: WebService.Authorization_HeaderKey)//"Authorization")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.sync {
//                     if isLoaderNeed == .yes {
//                        loader.isHidden = true
//                    }
                }
                if error != nil{
                    Log.er(url : urlString ,"\(resource.params ?? [:]) ")
                    complition(.failure(.apiConnection), 0)
                    return
                }
                guard let response = response as? HTTPURLResponse  else{
                    guard data != nil else { return }
                    
                    complition(.failure(.serverError), 0)
                    return
                }
                guard let data = data else {
                    complition(.failure(.noInternet), 0)
                    return
                }
                let jsonStr = String(data: data, encoding: .utf8)
                    Log.rq(url : urlString ,"\(resource.params ?? [:]) ===> \(jsonStr ?? "")====>\(UserDefaultConfig.Token) =====? \(T.self)")
                    guard let responseData = try? JSONDecoder().decode(T.self, from: data) else {
                        Log.er(url : urlString ,"Cont Decode, check you Model")
                        return
                    }
                    DispatchQueue.main.sync {
                        complition(.success(responseData), (response).statusCode)
                }
            }.resume()
        }else{
           showToast(msg: "Check your internet")
        }
    }
    
    
    func imageUpload<T : Codable>(resource : Resource<T> , withAppURL isbase : isBaseApiURL = .yes , isLoaderNeed : YesNoType = .yes,imageToUpload : [ImageWithKey] ,complition : @escaping (Swift.Result<T,ApiClientError> , _ statusCode : Int ) -> Void){
        
//        let loader  : UIView = {
//            return createActivityIndicator(resource.vc.view)
//        }()
        
        if Reachability().isConnectedToNetwork(){
            let urlString : String = isbase == .yes ? (Api.baseURL + resource.url) :(Api.baseURL + resource.url)
            guard let url : URL = URL(string: urlString) else {return}
            var request  = URLRequest(url:url)
            request.httpMethod = resource.method.rawValue
//            resource.vc.view.endEditing(true)
            
            let boundary = generateBoundary()
            var mediaData = [Media]()
            for image in imageToUpload{
                guard let mediaImage = Media(withImage: image.image ?? UIImage(), forKey: image.key ?? "") else {
                    Log.er(url: urlString, "Error in Image upload")
                    return
                }
                mediaData.append(mediaImage)
            }
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            let parameters = resource.params ?? ["" : ""]
            
            let dataBody = createDataBody(withParameters: parameters, media: mediaData, boundary: boundary)
            
            if resource.method != .get{
                request.httpBody = dataBody
            }
            
            request.setValue("Bearer \(UserDefaultConfig.Token)", forHTTPHeaderField: "Authorization")
            if isLoaderNeed == .yes {
//                loader.isHidden = false
            }
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.sync {
//                    loader.isHidden = false
                }
                if error != nil{
                    complition(.failure(.apiConnection), 0)
                    Log.rq(url : urlString ,"\(resource.params ?? [:]) \(imageToUpload) ===> \(error! )====>\(UserDefaultConfig.Token) =====? \(T.self)")
                                
                    return
                }
                guard let response = response as? HTTPURLResponse  else{
                    guard data != nil else { return }
                    
                    complition(.failure(.serverError), 0)
                    return
                }
                guard let data = data else {
                    complition(.failure(.noInternet), 0)
                    return
                }
                let jsonStr = String(data: data, encoding: .utf8)
                    Log.rq(url : urlString ,"\(resource.params ?? [:]) \(imageToUpload)===> \(jsonStr ?? "")====>\(UserDefaultConfig.Token) =====? \(T.self)")
                    guard let responseData = try? JSONDecoder().decode(T.self, from: data) else {
                        Log.er("Cant Decode, check you Model")
                        complition(.failure(.DecodeError), 0)
                        return
                    }
                    DispatchQueue.main.sync {
                        complition(.success(responseData), (response).statusCode)
                    }
                
            }.resume()
        }else{
            showToast(msg: "Check your internet")
        }
    }
    
}


func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
      
      let lineBreak = "\r\n"
      var body = Data()
      
      if let parameters = params {
          for (key, value) in parameters {
              body.append("--\(boundary + lineBreak)")
              body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
              body.append("\(value)" + "\(lineBreak)")
          }
      }
      
      if let media = media {
          for photo in media {
              body.append("--\(boundary + lineBreak)")
              body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
              body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
              body.append(photo.data)
              body.append(lineBreak)
          }
      }
      
      body.append("--\(boundary)--\(lineBreak)")
      return body
  }
  
  func generateBoundary() -> String {
      return "Boundary-\(UUID().uuidString)"
  }


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "\(arc4random()).jpeg"
        
        
        if let data = image.jpegData(compressionQuality: 0.7 ){
            self.data = data
        } else {
            self.data = Data()
        }
       
    }
    
}
struct ImageWithKey {
     let key: String?
     let image: UIImage?
      
}

typealias Parameters = [String: Any]

extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}
