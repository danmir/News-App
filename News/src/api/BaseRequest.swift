//
//  BaseRequest.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

protocol BaseRequestProtocol: class {
    func request(_ completion: @escaping ([String : Any]?, Error?) -> ())
}

class BaseRequest: BaseRequestProtocol {
    
    let session = URLSession.shared
    
    var host = "https://api.tinkoff.ru/v1/"
    var parameters: [String: String] = [String: String]()
    var path = ""
    
    var urlString: String {
        let getParams = parameters.flatMap({ "\($0.key)=\($0.value)" }).joined(separator: "&")
        return host + path + "?" + getParams
    }
    
    func request(_ completion: @escaping ([String : Any]?, Error?) -> ()) {
        guard let url = URL(string: urlString) else {
            return completion(nil, makeError(with: "Can't create url"))
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
                let error = makeError(with: "Error while fetching data")
                return completion(nil, error)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as? [String : Any]
                completion(json, nil)
            } catch {
                return completion(nil, error)
            }
        }
        
        task.resume()
    }
}
