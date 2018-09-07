//
//  ServerClient.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 9. 3..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ServerClient {
    static let HOST = "http://13.209.76.45:3000"
    
    static var userId = "123456789"
    
    static func request(url: String,
                        method: HTTPMethod,
                        parameters: Parameters,
                        callback: ((JSON, Int) -> Void)? = nil) {
        Alamofire.request(url, method: method, parameters: parameters).response { response in
            let json = JSON(response.data!)
            let code = response.response!.statusCode
            print("[HTTP] \(url) \(method) \(parameters) \(code) \(json)")
            callback?(json, code)
        }
    }
    
    static func login(id: String,
                      nickName: String,
                      email: String,
                      callback: ((Bool) -> Void)? = nil) {
        let path = "/auth/login"
        let parameters: Parameters = [
            "id": id,
            "nickname": nickName,
            "email": email
        ]
        
        request(url: HOST+path, method: .post, parameters: parameters) { (json, code) in
            callback?(code == 200)
        }
    }
    
    static func getWorkSpaceList(callback: (([WorkSpace]) -> Void)? = nil) {
        let path = "/user/\(userId)/work"
        let parameters: Parameters = [:]
        
        request(url: HOST+path, method: .get, parameters: parameters) { (json, code) in
            var array = [WorkSpace]()
            
            for inner in json.arrayValue {
                array.append(WorkSpace(inner))
            }
            
            callback?(array)
        }
    }
    
    static func addWorkSpace(name: String,
                             address: String,
                             latitude: Double,
                             longitude: Double,
                             hourlyWage: Int,
                             probation: Int,
                             recess: Int,
                             recessState: Int,
                             payDay: Int,
                             tax: Double,
                             fiveState: Int,
                             workingDay: String,
                             callback: ((Bool) -> Void)? = nil) {
        let path = "/user/\(userId)/work"
        let parameters: Parameters = [
            "name": name,
            "address": address,
            "latitude": latitude,
            "longitude": longitude,
            "hourly_wage": hourlyWage,
            "probation": probation,
            "recess": recess,
            "recess_state": recessState,
            "pay_day": payDay,
            "tax": tax,
            "five_state": fiveState,
            "working_day": workingDay
        ]
        
        request(url: HOST+path, method: .post, parameters: parameters) { (json, code) in
            callback?(code == 200)
        }
    }
    
    static func deleteWorkSpace(workSpaceId: String,
                                callback: ((Bool) -> Void)? = nil) {
        let path = "/user/\(userId)/work/\(workSpaceId)"
        let parameters: Parameters = [:]
        
        request(url: HOST+path, method: .delete, parameters: parameters) { (json, code) in
            callback?(code == 200)
        }
    }
}
