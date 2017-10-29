//
//  NetworkProcessor.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 23/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import Foundation

class NetworkProcessor{
    
    let viewController = ViewController()
    let url: URL
    
    init(url: URL){
        self.url = url
    }
    
    func downloadJSONFromURL(_ completion: @escaping([Product])->Void){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil{
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode{
                    case 200:
                        guard let data = data else { return }
                        do {
                            let product = try JSONDecoder().decode([Product].self, from: data)
                            completion(product)
                        } catch let error {
                            print("Error serializing json:", error)
                        }
                    default:
                        print("HTTP Response Code: \(httpResponse.statusCode)")
                    }
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
            }.resume()
    }
   
}
