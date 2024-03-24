//
//  ServiceCall.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-24.
//

import SwiftUI
import UIKit

class ServiceCall {
    
    class func post(parameter: NSDictionary, path: String, isToken: Bool = false, withSuccess: @escaping ( (_ responseObj: AnyObject?) ->() ), failure: @escaping ( (_ error: Error?) ->() ) ) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            print ("fun2 started ....!!!!")
            
            let parameterData = NSMutableData()
            let dictKey = parameter.allKeys as! [String]
            
            print ("parameterData ===>>> ", parameterData)
            
            var i=0;
            
//            for dictKey in dictKey {
//                if let values = parameter.value(forKey: dictKey) as? String{
//                    parameterData.append(String.init(format: "%@%@=%@", i==0 ? "" : "&" ,dictKey, values.replacingOccurrences(of: "+", with: "%2B")).data(using: String.Encoding.utf8)!)
//                }else{
//                    parameterData.append(String.init(format: "%@%@=%@", i==0 ? "" : "&" ,dictKey, parameter.value(forKey: dictKey) as! CVarArg) .data(using: String.Encoding.utf8)!)
//                }
//                
//                i += 1
//            }
            
            
            var request = URLRequest(url: URL(string:"http://localhost:4000/api/v1/user/login")!,timeoutInterval: 20)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            if(isToken) {
                
                //                #if DEBUG
                //                request.addValue( "HFYsmcPickQlPmWMNUEZ" , forHTTPHeaderField: "access_token")
                //                #else
                //  request.addValue( MainViewModel.shared.userObj.authToken , forHTTPHeaderField: "access_token")
                //                #endif
                
                
            }
            request.httpMethod = "POST"
            request.httpBody = parameterData as Data
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }else{
                    
                    if let data = data {
                        do {
                            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                            
                            DispatchQueue.main.async {
                                withSuccess(jsonDictionary)
                            }
                            
                            
                        }
                        catch {
                            DispatchQueue.main.async {
                                failure(error)
                            }
                        }
                    }
                    
                    
                }
                
                guard let data = data else {
                    
                    return
                }
                
            }
            
            task.resume()
        }
        
    }
    
    
    
}

