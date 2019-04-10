//
//  MessageService.swift
//  Smack
//
//  Created by Nan on 2019/3/14.
//  Copyright © 2019 nan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel : Channel?
    // 獲取所有頻道
    func findAllChannel(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_FIND_ALL_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                // 解開response的data
                guard let data = response.data else { return }
                if let json = JSON(data: data).array {
                    for item in json {
                        let title = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: title, channelDescription: description, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
/*
             // 使用JSONDecoder取回Channel (Channel的model需要繼承Decodable)
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                    print(self.channels)
                } catch let error {
                    debugPrint(error as Any)
                }
*/
            } else {
                // 出現error
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
}
