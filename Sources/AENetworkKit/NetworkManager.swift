//
//  NetworkManager.swift
//
//
//  Created by Arda Ersoy on 15.12.2023.
//

import Foundation
import Combine

public protocol NetworkManagerProtocol {
    func send<T: Codable, E: Codable>(_ task: NetworkTask) async throws -> (T?, E?)
}

public final class NetworkManager: NetworkManagerProtocol {
    
    public static let shared: NetworkManager = .init()
    
    private var session: URLSession = URLSession.shared
    
    private init() {}
    
    public func send<T: Codable, E: Codable>(_ task: NetworkTask) async throws -> (T?, E?) {
        let urlRequest: URLRequest = NetworkRequestCreator.request(for: task)
        let (data, response) = try await session.data(for: urlRequest)
        
        if let result = try? JSONDecoder().decode(T.self, from: data) {
            return (result, nil)
        }
        if let error = try? JSONDecoder().decode(E.self, from: data) {
            return (nil, error)
        }
        return (nil, nil)
    }
}
