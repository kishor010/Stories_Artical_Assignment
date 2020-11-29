//
//  StoriesViewModel.swift
//  Assignment
//
//  Created by Kishor Pahalwani on 15/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol StoryListProtocol: class {
    func success(listData: [StoriesModel])
    func failure(error: String)
}

class StoriesViewModel {
    
    weak var delegate: StoryListProtocol?
    
    //API call to get story list
    func getStories(count: Int?) {
        NetworkManager.sharedInstance.apiToGetStoryList(onSuccess: { (json) in
            self.FetchListOfStoryItems(count: count, data: json, completed: { (data) in
                self.delegate?.success(listData: data)
            })
            
        }) { (error) in
            self.delegate?.failure(error: error)
        }
    }
    
    //fetch individual item
    func FetchListOfStoryItems(count: Int?, data: JSON, completed: @escaping ([StoriesModel]) -> ()) {
        
        var arrStories: [StoriesModel] = []
        
        if let dataArray = data.array {
            var totalCount = dataArray.count
            if count != nil && dataArray.count > count! {
                totalCount = count!
            }
            debugPrint("Total Count \(totalCount)")
            
            //Async call
            let myGroup = DispatchGroup()
            for itemIndex in 0..<totalCount {
                //debugPrint(itemIndex)
                myGroup.enter()
                if let itemId = dataArray[itemIndex].rawValue as? Int, !String(itemId).contains("") {
                    self.apiCallForItemDetails(itemId: String(itemId), noAt: itemIndex + 1) { (modelValue) in
                        if let value = modelValue {
                            arrStories.append(value)
                        }
                        myGroup.leave()
                    }
                }
            }
            
            myGroup.notify(queue: .main) {
                completed(arrStories)
            }
        }
    }
    
    func apiCallForItemDetails(itemId: String, noAt: Int?, completed: @escaping (StoriesModel?) -> ()) {
        NetworkManager.sharedInstance.apiToGetItemDetails(itemId: String(itemId), onSuccess: { (json) in
            completed(self.parseData(jsonData: json, indexValue: noAt))
        }) { (error) in
            completed(nil)
        }
    }
    
    func parseData(jsonData: JSON?, indexValue: Int?) -> StoriesModel? {
        
        if let json = jsonData {
            var itemId: String?
            var parentId: String?
            if let id = json[CodingKeysStories.id].rawValue as? Int {
                itemId = String(id)
            }
            if let parent_id = json[CodingKeysStories.parent].rawValue as? Int {
                parentId = String(parent_id)
            }
            let by = json[CodingKeysStories.by].rawValue as? String
            let descendants = json[CodingKeysStories.descendants].rawValue as? Int
            let score = json[CodingKeysStories.score].rawValue as? Int
            let time = json[CodingKeysStories.time].rawValue as? TimeInterval
            let title = json[CodingKeysStories.title].rawValue as? String
            let url = json[CodingKeysStories.url].rawValue as? String
            let type = json[CodingKeysStories.type].rawValue as? String
            let kids = json[CodingKeysStories.kids].rawValue as? [Int]
            
            return self.bindModel(by: by, descendants: descendants, itemId: itemId, score: score, parentId: parentId, time: time, indexValue: indexValue, title: title, type: type, url: url, kids: kids)
        }
        return nil
    }
    
    func bindModel(by: String?, descendants: Int?, itemId: String?, score: Int?, parentId: String?, time: TimeInterval?, indexValue: Int?, title: String?, type: String?, url: String?, kids: [Int]?) -> StoriesModel? {
        let model = StoriesModel.init(by: by, descendants: descendants, id: itemId, score: score, parent_id: parentId, time: time, No: indexValue, title: title, type: type, url: url, kids: kids ?? [])
        return model
    }
}
