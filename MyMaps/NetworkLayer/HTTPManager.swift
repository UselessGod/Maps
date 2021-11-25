//
//  HTTPManager.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 17.11.2021.
//

import Foundation
import Alamofire

extension Request {
    enum Endpoint:String {
        case none = ""
        case getUser = "/getUser"
        case uploadData = "/upload"
    }
    
    enum Method {
        case POST, GET
    }
}


struct Request {
    
    let host = "https://google.com"
    let endpoint = Endpoint.none
    let method = HTTPMethod.post
    let params = [String: Any]()
    
    var url: URLRequest? {
        var components = URLComponents()
        components.host = host
        components.path = endpoint.rawValue
        
        guard let _url = try? components.asURL() else { return nil}
        return try? URLRequest(url: _url, method: method, headers: nil)
    }
}

struct Response {
    var success = true
    var data = [String: Any]()
}

struct HTTPManager {
    static let shared = HTTPManager()
    
    private init() {}
    
    @discardableResult
    func request (_ req: Request, comletion: @escaping (Response) -> Void) -> URLSessionDataTask? {
        
        
        guard let url = req.url else { return nil }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, resp, error in
            guard let data = data else { return }
            
            let httpResponse = resp as? HTTPURLResponse
            
            var resp = Response()
            resp.success = (200...204).contains(httpResponse?.statusCode ?? 400)
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
               let dict = json as? [String: Any] {
                resp.data = dict
            }
            
            comletion(resp)
        }
        
        task.resume()
        return task
    }
}
