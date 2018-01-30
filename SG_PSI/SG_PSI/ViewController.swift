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
    @IBOutlet weak var segmentCtrl: UISegmentedControl!
    @IBOutlet weak var lblEast: UILabel!
    @IBOutlet weak var lblSouth: UILabel!
    @IBOutlet weak var lblWest: UILabel!
    @IBOutlet weak var lblCenter: UILabel!
    @IBOutlet weak var lblUpdatedTimeStamp: UILabel!
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var lbltblviewTitle: UILabel!
    var  sucessObject: JSON!
    var psireading : PSIReadings!
    
    
    
    var fulldayPSI  = [["Good" : "0-50"],["Moderate" : "51-100"], ["Unhealthy" : "101-200"], ["Very Unhealthy" : "201-300"], ["Hazardous" : "Above 300"]]
    var hourPsi   = [ ["Band I (Normal)" : "0-55"],["Band II  (Elevated)" : "56-150"], ["Band III (High)" : "151-250"], ["Band IV (Very High)" : "Above 250"]]
    var selectedPSIArr = [[String:String]]()
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
    
    func checkweather() {
            
            ApiManagerss.getRequest( { (successReturnObject) in
            
                self.sucessObject = successReturnObject
                self.updateUI()
                print("reuslt:",successReturnObject)
                
            }, failure: { (failureReturnObject) in
                print(" failed:",failureReturnObject)
                let alert = UIAlertController(title: "Error Message", message: failureReturnObject["message"].stringValue,
                                              preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            })
        
        
    }

    @IBAction func refreshAction(_ sender: Any) {
        checkweather()
    }
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        checkweather()
       // self.updateUI()
        self.tblview.reloadData()
        
    }
    
    func updateUI(){
      
        if(segmentCtrl.selectedSegmentIndex == 0){
            lbltblviewTitle.text = "24-hr PSI"
            psireading = PSIReadings.init(sucessObject["items"][0]["readings"]["psi_twenty_four_hourly"])
            self.lblEast.text = psireading.east
            self.lblWest.text = psireading.west
            self.lblNorth.text = psireading.north
            self.lblSouth.text = psireading.south
            self.lblCenter.text = psireading.central
            self.lblUpdatedTimeStamp.text = sucessObject["items"][0]["update_timestamp"].stringValue
            lblColor(lbl: lblEast, reading:psireading.east! )
            lblColor(lbl: lblWest, reading:psireading.west!)
            lblColor(lbl: lblNorth, reading:psireading.north!)
            lblColor(lbl: lblSouth, reading:psireading.south!)
            lblColor(lbl: lblCenter, reading:psireading.central!)
        }else{
            
            //Lbl Color
            psireading = PSIReadings.init(sucessObject["items"][0]["readings"]["pm25_twenty_four_hourly"])
            
            self.lblEast.textColor = UIColor.lightGray
            self.lblWest.textColor = UIColor.lightGray
            self.lblNorth.textColor = UIColor.lightGray
            self.lblSouth.textColor = UIColor.lightGray
            self.lblCenter.textColor = UIColor.lightGray
            
             lbltblviewTitle.text = "1-hr PM2.5 conc."
            self.lblEast.text = bandLevel(reading:psireading.east!)
            self.lblWest.text = bandLevel(reading:psireading.west!)
            self.lblNorth.text = bandLevel(reading:psireading.north!)
            self.lblSouth.text = bandLevel(reading:psireading.south!)
            self.lblCenter.text = bandLevel(reading:psireading.central!)
            self.lblUpdatedTimeStamp.text = sucessObject["items"][0]["update_timestamp"].stringValue
            
          
            
        }
        
    }
    
    func bandLevel(reading:String) -> String{
       
        let readingIntval = Int(reading)
        var band = ""
        if(readingIntval! <= 55){
            band = " I"
        }else  if(readingIntval! <= 150){
              band = " II"
        }else if(readingIntval! <= 250){
              band = " III"
        }else if(readingIntval! > 250){
              band = " IV"
        }
        
        return reading + band
    }
    
    func lblColor(lbl:UILabel, reading:String) {
        
        let readingIntval = Int(reading)
        
        if(readingIntval! <= 50){
            lbl.textColor =  UIColor(red: 30/255, green: 177/255, blue: 136/255, alpha: 1.0)
        }else  if(readingIntval! <= 100){
           lbl.textColor = UIColor(red: 63/255, green: 133/255, blue: 187/255, alpha: 1.0)
        }else if(readingIntval! <= 200){
            lbl.textColor =  UIColor(red: 238/255, green: 138/255, blue: 15/255, alpha: 1.0)
        }else if(readingIntval! <= 300){
            lbl.textColor = UIColor(red: 198/255, green: 63/255, blue: 5/255, alpha: 1.0)
        }else if(readingIntval! > 300){
            lbl.textColor = UIColor(red: 176/255, green: 36/255, blue: 33/255, alpha: 1.0)
        }
        
        
    }
    
}

// MARK: - TableView Delegate -
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedPSIArr.removeAll()
        if segmentCtrl.selectedSegmentIndex == 0{
         selectedPSIArr = fulldayPSI
        }else{
        selectedPSIArr = hourPsi
        }
        return selectedPSIArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"PSICell") as! PSICell
        let dict = selectedPSIArr[indexPath.row]
        cell.lblHeader.text = dict.values.first
        cell.lblValue.text = dict.keys.first
        
        if segmentCtrl.selectedSegmentIndex == 0{
            switch(indexPath.row){
            case 0:
                cell.lblHeader.textColor = UIColor(red: 30/255, green: 177/255, blue: 136/255, alpha: 1.0)
                cell.lblValue.textColor = UIColor(red: 30/255, green: 177/255, blue: 136/255, alpha: 1.0)
            case 1:
                cell.lblHeader.textColor = UIColor(red: 63/255, green: 133/255, blue: 187/255, alpha: 1.0)
                cell.lblValue.textColor = UIColor(red: 63/255, green: 133/255, blue: 187/255, alpha: 1.0)
            case 2 :
                cell.lblHeader.textColor = UIColor(red: 238/255, green: 138/255, blue: 15/255, alpha: 1.0)
                cell.lblValue.textColor = UIColor(red: 238/255, green: 138/255, blue: 15/255, alpha: 1.0)
            case 3 :
                cell.lblHeader.textColor = UIColor(red: 198/255, green: 63/255, blue: 5/255, alpha: 1.0)
                cell.lblValue.textColor = UIColor(red: 198/255, green: 63/255, blue: 5/255, alpha: 1.0)
            case 4 :
                cell.lblHeader.textColor =  UIColor(red: 176/255, green: 36/255, blue: 33/255, alpha: 1.0)
                cell.lblValue.textColor = UIColor(red: 176/255, green: 36/255, blue: 33/255, alpha: 1.0)
            default:
                cell.lblHeader.textColor = UIColor.lightGray
                cell.lblValue.textColor = UIColor.lightGray
                
            }
            
        }else{
            cell.lblHeader.textColor = UIColor.lightGray
            cell.lblValue.textColor = UIColor.lightGray
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
   
}


