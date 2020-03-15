//
//  DataExtensions.swift
//  TestApp
//
//  Created by Mikhail Serov on 14.03.2020.
//  Copyright © 2020 TestApp. All rights reserved.
//

import Foundation

extension Data {
    func decode<T: Decodable>(as: T.Type) throws -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: self)
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            throw error
        }
    }
}
