//
//  NetworkTask.swift
//
//
//  Created by Arda Ersoy on 15.12.2023.
//

import Foundation

public protocol NetworkTask {
    var base: String { get }
    var path: String { get }
    var timeout: TimeInterval { get }
    var httpMethod: HTTPMethods { get }
    var headers: [String: String]? { get }
    var urlParameters: [String: Any]? { get }
    var bodyParameters: Data? { get }
}

public extension NetworkTask {
    
    var timeout: TimeInterval {
        20
    }
    
    var headers: [String: String]? {
        nil
    }
    
    var urlParameters: [String: Any]? {
        nil
    }
    
    var bodyParameters: Data? {
        nil
    }
}

public enum HTTPMethods: String, Equatable {
    case get
    case post
    case put
    case delete
}
