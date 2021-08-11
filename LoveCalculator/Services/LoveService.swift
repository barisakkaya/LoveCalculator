//
//  LoveService.swift
//  LoveCalculator
//
//  Created by Barış Can Akkaya on 9.08.2021.
//

import Foundation
import Alamofire

class LoveService {
    
    func getLoveScore(url: URL, completionHandler: @escaping (LoveModel?) -> ()) {
        
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "165f065132msh361bd955e050752p11c84cjsn292a77ee876c",
            "x-rapidapi-host": "love-calculator.p.rapidapi.com"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: LoveModel.self) { (response) in
                if let model = response.value {
                    completionHandler(model)
            }
        }
    }
}

