//
//  NetworkManager.swift
//  Assignment
//
//  Created by Kishor Pahalwani on 15/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON


typealias onSuccess = (JSON)->()
typealias onFailure = (String)->()

private let _sharedInstance = NetworkManager()
private let DEBUG_MODE = false

class NetworkManager {
    
    //MARKS: Shared Instance
    private let restClient = RestClient()
    
    fileprivate init(){}
    
    static var sharedInstance: NetworkManager {
        return _sharedInstance
    }
    
    //MARK: Network Call Methods
    func apiToGetStoryList(onSuccess: @escaping onSuccess,
                        onFailure: @escaping onFailure)  {
        let _url = NetworkRouter.Router.getStoryList
        
        if let request = _url.asURLRequest() {
            restClient.makeRequest(url: request, onSuccess: onSuccess, onFailure: onFailure)
        }
        else {
            onFailure("Url is not proper")
        }
    }
    
    func apiToGetItemDetails(itemId: String, onSuccess: @escaping onSuccess,
                             onFailure: @escaping onFailure) {
        
        let _url = NetworkRouter.Router.getItemDetails(item: itemId)
        if let request = _url.asURLRequest() {
            restClient.makeRequest(url: request, onSuccess: onSuccess, onFailure: onFailure)
        }
        else {
            onFailure("Url is not proper")
        }
    }
}

// MARK: - REST CLIENT -
fileprivate class RestClient {
    
    fileprivate func makeRequest(url: URLRequestConvertible,
                                 onSuccess: @escaping onSuccess,
                                 onFailure: @escaping onFailure
        ) -> Void {
        
        AF.request(url)
            .validate()
            .responseJSON { response in
                
                if DEBUG_MODE {
                    print("--------START---------")
                    print(response) // print response
                    print(response.request ?? "")  // original URL request
                    print(response.response ?? "") // HTTP URL response
                    print(response.data ?? "")     // server data
                    print(response.result)   // result of response serialization
                    print(url)
                }
                
                if response.response?.statusCode == 200 {
                    switch response.result {
                    case .success:
                        if let result = try? response.result.get() {
                            let json = JSON(result)
                            onSuccess(json)
                        }
                        break
                        
                    case .failure:
                        print("failure \(response)")
                        onFailure(response.error?.localizedDescription ?? "Error")
                        break
                    }
                }
                
                else {
                    if response.response?.statusCode == 404 {
                         onFailure("Data Not Found")
                    }
                    
                    else {
                        onFailure(response.error?.localizedDescription ?? "Error")
                    }
              }
         }
    }
}
