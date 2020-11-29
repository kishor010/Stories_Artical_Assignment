//
//  NetworkRouter.swift
//  Assignment
//
//  Created by Kishor Pahalwani on 15/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//

import Foundation

private let requestTimeOut: TimeInterval = 60

class NetworkRouter {
    
    enum Router {
        
        //MARK:- Case
        case getStoryList
        case getItemDetails(item: String)
        
        //MARK:- HTTP Method
        var method: String {
            switch self {
            case .getStoryList:
                return "GET"
            case .getItemDetails:
                return "GET"
            }
        }
        
        //MARK: Base URL
        var baseUrl: String {
            return EndPoints.baseURL
        }
        
        //MARK:- API Path
        var path: String {
            switch self {
            case .getStoryList:
                return EndPoints.stories
            case .getItemDetails(let id):
                return "item/\(id).json?print=pretty"
            }
        }
    
        //Method URLRequest
        func asURLRequest() -> URLRequest? {
            if let url =  URL(string: baseUrl + path) {
                var urlRequest = URLRequest(url:url)
                urlRequest.httpMethod = method
                urlRequest.timeoutInterval = requestTimeOut
                urlRequest.allowsCellularAccess = true
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                return urlRequest
            }
                
            else {
                return nil
            }
        }
    }
}





