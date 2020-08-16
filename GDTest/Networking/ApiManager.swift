//
//  ApiManager.swift
//  GDTest
//
//  Created by Сергей Шестаков on 15.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias ServiceResponse = (JSON, Error?) -> Void


class ApiManager: NSObject {
    static let sharedInstance = ApiManager()
    let baseURL = "https://randomuser.me/api/?results=15"
    
    func getRundomUser(onCompletion:@escaping (JSON) -> Void) {
        let route = baseURL
        makeHTTPGetRequest(path: route) { (json: JSON, error: Error?) in
            onCompletion (json as JSON)
        }
    }
    //MARK: Выполняем GET запрос
    private func makeHTTPGetRequest(path: String, onCompletion:@escaping ServiceResponse) {
        let request = URLRequest(url: NSURL(string: path)! as URL)
        URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let jsonData = data { // if data has a data and success
                    do {
                        let json: JSON = try JSON(data: jsonData)
                        onCompletion(json,nil)
                    }catch {// error
                        onCompletion(JSON(),error)
                    }
                } else { // if the data is nil
                    onCompletion(JSON(),error)
                }
            }.resume()
        }
    // MARK: Получаем тело запроса
    private func makeHTTPPostRequest(path: String, body:[String:AnyObject], onCompletion: @escaping ServiceResponse) {
        var request = URLRequest(url: NSURL(string: path)! as URL)
        request.httpMethod = "POST"
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = jsonBody
            URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
                if let jsonData = data {
                    do{
                        let json:JSON = try JSON(data:jsonData)
                        onCompletion(json,nil)
                    }catch{
                        onCompletion(JSON(),error)
                    }
                }else {
                    onCompletion(JSON(),error)
                }
            }.resume()
        }catch {
            onCompletion(JSON(),nil)
        }
    }
}

