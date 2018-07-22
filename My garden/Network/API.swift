//
//  API.swift
//  My garden
//
//  Created by Александр Филимонов on 22/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import UIKit
import Alamofire

class API {
    let mainUrl = "https://ru.wikipedia.org/api/rest_v1/page/"
    
    static let shared = API()
    
    func summary(sort: String, complitionHandler : @escaping (SummaryObject) -> ()) {
        let escapedString = sort.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let urlString = mainUrl + "summary/" + escapedString
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let err = dataResponse.error {
                print("Failed to fetch summary" , err)
                return
            }
            guard let data = dataResponse.data else {return}
            do {
                let object = try JSONDecoder().decode(SummaryObject.self, from: data)
                complitionHandler(object)
            } catch let decodeErr {
                print("Failed to decode summary : " , decodeErr)
            }
            
        }
    }
    
    
}

