//
//  Genre.swift
//  ApiManager
//
//  Created by Nestor on 19/05/2021.
//

import Foundation
public class Genre{
    public var id:String
    public var name:String
    public var url:String
        
    init(json:[String:Any]){
        self.id = json["genreId"] as! String
        self.name = json["name"] as! String
        self.url = json["url"] as! String
    }
    
    static public func getArray(json: [String:Any]) -> Array<Genre>{
           
           var array = Array<Genre>()
           guard
               let genres = json["genres"] as? [[String: Any]]
               else {
                   print("123 array parse error")
                   return array
           }
           for genre in genres {
               array.append(Genre(json: genre))
           }
           return array
       }
}
