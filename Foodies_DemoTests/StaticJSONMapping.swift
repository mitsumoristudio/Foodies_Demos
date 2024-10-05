//
//  StiticJSONMapping.swift
//  Foodies_DemoTests
//
//  Created by Satoshi Mitsumori on 10/9/24.
//

import Foundation

class StaticJSONMapping {
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        guard !file.isEmpty,
              let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContent
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

extension StaticJSONMapping {
    enum MappingError: Error {
        case failedToGetContent
    }
}
