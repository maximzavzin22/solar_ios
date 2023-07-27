//
//  ApiService.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 20/07/23.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    var baseUrl = "https://eu5.fusionsolar.huawei.com/thirdData"
    
    func getDefaultError() -> CustomError {
        var requestError = CustomError()
        requestError.code = 1
        requestError.title = NSLocalizedString("connection_error_title", comment: "")
        requestError.message = NSLocalizedString("connection_error_description", comment: "")
        return requestError
    }
    
    func fetchProfile(completion: @escaping (CustomError?, Profile?) -> ()) {
        print("fetchProfile")
        let url = URL(string: "\(baseUrl)/login")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postString = "{\"userName\":\"\(HomeController.login)\",\"systemCode\":\"\(HomeController.password)\" }"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("fetchProfile statusCode: \(httpResponse.statusCode)")
                HomeController.token = httpResponse.allHeaderFields["xsrf-token"] as? String ?? ""
                print("Token \(HomeController.token)")
                if(httpResponse.statusCode == 404 || httpResponse.statusCode == 500) {
                    DispatchQueue.main.async(execute: {
                        completion(self.getDefaultError(), nil)
                    })
                    return
                }
                if(httpResponse.statusCode == 401) {
                    DispatchQueue.main.async(execute: {
                        var requestError = CustomError()
                        requestError.code = 1
                        requestError.title = NSLocalizedString("auth_error_title", comment: "")
                        requestError.message = NSLocalizedString("auth_error_description", comment: "")
                        completion(requestError, nil)
                    })
                    return
                }
            }
            if error != nil {
                print(error)
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
                return
            }
            do {
                let result = String(data: data!, encoding: .utf8)
                print("fetchProfile result \(result)")
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                let requestError = JSONParse.sharedInstance.errorParse(json: json)
                let profile = Profile()
                
                DispatchQueue.main.async(execute: {
                    completion(requestError, profile)
                })
            } catch let jsonError {
                print(jsonError)
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
            }
        }) .resume()
    }
    
    func fetchStations(pageNo: Int, completion: @escaping (CustomError?, [Station]?) -> ()) {
        print("fetchStations")
        let url = URL(string: "\(baseUrl)/stations")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(HomeController.token ?? "")", forHTTPHeaderField: "xsrf-token")
        let postString = "{\"pageNo\":\"\(pageNo)\"}"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("fetchStations statusCode: \(httpResponse.statusCode)")
                if(httpResponse.statusCode == 404 || httpResponse.statusCode == 500) {
                    DispatchQueue.main.async(execute: {
                        completion(self.getDefaultError(), nil)
                    })
                    return
                }
                if(httpResponse.statusCode == 401) {
                    DispatchQueue.main.async(execute: {
                        var requestError = CustomError()
                        requestError.code = 1
                        requestError.title = NSLocalizedString("auth_error_title", comment: "")
                        requestError.message = NSLocalizedString("auth_error_description", comment: "")
                        completion(requestError, nil)
                    })
                    return
                }
            }
            if error != nil {
                print(error)
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
                return
            }
            do {
                let result = String(data: data!, encoding: .utf8)
                print("fetchStations result \(result)")
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                let requestError = JSONParse.sharedInstance.errorParse(json: json)
                let stations = JSONParse.sharedInstance.stationsParse(json: json)
                
                DispatchQueue.main.async(execute: {
                    completion(requestError, stations)
                })
            } catch let jsonError {
                print(jsonError)
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
            }
        }) .resume()
    }
    
    func fetchTopStations(completion: @escaping (CustomError?, [Station]?) -> ()) { //надо потом заменить, метод не правильный
        print("fetchTopStations")
        let url = URL(string: "\(baseUrl)/stations")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(HomeController.token ?? "")", forHTTPHeaderField: "xsrf-token")
        let postString = "{\"pageNo\":\"\(1)\"}"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("fetchTopStations statusCode: \(httpResponse.statusCode)")
                if(httpResponse.statusCode == 404 || httpResponse.statusCode == 500) {
                    DispatchQueue.main.async(execute: {
                        completion(self.getDefaultError(), nil)
                    })
                    return
                }
                if(httpResponse.statusCode == 401) {
                    DispatchQueue.main.async(execute: {
                        var requestError = CustomError()
                        requestError.code = 1
                        requestError.title = NSLocalizedString("auth_error_title", comment: "")
                        requestError.message = NSLocalizedString("auth_error_description", comment: "")
                        completion(requestError, nil)
                    })
                    return
                }
            }
            if error != nil {
                print(error)
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
                return
            }
            do {
                let result = String(data: data!, encoding: .utf8)
                print("fetchTopStations result \(result)")
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                let requestError = JSONParse.sharedInstance.errorParse(json: json)
                let stations = JSONParse.sharedInstance.stationsParse(json: json)
                
                DispatchQueue.main.async(execute: {
                    completion(requestError, stations)
                })
            } catch let jsonError {
                print(jsonError)
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
            }
        }) .resume()
    }
    
    func fetchStationRealKpi(stationCodes: String, completion: @escaping (CustomError?, [StationRealKpi]?) -> ()) {
        print("fetchStationRealKpi")
        let url = URL(string: "\(baseUrl)/getStationRealKpi")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(HomeController.token ?? "")", forHTTPHeaderField: "xsrf-token")
        let postString = "{\"stationCodes\":\"\(stationCodes)\"}"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("fetchStationRealKpi statusCode: \(httpResponse.statusCode)")
                if(httpResponse.statusCode == 404 || httpResponse.statusCode == 500) {
                    DispatchQueue.main.async(execute: {
                        completion(self.getDefaultError(), nil)
                    })
                    return
                }
                if(httpResponse.statusCode == 401) {
                    DispatchQueue.main.async(execute: {
                        var requestError = CustomError()
                        requestError.code = 1
                        requestError.title = NSLocalizedString("auth_error_title", comment: "")
                        requestError.message = NSLocalizedString("auth_error_description", comment: "")
                        completion(requestError, nil)
                    })
                    return
                }
            }
            if error != nil {
                print(error)
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
                return
            }
            do {
                let result = String(data: data!, encoding: .utf8)
                print("fetchStationRealKpi result \(result)")
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                let requestError = JSONParse.sharedInstance.errorParse(json: json)
                let stationRealKpis = JSONParse.sharedInstance.stationRealKpisParse(json: json)
                
                DispatchQueue.main.async(execute: {
                    completion(requestError, stationRealKpis)
                })
            } catch let jsonError {
                print(jsonError)
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
            }
        }) .resume()
    }
}
