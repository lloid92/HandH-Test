//
//  Weather.swift
//  HandH
//
//  Created by Alpaca Dev on 28.05.2018.
//  Copyright © 2018 Denis Dultsev. All rights reserved.
//

import UIKit
import Alamofire

struct Weather {
    
    static private let kApiUrl = "https://api.apixu.com/v1"
    static private let kApiKey = "633d8051bacf45c499262829182805"
    
    static func weather(city: String, completion: @escaping (String?) -> ()) {
        
        if let url = URL.init(string: "\(kApiUrl)/current.json?key=\(kApiKey)&q=\(city.urlEscaped())") {

            Alamofire.request(url).responseJSON { (response) in
                
                var completionString: String? = nil
                
                if let json = response.result.value as? NSDictionary {
                    if let temperature = json.value(forKeyPath: "current.temp_c") as? Double {
                        completionString = "\(city): \(temperature)°С"
                    }
                }

                completion(completionString)

            }
        }

    }
    
}

