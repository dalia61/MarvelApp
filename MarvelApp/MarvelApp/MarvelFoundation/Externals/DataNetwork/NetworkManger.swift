//
//  NetworkManger.swift
//  MarvelApp
//
//  Created by Dalia on 17/11/2023.
//

import Foundation
import Alamofire

protocol NetworkProtocol: AnyObject {
    typealias CallResponse<T> = ((Result<T, NetworkError>) -> Void)?
    func callRequest<T>(_ object: T.Type, data: MultipartData?, endpoint: Endpoint,
                        onComplete: @escaping ((Result<T, NetworkError>) -> Void)) where T: Codable
}

struct MultipartData {
    var data: Data
    var fileName, mimeType, name: String
}

class AlamofireManager {
    static let shared: AlamofireManager = AlamofireManager()
    
    func callRequest<T: Decodable>(_ object: T.Type, endpoint: Endpoint,
                                   onComplete: @escaping (Result<T, NetworkError>) -> Void) {
        let request = AF.request(endpoint.requestURL, parameters: endpoint.parameters)
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let statusCode = response.response?.statusCode else {
                    onComplete(.failure(.unknownError("Unknown error")))
                    return
                }
                
                switch statusCode {
                case 200...299:
                    do {
                        if let data = response.data {
                            let decoder = JSONDecoder()

                            let model = try decoder.decode(T.self, from: data)
                            onComplete(.success(model))
                        } else {
                            onComplete(.failure(.unknownError("No data in response")))
                        }
                    } catch let error {
                        print("Decoding Error: \(error)")
                        onComplete(.failure(.unknownError("Failed to decode response")))
                    }
                case 401:
                    onComplete(.failure(.missingAPIKey))
                case 403:
                    onComplete(.failure(.forbidden))
                case 405:
                    onComplete(.failure(.methodNotAllowed))
                default:
                    onComplete(.failure(.unknownError("Unknown error")))
                }
            case .failure(let error):
                print("Request failed: \(error)")
                onComplete(.failure(.unknownError("Network request failed")))
            }
        }
    }
}

