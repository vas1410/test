//
//  ViewController.swift
//  SG_PSI
//
//  Created by v.vajiravelu on 29/1/18.
//  Copyright © 2018 vas. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    @IBOutlet weak var lblNorth: UILabel!
    @IBOutlet weak var lblEast: UILabel!
    @IBOutlet weak var lblSouth: UILabel!
    @IBOutlet weak var lblWest: UILabel!
    @IBOutlet weak var lblCenter: UILabel!
    @IBOutlet weak var lblUpdatedTimeStamp: UILabel!
    @IBOutlet weak var tblview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       checkweather()
     //   _ = Timer.scheduledTimer(timeInterval: 100, target: self,selector: Selector(("checkweather")), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkweather(){
            
            ApiManagerss.checkAppVersion( { (successReturnObject) in
                self.lblEast.text = successReturnObject["items"][0]["readings"]["psi_twenty_four_hourly"]["east"].stringValue
                self.lblWest.text = successReturnObject["items"][0]["readings"]["psi_twenty_four_hourly"]["west"].stringValue
                self.lblNorth.text = successReturnObject["items"][0]["readings"]["psi_twenty_four_hourly"]["north"].stringValue
                self.lblSouth.text = successReturnObject["items"][0]["readings"]["psi_twenty_four_hourly"]["south"].stringValue
                self.lblCenter.text = successReturnObject["items"][0]["readings"]["psi_twenty_four_hourly"]["central"].stringValue
                self.lblUpdatedTimeStamp.text = successReturnObject["items"][0]["update_timestamp"].stringValue
            
                print("reuslt:",successReturnObject)
                
            }, failure: { (failureReturnObject) in
                print(" failed:",failureReturnObject)
                let alert = UIAlertController(title: "Error Message", message: failureReturnObject["message"].stringValue,
                                              preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            })
        
        
    }
//     func checkAppVersion( _ success: @escaping (_ successReturnObject: JSON) -> Void, failure: @escaping (_ failReturnObject: JSON) -> Void) {
//        ApiManagerss.makeGetRequestToEndPoint(endPoint: "", params: ["":""], success: success, failure: failure)
//    }
    @IBAction func refreshAction(_ sender: Any) {
        checkweather()
    }
    
}

