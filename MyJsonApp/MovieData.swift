//
//  MovieData.swift
//  MyJsonApp
//
//  Created by VorkYu on 2019/8/23.
//  Copyright © 2019 VorkYu. All rights reserved.
//

import Foundation

struct MovieData: Codable {
    var feed : Feed
}

struct Feed: Codable {
    var title: String
    var id: URL
    
    struct Author: Codable {
        var name: String
        var uri: URL
    }
    var author: Author
    
    struct Links: Codable {
        var `self`: URL?
        var alternate: URL?
    }
    var links: [Links]
    
    var copyright: String
    var country: String
    var icon: URL
    var updated: String
    
    var results:[Results]
}

struct Results: Codable {
    var artistName: String
    var id: String
    var releaseDate: String
    var name: String
    var kind: String
    var artistId: String?
    var copyright: String?
    var artistUrl: URL?
    var artworkUrl100: URL
    
    struct Genre: Codable {
        var genreId: String
        var name: String
        var url: URL
        }
    var genres: [Genre]
    var url: URL
}
