//
//  EndPoint.swift
//  MarvelApp
//
//  Created by Dalia on 17/11/2023.
//

import Foundation
import Alamofire
import CryptoKit

protocol Endpoint: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var requestURL: URL { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var method: HTTPMethod { get }
    var urlRequest: URLRequest { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://gateway.marvel.com"
    }
    
    var requestURL: URL {
        return URL(string: baseURL + path)!
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
        
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.name)
        }
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
