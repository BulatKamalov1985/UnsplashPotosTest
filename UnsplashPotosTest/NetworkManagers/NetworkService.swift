//
//  NetworkService.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 14.11.2021.
//

import Foundation

class NetworkSevice {
    
    func request(searchTerm: String? = nil, count: String? = nil, comletion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParametrs(searchTerm: searchTerm, count: count)
        let url = self.url(params: parameters, isSearch: searchTerm != nil)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: comletion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID urNpwSDpkcLREWkYaef7rb6EergbfzF2d9IXdUZQAIs"
        return headers
    }
    
    private func prepareParametrs(searchTerm: String? = nil, count: String? = nil) -> [String: String] {
        var paramrters = [String: String]()
        paramrters["query"] = searchTerm
        paramrters["count"] = count
        paramrters["page"] = String(1)
        paramrters["per_page"] = String(50)
        return paramrters
    }
    
    private func url(params: [String: String], isSearch: Bool) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        if isSearch {
            components.path = "/search/photos"
        } else {
            components.path = "/photos/random"
        }
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error )
            }
        }
    }
}
