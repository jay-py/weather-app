//
//  NetworkAgent.swift
//  
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI

struct NetworkAgent {

    typealias Parameters = [String: String]

    enum HttpMethod: String {
        case GET = "GET"
        case POST = "POST"
        case PATCH = "PATCH"
        case DELETE = "DELETE"
        case PUT = "PUT"
    }

    enum ContentType {
        case json

        var value: String {
            switch self {
                case .json:
                    return "application/json"
            }
        }
    }

    enum NetworkError: Error {
        case urlError
        case parseError
        case unknown(String)

        var message: String {
            switch self {
                case .unknown(let message):
                    return message
                default:
                    return "No message!"
            }
        }
    }
}

extension NetworkAgent {
    
    static func fetchData<T: BaseModel>(
        path: APIEndpoints,
        _ method: HttpMethod = .GET,
        responseType: T.Type
    ) async throws -> T {
        #if DEBUG
        print(">> fetch for \(path.value) from mock data")
            if [1].contains(1) { // surpress warning
                return try parseResponse(data: T.mockData, responseType: responseType)
            }
        #endif
        guard let url = URL(string: path.value)
        else { throw NetworkError.urlError }

        let request = getRequestWithHeaders(url: url, method: method)
        print(">> fetch for \(path.value)")
        // check the cache
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            print(">> reponse from cache")
            let decoded = try parseResponse(data: cachedResponse.data, responseType: responseType)
            return decoded
        }
        // fetch
        let (data, response) = try await URLSession.shared.data(for: request)
        if !response.isOk {
            throw NetworkError.unknown(response.prettyPrint)
        }
        print(">> \(method.rawValue): \(path.value) \n>> \(String(data: data, encoding: .utf8) ?? "")")
        // parse
        let decoded = try parseResponse(data: data, responseType: responseType)
        // cache
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
        print(">> cached the response")
        return decoded
    }
}

extension NetworkAgent {
    
    private static func getRequestWithHeaders(
        url: URL, method: HttpMethod, contentType: ContentType? = nil
    ) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30.0)
        request.httpMethod = method.rawValue
        if let contentType = contentType {
            request.setValue(contentType.value, forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    private static func parseResponse<T: BaseModel>(data: Data, responseType: T.Type) throws -> T {
        #if DEBUG
            if [1].contains(1) {
                return try! JSONDecoder().decode(responseType, from: T.mockData)
            }
        #endif
        guard let responseObject = try? JSONDecoder().decode(responseType, from: data)
        else { throw NetworkError.parseError }
        return responseObject
    }
}
