//
//  itunesTestTests.swift
//  itunesTestTests
//
//  Created by Nestor on 19/05/2021.
//

import XCTest
import ApiManager
@testable import itunesTest

class itunesTestTests: XCTestCase,PresenterProtocol {
    
    var promise = XCTestExpectation()
    func results(data: [Any]) {
        promise.fulfill()
    }
    
    func errorToUI() {
        XCTFail()
    }
    

 
    func mainPresenterTest() throws {
        promise = self.expectation(description: "Results")
        let presenter = MainPresenter.init(presenterProtocol: self)
        presenter.load50();
        wait(for: [promise], timeout: 10)

    }

   

}
