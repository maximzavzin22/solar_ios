//
//  ApiService.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 20/07/23.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    var baseUrl = "https://eu5.fusionsolar.huawei.com"
    var passwordBaseUrl = "https://api.uz33.uz/unisso"
    var sablabUrl = "https://huawei.apiweb.app"
    
    func getDefaultError() -> CustomError {
        let requestError = CustomError()
        requestError.code = 1
        requestError.title = NSLocalizedString("connection_error_title", comment: "")
        requestError.message = NSLocalizedString("connection_error_description", comment: "")
        return requestError
    }
    
    //sablab
    func fetchAuth(username: String, password: String, completion: @escaping (CustomError?, Profile?) -> ()) {
//        print("fetchAuth")
        let url = URL(string: "\(sablabUrl)/api/user/auth")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postString = "{\"username\":\"\(HomeController.login)\",\"password\":\"\(HomeController.password)\" }"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
//                print("fetchAuth statusCode: \(httpResponse.statusCode)")
                if(httpResponse.statusCode == 404 || httpResponse.statusCode == 500) {
                    DispatchQueue.main.async(execute: {
                        completion(self.getDefaultError(), nil)
                    })
                    return
                }
                if(httpResponse.statusCode == 401) {
                    DispatchQueue.main.async(execute: {
                        let requestError = CustomError()
                        requestError.code = 1
                        requestError.title = NSLocalizedString("auth_error_title", comment: "")
                        requestError.message = NSLocalizedString("auth_error_description", comment: "")
                        completion(requestError, nil)
                    })
                    return
                }
            }
            if error != nil {
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
                return
            }
            do {
                let result = String(data: data!, encoding: .utf8)
//                print("fetchAuth result \(String(describing: result))")
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                let requestError = JSONParse.sharedInstance.errorParse(json: json)
                let profile = JSONParse.sharedInstance.profileParse(json: json)
                
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
    
    func fetchStations(completion: @escaping (CustomError?, [Station]?) -> ()) {
//        print("fetchStations")
        let url = URL(string: "\(sablabUrl)/api/user/stations")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(HomeController.profile?.access_token ?? "")", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
//                print("fetchStations statusCode: \(httpResponse.statusCode)")
                if(httpResponse.statusCode == 404 || httpResponse.statusCode == 500) {
                    DispatchQueue.main.async(execute: {
                        completion(self.getDefaultError(), nil)
                    })
                    return
                }
                if(httpResponse.statusCode == 401) {
                    DispatchQueue.main.async(execute: {
                        let requestError = CustomError()
                        requestError.code = 1
                        requestError.title = NSLocalizedString("auth_error_title", comment: "")
                        requestError.message = NSLocalizedString("auth_error_description", comment: "")
                        completion(requestError, nil)
                    })
                    return
                }
            }
            if error != nil {
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
                return
            }
            do {
                let result = String(data: data!, encoding: .utf8)
//                print("fetchStations result \(result)")
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
    
    func fetchRegions(completion: @escaping (CustomError?, [Region]?) -> ()) {
//        print("fetchRegions")
        let url = URL(string: "\(sablabUrl)/api/regions")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(HomeController.profile?.access_token ?? "")", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
//                print("fetchRegions statusCode: \(httpResponse.statusCode)")
                if(httpResponse.statusCode == 404 || httpResponse.statusCode == 500) {
                    DispatchQueue.main.async(execute: {
                        completion(self.getDefaultError(), nil)
                    })
                    return
                }
                if(httpResponse.statusCode == 401) {
                    DispatchQueue.main.async(execute: {
                        let requestError = CustomError()
                        requestError.code = 1
                        requestError.title = NSLocalizedString("auth_error_title", comment: "")
                        requestError.message = NSLocalizedString("auth_error_description", comment: "")
                        completion(requestError, nil)
                    })
                    return
                }
            }
            if error != nil {
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
                return
            }
            do {
                _ = String(data: data!, encoding: .utf8)
//                print("fetchRegions result \(result)")
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                let requestError = JSONParse.sharedInstance.errorParse(json: json)
                let regions = JSONParse.sharedInstance.regionsParse(json: json)
                
                DispatchQueue.main.async(execute: {
                    completion(requestError, regions)
                })
            } catch let jsonError {
                print(jsonError)
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
            }
        }) .resume()
    }
    
    func fetchReportKpi(collectTime: Int64, station: String, road: String, completion: @escaping (CustomError?, [DetailRealKpi]?) -> ()) {
//        print("fetchReportKpi")
        var urlStr = "\(sablabUrl)/api/stations/\(road)?collect_time=\(collectTime)"
        if(station != "") {
            urlStr = "\(urlStr)&station=\(station)"
        }
//        print("urlStr \(urlStr)")
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(HomeController.profile?.access_token ?? "")", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
//                print("fetchReportKpi statusCode: \(httpResponse.statusCode)")
                if(httpResponse.statusCode == 404 || httpResponse.statusCode == 500) {
                    DispatchQueue.main.async(execute: {
                        completion(self.getDefaultError(), nil)
                    })
                    return
                }
                if(httpResponse.statusCode == 401) {
                    DispatchQueue.main.async(execute: {
                        let requestError = CustomError()
                        requestError.code = 1
                        requestError.title = NSLocalizedString("auth_error_title", comment: "")
                        requestError.message = NSLocalizedString("auth_error_description", comment: "")
                        completion(requestError, nil)
                    })
                    return
                }
            }
            if error != nil {
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
                return
            }
            do {
                _ = String(data: data!, encoding: .utf8)
//                print("fetchReportKpi result \(String(describing: result))")
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                let requestError = JSONParse.sharedInstance.errorParse(json: json)
                let detailRealKpis = JSONParse.sharedInstance.detailRealKpisParse(json: json)
                
                DispatchQueue.main.async(execute: {
                    completion(requestError, detailRealKpis)
                })
            } catch let jsonError {
                print(jsonError)
                DispatchQueue.main.async(execute: {
                    completion(self.getDefaultError(), nil)
                })
            }
        }) .resume()
    }
    //
}
