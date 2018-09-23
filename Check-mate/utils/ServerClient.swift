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
                        headers: HTTPHeaders = [:],
                        callback: ((JSON, Int) -> Void)? = nil) {
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).response { response in
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
    
    static func getCalendarMain(year: Int,
                                month: Int,
                                callback: ((Int, DateModel) -> Void)? = nil) {
        let path = "/user/\(userId)/work/WO123456789A0/main/calendar/\(year)/\(month)"
        let parameters: Parameters = [:]
        
        request(url: HOST+path, method: .get, parameters: parameters) { (json, code) in
            let dateModel = DateModel(json)
            callback?(code, dateModel)
        }
    }
    
    static func getCalendarDetail(year: Int,
                                  month: Int,
                                  day: Int,
                                  callback: ((Int, DetailDateModel) -> Void)? = nil) {
        let path = "/user/\(userId)/work/WO123456789A0/main/calendar/\(year)/\(month)/\(day)"
        let parameters: Parameters = [:]
        
        request(url: HOST+path, method: .get, parameters: parameters) { (json, code) in
            let detailDateModel: DetailDateModel = DetailDateModel(json)
            callback?(code, detailDateModel)
        }
    }
    
    static func modifyWorkSpace(workSpace: WorkSpace,
                                callback: ((Bool) -> Void)? = nil) {
        let path = "/user/\(userId)/work/\(workSpace.id)"
        let parameters: Parameters = [
            "name": workSpace.name,
            "address": workSpace.address,
            "latitude": workSpace.latitude,
            "longitude": workSpace.longitude,
            "hourly_wage": workSpace.wage,
            "probation": workSpace.probation,
            "recess": workSpace.recess,
            "recess_state": workSpace.recessStatus,
            "pay_day": workSpace.payDay,
            "tax": workSpace.tax,
            "five_state": workSpace.fiveState,
            "working_day": workSpace.workingDay
        ]
        
        request(url: HOST+path, method: .put, parameters: parameters) { (json, code) in
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
    
    static func coordToAddress(latitude: Double,
                                 longitude: Double,
                                 callback: ((String?) -> Void)? = nil) {
        let url = "https://dapi.kakao.com/v2/local/geo/coord2address.json"
        let parameters: Parameters = [
            "x": longitude,
            "y": latitude
        ]
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK d5ce672e16d3c781e1d03f0bd1f1755a"
        ]
        
        request(url: url, method: .get, parameters: parameters, headers: headers) { (json, code) in
            let num = json["meta"]["total_count"].intValue

            if num <= 0 {
                callback?(nil)
                return
            }
            
            let oldAddrJson = json["documents"].arrayValue[0]["address"]
            let newAddrJson = json["documents"].arrayValue[0]["road_address"]
            
            if newAddrJson != JSON.null {
                let address = newAddrJson["address_name"].stringValue
                callback?(address)
            } else if oldAddrJson != JSON.null {
                let address = oldAddrJson["address_name"].stringValue
                callback?(address)
            } else {
                callback?(nil)
            }
        }
    }
    
    static func setWorkState(workSpace: WorkSpace,
                             workState: WorkState,
                             callback: ((Bool) -> Void)? = nil){
        let path = "/user/\(userId)/work/\(workSpace.id)/main"
        let parameters: Parameters = [
            "working_state" : workState.rawValue
        ]
        
        request(url: HOST+path, method: .post, parameters: parameters) { (json, code) in
            callback?(code == 200)
        }
    }
    
    static func getWorkRecord(workSpace: WorkSpace, callback: ((WorkRecord)-> Void)?) {
        let path = "/user/\(userId)/work/\(workSpace.id)/main/detail"
        let parameters: Parameters = [:]
        request(url: HOST+path, method: .get, parameters: parameters) { (json, code) in
            let workRecord = WorkRecord(json)
            callback?(workRecord)
        }
    }
    
}
