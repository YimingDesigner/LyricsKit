//
//  TimeTextPair.swift
//  
//
//  Created by Yiming Liu on 12/3/22.
//

import Foundation

@available(macOS 10.15, *)
public class TimeTextPair: ObservableObject, Identifiable, Hashable {
    
    public let id = UUID()
    @Published public var time: Double?
    @Published public var text: String?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: TimeTextPair, rhs: TimeTextPair) -> Bool {
        return lhs.id == rhs.id
    }
    
    public init(time: Double?, text: String?) {
        self.time = time
        self.text = text
    }
    
    public var timeInFormat: String? {
        if let time = time {
            return String(String(format: "%02d", Int(time)/60) + ":" + String(format: "%02d", Int(time)%60) + "." + String(format: "%02d", Int(time*100)%100))
        } else {
            return nil
        }
    }
}
