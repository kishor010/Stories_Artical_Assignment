//
//  StoriesModel.swift
//  Assignment
//
//  Created by Kishor Pahalwani on 15/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//

import Foundation

struct StoriesModel: Codable {
    
    var by: String?
    var descendants: Int?
    var id: String?
    var score: Int?
    var parent_id: String?
    var time: TimeInterval?
    var No: Int?
    var title: String?
    var type: String?
    var url: String?
    var kids: [Int] = []
    //var comments
    
    enum CodingKeys: String, CodingKey {
        case by
        case descendants
        case id
        case score
        case time
        case title
        case type
        case url
        case kids
        case parent_id
    }
    
    init(by: String?, descendants: Int?, id: String?, score: Int?, parent_id: String?, time: TimeInterval?, No: Int?, title: String?, type: String?, url: String?, kids: [Int]) {
        self.by = by
        self.descendants = descendants
        self.id = id
        self.score = score
        self.parent_id = parent_id
        self.time = time
        self.No = No
        self.title = title
        self.type = type
        self.url = url
        self.kids = kids
    }
    
    //helps to Encode the object
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(by, forKey: .by)
        try container.encode(descendants, forKey: .descendants)
        try container.encode(id, forKey: .id)
        try container.encode(score, forKey: .score)
        try container.encode(time, forKey: .time)
        try container.encode(title, forKey: .title)
        try container.encode(type, forKey: .type)
        try container.encode(url, forKey: .url)
        try container.encode(kids, forKey: .kids)
        try container.encode(parent_id, forKey: .parent_id)
    }
    
    //helps to Decode the object
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        by = try container.decode(String.self, forKey: .by)
        descendants = try container.decode(Int.self, forKey: .descendants)
        id = try container.decode(String.self, forKey: .id)
        score = try container.decode(Int.self, forKey: .score)
        time = try container.decode(TimeInterval.self, forKey: .time)
        title = try container.decode(String.self, forKey: .title)
        type = try container.decode(String.self, forKey: .type)
        url = try container.decode(String.self, forKey: .url)
        kids = try container.decode([Int].self, forKey: .kids)
        parent_id = try container.decode(String.self, forKey: .parent_id)
    }
}

class CodingKeysStories {
    static let by = "by"
    static let descendants = "descendants"
    static let id = "id"
    static let score = "score"
    static let time = "time"
    static let title = "title"
    static let type = "type"
    static let url = "url"
    static let kids = "kids"
    static let parent = "parent"
}
