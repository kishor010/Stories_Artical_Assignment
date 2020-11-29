//
//  StoriesModel.swift
//  Assignment
//
//  Created by Kishor Pahalwani on 15/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//

import Foundation

/*struct StoriesModel: Codable {
    
    var id: String?
    var parent_id: String?
    var No: Int?
    var commentsCount: Int?
    var title: String?
    var author: String?
    var type: String?
    var created_at: String?
    var points: Int?
    var url: String?
    var story_id: String?
    var childrens: [StoriesModel]
    
    enum CodingKeys: String, CodingKey {
        case poster_path
        case id
        case title
        case overview
        case release_date
    }
    
    init(poster_path: String?, id: String?, title: String?, overview: String?, release_date: String?) {
        self.poster_path = poster_path
        self.id = id
        self.title = title
        self.overview = overview
        self.release_date = release_date
    }
    
    //helps to Encode the object
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(poster_path, forKey: .poster_path)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
        try container.encode(release_date, forKey: .release_date)
    }
    
    //helps to Decode the object
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        poster_path = try container.decode(String.self, forKey: .poster_path)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        release_date = try container.decode(String.self, forKey: .release_date)
    }
}*/
