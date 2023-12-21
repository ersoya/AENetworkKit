//
//  NetworkRequestCreator.swift
//
//
//  Created by Arda Ersoy on 15.12.2023.
//

import Foundation

struct NetworkRequestCreator {
    
    static func request(for task: NetworkTask) -> URLRequest {
        var components: URLComponents = URLComponents(string: task.base.appending(task.path))!
        components.queryItems = []
        
        task.urlParameters?.forEach({
            let query: URLQueryItem = .init(name: $0.key, value: "\($0.value)")
            components.queryItems?.append(query)
        })
        
        let url: URL = components.url!
        var request: URLRequest = URLRequest(url: url,
                                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                             timeoutInterval: task.timeout)
        
        task.headers?.forEach({
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        })
        
        if task.httpMethod != .get, let bodyParameters = task.bodyParameters, !bodyParameters.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters, options: [.prettyPrinted])
        }
        
        request.httpMethod = task.httpMethod.rawValue
        return request
    }
}
