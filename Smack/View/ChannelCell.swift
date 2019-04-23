//
//  ChannelCell.swift
//  Smack
//
//  Created by Nan on 2019/3/17.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var channelNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            // 被選中的cell要更改背景顏色為
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel) {
        let title = channel.channelTitle ?? ""
        channelNameLbl.text = "#\(title)"
        channelNameLbl.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        for channelId in MessageService.instance.unreadChannels {
            if channelId == channel.id {
                channelNameLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
        
    }

}
