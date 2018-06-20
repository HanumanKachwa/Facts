//
//  CountryFactsAPI.swift
//  Facts
//
//  Created by Hanuman on 21/06/18.
//  Copyright © 2018 Hanuman. All rights reserved.
//

import Foundation

class CountryFactsAPI {
    typealias CompletionBlock = (_ facts: CountryFacts?, _ error: Error?) -> Void

    fileprivate static let baseURL = "https://dl.dropboxusercontent.com/s/"
    
    class func getFacts(completionHandler: (CompletionBlock)? = nil) {
        let factsEndpoint: String = baseURL + "2iodh4vg0eortkl/facts.json"
        guard let url = URL(string: factsEndpoint) else {
            completionHandler?(nil, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                // check for error
                if let err = error {
                    completionHandler?(nil, err)
                    return
                }
                
                // check for data
                guard let responseData = data,
                    let dataString = String(data: responseData, encoding: String.Encoding.ascii),
                    let jsonData :Data = dataString.data(using: String.Encoding.utf8) else {
                    completionHandler?(nil, NetworkError.error(withErrorCode: .InvalidOrNoData))
                    return
                }

                // convert json to Facts
                let jsonDecoder = JSONDecoder()
                let facts = try jsonDecoder.decode(CountryFacts.self, from: jsonData)
                completionHandler?(facts, nil)
            } catch let error {
                completionHandler?(nil, error)
            }
            
        }
        task.resume()
    }
}
