//
//  NsurlSessionHelper.swift
//  ContactsApp
//
//  Created by epita on 29/01/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

class NsurlSessionHelper: NSObject {
    
    func getResponseForURL(parameters :[String : Any?]? , url : String , httpMethod : String , success : @escaping (NSDictionary) -> Void , failure : @escaping (String) -> Void )  {
        let Url = String(format: url)
        guard let serviceUrl = URL(string: Url) else { return }

        var request = URLRequest(url: serviceUrl)
        request.httpMethod = httpMethod
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if (error == nil )
            {
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])

                    success(json as? NSDictionary ?? ["" : ""])
                }catch {
                    print(error)
                }
            }
            }
            else
            {
                let errorStr = error.debugDescription
                failure(errorStr)
            }
            }.resume()
    
    }
    
    func getJSONResponseForURL(parameters :[String : Any?]? , url : String , httpMethod : String , success : @escaping (Any) -> Void , failure : @escaping (String) -> Void )  {
        
        let Url = String(format: url)
        guard let serviceUrl = URL(string: Url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = httpMethod
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if (error == nil )
            {
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                        success(json )
                    }catch {
                        print(error)
                    }
                }
            }
            else
            {
                let errorStr = error.debugDescription
                failure(errorStr)
            }
            }.resume()
        
    }

}
