//
//  NetworkDataFetcher.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 14.11.2021.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkSevice()
    
    func fetchImages(searchTerm: String, completion: @escaping(SearchResultsModel?) ->()) {
        networkService.request(searchTerm: searchTerm) { data, error in
            if let error = error {
                print("Error resived requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResultsModel.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            print("Have parsed")
            return objects
        } catch let jsonError {
            print("Filed to decode JSON", jsonError)
            return nil
        }
    }
}
