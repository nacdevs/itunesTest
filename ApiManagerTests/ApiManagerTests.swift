//
//  ApiManagerTests.swift
//  ApiManagerTests
//
//  Created by Nestor on 19/05/2021.
//

import XCTest
@testable import ApiManager

class ApiManagerTests: XCTestCase {

    func get50AlbumsTest() {
        
        let promise = expectation(description: "Status code: 200")

        ApiManagerService.shared.get50Albums {
            //
        } onFinishRequest: {
            //
        } onError: { (status) in
            print(status)
            XCTFail()
        } onFatal: {
            //
        } onResponse: { (status, list) in
            if(status == 200 && list.count>0){
                promise.fulfill()
            }else{
                XCTFail("Status code: \(status)")
            }

        }
        wait(for: [promise], timeout: 10)

    }

  

}
