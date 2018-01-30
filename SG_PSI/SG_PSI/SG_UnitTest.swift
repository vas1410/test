//
//  SG_UnitTest.swift
//  SG_PSI
//
//  Created by v.vajiravelu on 30/1/18.
//  Copyright © 2018 vas. All rights reserved.
//

import Foundation
import Quick
import Nimble
class SG_PSiSpec : QuickSpec {
    override func spec() {
        super.spec()
        
        describe("Network test") {
          context("success") {
            it("should pass") {
               // expect(1).to(equal(1))
                ApiManagerss.getRequest( { (successReturnObject) in
                   
                 expect(successReturnObject).toEventuallyNot(beNil())
                    
                }, failure: { (failureReturnObject) in
                   
                })
            }
        }
          
            context("Fail") {
                it("return error") {
                    // expect(1).to(equal(1))
                    ApiManagerss.appID = "dfnjknfjkfnkkdndggggg"
                    ApiManagerss.getRequest( { (successReturnObject) in
                        
                       
                        
                    }, failure: { (failureReturnObject) in
                        expect(failureReturnObject).toEventuallyNot(beNil())
                    })
                }
            }
            
        }
        
        
        describe("Data test") {
            context("success") {
                it("should pass") {
                    // expect(1).to(equal(1))
                    ApiManagerss.getRequest( { (successReturnObject) in
                        var psireading = PSIReadings.init(successReturnObject["items"][0]["readings"]["psi_twenty_four_hourly"])
                    
                        expect(Int(psireading.national!)).to(beLessThan(50))  // Test Psi reading undercontrol
                        
                    }, failure: { (failureReturnObject) in
                        
                    })
                }
            }
            
          
            
        }
    }
}
