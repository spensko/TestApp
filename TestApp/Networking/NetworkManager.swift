//
//  NetworkManager.swift
//  TestApp
//
//  Created by Mikhail Serov on 14.03.2020.
//  Copyright © 2020 TestApp. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    
    enum EndPoint: String {
        case currentWeather = "current"
    }

    private let baseUrl = "http://api.weatherstack.com/"
    private let kApiKey = "8e9900469afd24b0efe893c36f248692"
    
    let sessionManager = URLSession.shared

    func getWeather(query: String, completion: ((_ result: NetworkResponse) -> Void)?) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: baseUrl + EndPoint.currentWeather.rawValue + "?access_key=\(kApiKey)&units=m&query=\(encodedQuery)") {
            let task = sessionManager.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion?(NetworkResponse(result: .none, error: TestError.other(error.localizedDescription)))
                        return
                    } else {
                        guard let data = data else {
                            completion?(NetworkResponse(result: .none, error: TestError.noData))
                            return
                        }
                        
                        #if DEBUG
                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        print(json as Any)
                        #endif
                        
                        if let jsonError = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                            let errorObject = jsonError["error"] as? [String: Any], let message = errorObject["info"] as? String {
                            completion?(NetworkResponse(result: .none, error: TestError.other(message)))
                        } else {
                            completion?(NetworkResponse(result: data, error: .none))
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

struct NetworkResponse {
    var result: Data?
    var error: TestError?
}

enum TestError: Error {
    case noUrl
    case noData
    case other(String)
        
    var localizedDescription: String {
        switch self {
        case .noUrl:
            return "No url"
        case .noData:
            return "No data"
        case .other(let message):
            return message
        }
    }
}
