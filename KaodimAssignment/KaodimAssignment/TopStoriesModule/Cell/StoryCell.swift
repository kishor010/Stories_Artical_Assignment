//
//  StoryCell.swift
//  Assignment
//
//  Created by Kishor Pahawani on 15/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {

    @IBOutlet weak var labelComments: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    @IBOutlet weak var imageViewComment: UIImageView!
    @IBOutlet weak var imageViewPoints: UIImageView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelTitleNo: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData(model: StoriesModel, no: Int) {
        
        labelTitle.text = model.title
        labelAuthor.text = Utils.localizedString(forKey: Keys.by) + ": " + (model.by ?? "NA")
        imageViewComment.image = UIImage(named: "Comment")
        imageViewPoints.image = UIImage(named: "Score")
        
        if let comments = model.descendants {
            labelComments.text = String(comments)
        }
        else {
            labelComments.text = "NA"
        }
        
        if let score = model.score {
            labelPoints.text = String(score)
        }
        else {
            labelPoints.text = "NA"
        }
        
        if let time = model.time, let strTime = DateHelper.convertUnixTime(time: time) {
            labelTime.text = strTime
        }
        
        else {
            labelTime.text = "NA"
        }
        
        labelTitleNo.text = String(no) + ". "
    }
}
