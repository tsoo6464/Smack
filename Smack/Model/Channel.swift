//
//  Channel.swift
//  Smack
//
//  Created by Nan on 2019/3/14.
//  Copyright © 2019 nan. All rights reserved.
//

import Foundation

struct Channel {
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}

/* 使用JSONDecoder
 
 
 struct Channel: Decodable {
 // 使用Decodable的話 變數的名稱跟順序要跟回傳的JSON一樣
 public private(set) var _id: String!
 public private(set) var description: String!
 public private(set) var name: String!
 public private(set) var __v: Int?
 }
 */
