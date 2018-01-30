
//
//  ApiManager.swift
//  SG_PSI
//
//  Created by v.vajiravelu on 29/1/18.
//  Copyright © 2018 vas. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

let ApiManagerss = ApiManager()

class ApiManager {
     var resultKey: String = ""
    var sessionManager: SessionManager?
    var configuration: URLSessionConfiguration = URLSessionConfiguration.default

    init() {
        
        self.configuration = URLSessionConfiguration.default
        self.configuration.timeoutIntervalForRequest = 20 // currently set to 60 due to big D-Data, should set to 20 or 30 later after the D-Data optimization is done
        self.sessionManager = Alamofire.SessionManager(configuration:configuration) // server trust policy here
       
    }
    
     func ddmmyyhhmmssFromDate(_ date:Date) -> String {
        
        let result = DateFormatter()
        //result.dateFormat = "yyyy-MM-dd HH:mm:ss"
        result.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let strDateString:String = result.string(from: date)
        return strDateString
    }
    
    @discardableResult
    func makeGetRequestToEndPoint(endPoint: String, params: [String: Any], success: @escaping (_ successReturnObject: JSON) -> Void, failure: @escaping (_ failReturnObject: JSON) -> Void) -> DataRequest? {
        print("zzzzzzzz:\(self.ddmmyyhhmmssFromDate(Date()))")
        let endPoint = "https://api.data.gov.sg/v1/environment/psi?date_time=\(self.ddmmyyhhmmssFromDate(Date()))"//2018-01-29T01:45:00
        
        return makeRequestToEndPoint(httpMethod:HTTPMethod.get, endPoint: endPoint, params: [String: Any](), success: { (successReturnObject) in
            success(successReturnObject)
        }) { (failReturnObject) in
            failure(failReturnObject)
        }
    }
    
    @discardableResult
    func makeRequestToEndPoint(httpMethod:HTTPMethod, endPoint: String,
                               params: [String: Any],
                               success: @escaping (_ successReturnObject: JSON) -> Void,
                               failure: @escaping (_ failReturnObject: JSON) -> Void) -> DataRequest? {
        
        let strUrl: String = endPoint
        let mutableUrlRequest: NSMutableURLRequest = NSMutableURLRequest(url: URL(string:strUrl)!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: TimeInterval.init(20)) // currently set to 60 due to big D-Data, should set to 20 or 30 later after the D-Data optimization is done
        mutableUrlRequest.httpMethod = String(describing: httpMethod)
      
        print("apiUrl : + \(strUrl)")
    
        var headers: HTTPHeaders = HTTPHeaders.init()
        headers.updateValue("Ix57qqZdWZ94uRak5DtCQqhKRjUVQoV4", forKey: "api-key")
      
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var request = self.sessionManager?.request(strUrl, method: httpMethod, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
        
        request?.validate()
        request?.responseJSON { response in
        
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if response.result.isSuccess {
                
                let responseObject = JSON(response.result.value!)
                success(responseObject)
                
            } else {
                
                let error = response.result.error
                var message = error?.localizedDescription ?? ""
                if error?._code == NSURLErrorTimedOut {
                    print("TIMEOUT ERROR !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                    message = String.ErrorMessages.http408
                    let failReturnObject: JSON = ["message": message]
                    failure(failReturnObject)
                } else if response.response?.statusCode == 500 {
                    defaultNotificationCenter.post(name: Notification.Name.App.GeneralErrorMessage, object: nil, userInfo: ["errorMessage": String.ErrorMessages.http500])
                    let failReturnObject: JSON = ["message": String.ErrorMessages.http500]
                    failure(failReturnObject)
                }else{
                    defaultNotificationCenter.post(name: Notification.Name.App.GeneralErrorMessage, object: nil, userInfo: ["errorMessage" : message])
                    let failReturnObject: JSON = ["message": message]
                    failure(failReturnObject)
                }
            }
        }
        return request
    }
    
    func checkAppVersion( _ success: @escaping (_ successReturnObject: JSON) -> Void, failure: @escaping (_ failReturnObject: JSON) -> Void) {
        //ApiManagerss.makeGetRequestToEndPoint(endPoint: "", params: ["":""], success: success, failure: failure)
        makeGetRequestToEndPoint(endPoint: "", params: ["":""], success: success, failure: failure)
    }

}


