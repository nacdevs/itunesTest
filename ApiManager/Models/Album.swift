//
//  Album.swift
//  ApiManager
//
//  Created by Nestor on 19/05/2021.
//

import Foundation
public class Album:NSObject {
    public var id:String
    public var artist:String
    public var name:String
    public var art:String
    public var date:String
    public var genre:[Genre]
    public var copyright:String
    public var url:String

    
    init(json:[String:Any]) {
            self.id = json["id"] as! String
            self.artist = json["artistName"] as! String
            self.name = json["name"] as! String
            self.art = json["artworkUrl100"] as! String
            self.copyright = json["copyright"] as! String
            self.date = json["releaseDate"] as! String
            self.url = json["url"] as! String
            self.genre = Genre.getArray(json: json)
        }
    
    static public func getArray(json: [String:Any]) -> Array<Album>{
        var array = Array<Album>()
        guard
            let albums = json["results"] as? [[String: Any]]
            else {
                print("123 array parse error album")
                return array
        }
        for album in albums {
            array.append(Album(json: album))
        }
        return array
    }
}
