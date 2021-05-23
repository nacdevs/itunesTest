//
//  ApiManager.swift
//  ApiManager
//
//  Created by Nestor on 19/05/2021.
//

import Foundation
public class ApiManagerService:NSObject {
    
    public static let shared = ApiManagerService()
    public let server = "https://rss.itunes.apple.com/api/v1/us/apple-music/"
    
    
    public typealias InitRequest = ()->Void
    public typealias FinishRequest = ()->Void
    public typealias ErrorResponse = (_ status:Int)->Void
    public typealias FatalResponse = ()->Void
    public typealias Response = (_ status:Int, _ response:[String:Any])->Void
    
    
    //MARK: All public functions
    
    public func get50Albums(
        onInitRequest:@escaping InitRequest,
        onFinishRequest: @escaping FinishRequest,
        onError: @escaping ErrorResponse,
        onFatal: @escaping FatalResponse,
        onResponse:@escaping (_ status: Int, _ response: [Album])->Void) {
        
        makeRequestGet(
            url: "\(server)coming-soon/all/50/explicit.json",
            onInitRequest: onInitRequest,
            onFinishRequest: onFinishRequest,
            onError: onError,
            onFatal: onFatal)
        { (status, jsonResponse) in
            onResponse(status, Album.getArray(json: jsonResponse))
        }
    }
    
    
    
    //MARK:BASE http request functions
    
    /// makeRequest overload for GET method
    func makeRequestGet(
        url:String,
        onInitRequest:@escaping InitRequest,
        onFinishRequest:@escaping FinishRequest,
        onError: @escaping ErrorResponse,
        onFatal: @escaping FatalResponse,
        onResponse:@escaping Response){
        makeRequest(
            url: url,
            params: nil,
            method: "GET",
            onInitRequest: onInitRequest,
            onFinishRequest: onFinishRequest,
            onError: onError,
            onFatal: onFatal,
            onResponse: onResponse
        )
    }
    
    
    ///Base function that make HTTP Requests
    func makeRequest(
        url:String,
        params: String?,
        method:String,
        onInitRequest:@escaping InitRequest,
        onFinishRequest:@escaping FinishRequest,
        onError: @escaping ErrorResponse,
        onFatal:@escaping FatalResponse,
        onResponse:@escaping Response){
        
        onInitRequest()
        print("123 init Request")
        print("123 url: \(url)")
        if (params != nil){
            
        }
        let urlFormatted = URL(string: url)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlFormatted)
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                print("123 error request")
                if (error as! URLError).code == URLError.notConnectedToInternet {
                    onError(800)
                }else{
                    if let stat = error as? URLError{
                        onError(stat.errorCode)
                    }
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("12 fullResponse \(json)")
                    let status = (response as! HTTPURLResponse).statusCode
                    if let a = json["feed"] as? [String:Any] {
                        onResponse(status,a)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
                
            }
        })
        
        task.resume()
        
        
    }
    
    
}

