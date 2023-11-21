//
//  NetworkError.swift
//  MarvelApp
//
//  Created by Dalia on 17/11/2023.
//

import Foundation

struct ResponseError: Error, Decodable {
    var code: Int
    var message: String
    var path: String
    
    init(code: Int, path: String) {
        self.code = code
        self.path = path
        switch code {
        case 409:
            message = "Missing API Key"
        case 401:
            message = "Invalid Referer"
        case 403:
            message = "Forbidden"
        case 405:
            message = "Method Not Allowed"
        default:
            message = "Unknown error"
        }
    }
}
enum NetworkError: Error {
    case missingAPIKey
    case invalidReferer
    case forbidden
    case methodNotAllowed
    case unknownError(String)
}
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingAPIKey: return "Missing API Key"
        case .invalidReferer: return "Invalid Referer"
        case .forbidden: return "Forbidden: Make sure you have permission to access this resource"
        case .methodNotAllowed: return "Method Not Allowed"
        case .unknownError(let message): return message
        }
    }
}
