//
//  MainPresenter.swift
//  itunesTest
//
//  Created by Nestor on 21/05/2021.
//

import Foundation
import ApiManager
public class MainPresenter{
    public var prot : PresenterProtocol

    public init(presenterProtocol: PresenterProtocol) {
         self.prot = presenterProtocol
     }
    
    
    public func load50(){
        ApiManagerService.shared.get50Albums {
            //
        } onFinishRequest: {
            //
        } onError: { (status) in
            if(status == 800){
                self.prot.errorToUI()
            }else{
                print("Error--->\(status)")
            }
        } onFatal: {
            //
        } onResponse: { (status, array) in
            self.prot.results(data:array)
        }

        
    }
}


public protocol PresenterProtocol: NSObjectProtocol {
    func results(data:[Any])
    func errorToUI()
}
