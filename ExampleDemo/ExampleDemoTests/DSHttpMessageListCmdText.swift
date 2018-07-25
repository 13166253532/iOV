//
//  DSHttpMessageListCmdText.swift
//  ExampleDemoTests
//
//  Created by xiejiangbo on 2018/1/23.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import XCTest

@testable import ExampleDemo

class DSHttpMessageListCmdText: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDSHttpMessageListCmd() {
//        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
//        let cmd:HttpCommand = DSHttpMessageListCmd.init(version: PHttpVersion_v1)
//
//        let dic:NSMutableDictionary = NSMutableDictionary()
//        dic[kHttpParamKey_PerInvestmentList_sortType] = "DESC"
//        dic[kHttpParamKey_PerInvestmentList_sortItem] = "followCount"
//
//        cmd.requestInfo = dic as [NSObject:AnyObject]
//
//        cmd.completeDelegate = completeDelegate
//
//        print("url == %@",cmd.getUrl())
//        cmd.execute()
//        completeDelegate.waitForComplete()
//        XCTAssert(cmd.result.isOk())
//        let r:DSHttpMessageListResult = cmd.result as! DSHttpMessageListResult
//        if r.isOk() {
//            print("success")
//        }else{
//            print("failed")
//        }
        let array = NSMutableArray()
        for index in 0..<10 {
            let model = CompanyListInfoMode()
            model.org_id = String(8+index)
            model.org_name = String(100-index)
            array.add(model)
        }
        self.sequencePerTime(arr: array)
        
    }
    func sequencePerTime(arr:NSMutableArray)  {
        let list = arr.sortedArray { (infor1, infor2) -> ComparisonResult in
            let infor3 = infor1 as! CompanyListInfoMode
            let infor4 = infor2 as! CompanyListInfoMode
            let org_id3:Int = Int(infor3.org_id!)!
            let org_id4:Int = Int(infor4.org_id!)!
            if org_id3 > org_id4 {
                return ComparisonResult.orderedDescending
            }else if org_id3 < org_id4 {
                return ComparisonResult.orderedAscending
            }else{
                return ComparisonResult.orderedSame
            }
        }
        for index in 0..<list.count {
            let model:CompanyListInfoMode = list[index] as! CompanyListInfoMode
            print(model.org_id)
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
