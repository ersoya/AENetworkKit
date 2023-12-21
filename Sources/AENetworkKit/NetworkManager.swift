//
//  NetworkManager.swift
//
//
//  Created by Arda Ersoy on 15.12.2023.
//

import Foundation
import Combine

public protocol NetworkManagerProtocol {
    func send<T: Codable>(_ task: NetworkTask) async throws -> T
}

public final class NetworkManager: NetworkManagerProtocol {
    
    public static let shared: NetworkManager = .init()
    
    private var session: URLSession = URLSession.shared
    
    private init() {}
    
    public func send<T: Codable>(_ task: NetworkTask) async throws -> T {
        let urlRequest: URLRequest = NetworkRequestCreator.request(for: task)
        let (data, _) = try await session.data(for: urlRequest)
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
}
