//
//  ServiceCall.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-24.
//

import SwiftUI
import UIKit

class ServiceCall {
    
    class func post(parameter: [String: Any], path: String, isToken: Bool = false, withSuccess: @escaping ((_ responseObj: Any?) ->()), failure: @escaping ((_ error: Error?) ->())) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let parameterData = try JSONSerialization.data(withJSONObject: parameter, options: [])
                
                var request = URLRequest(url: URL(string: path)!, timeoutInterval: 20)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                request.httpBody = parameterData
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            failure(error)
                        }
                    } else {
                        if let data = data {
                            do {
                                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                                debugPrint("response: ", jsonResponse ?? "")
                                
                                DispatchQueue.main.async {
                                    withSuccess(jsonResponse)
                                }
                            } catch {
                                DispatchQueue.main.async {
                                    failure(error)
                                }
                            }
                        }
                    }
                }
                task.resume()
            } catch {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }
    }
}
