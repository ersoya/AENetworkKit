//
//  NetworkManager.swift
//
//
//  Created by Arda Ersoy on 15.12.2023.
//

import Foundation
import Combine

public protocol NetworkManagerProtocol {
    func send<T: Codable>(_ task: NetworkTask) async throws -> (T)
}

public final class NetworkManager: NetworkManagerProtocol {
    
    public static let shared: NetworkManager = .init()
    
    private var session: URLSession = URLSession.shared
    
    private init() {}
    
    public func send<T: Codable>(_ task: NetworkTask) async throws -> (T) {
        let urlRequest: URLRequest = NetworkRequestCreator.request(for: task)
        let (data, _): (Data, URLResponse)
        
        if let multipartData = task.multipartData {
            (data, _) = try await session.upload(for: urlRequest, from: multipartData)
        } else {
            (data, _) = try await session.data(for: urlRequest)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
