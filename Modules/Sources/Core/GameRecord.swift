//
//  GameRecord.swift
//  
//
//  Created by 若江照仁 on 2023/02/15.
//

import Foundation

public struct GameRecord {
    public var time: Double?
    public var star1: Bool
    public var star2: Bool
    public var star3: Bool
    public init(time: Double? = nil, star1: Bool, star2: Bool, star3: Bool) {
        self.time = time
        self.star1 = star1
        self.star2 = star2
        self.star3 = star3
    }
}

public extension GameRecord {
    mutating func merge(_ record: Self) {
        self = merged(record)
    }
    
    func merged(_ record: Self) -> Self {
        let newTime: Double?
        if self.time == nil && record.time == nil {
            newTime = nil
        } else {
            newTime = min(record.time ?? .infinity, self.time ?? .infinity)
        }
        return .init(
            time: newTime,
            star1: record.star1 || self.star1,
            star2: record.star2 || self.star2,
            star3: record.star3 || self.star3
        )
    }
}