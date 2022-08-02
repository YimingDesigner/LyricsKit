//
//  IndexSubscript.swift
//  
//
//  Created by Yiming Liu on 7/31/22.
//

import Foundation

extension Dictionary {
    
    subscript(i: Int) -> (key: Key, value: Value) {
        get {
            return self[index(startIndex, offsetBy: i)]
        }
    }
    
}

extension StringProtocol {
    
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
}

extension StringProtocol  {
    
    func substring<S: StringProtocol>(from start: S, options: String.CompareOptions = []) -> SubSequence? {
        guard let lower = range(of: start, options: options)?.upperBound
        else { return nil }
        return self[lower...]
    }
    
    func substring<S: StringProtocol, T: StringProtocol>(from start: S, to end: T, options: String.CompareOptions = []) -> SubSequence? {
        guard let lower = range(of: start, options: options)?.upperBound,
            let upper = self[lower...].range(of: end, options: options)?.lowerBound
        else { return nil }
        return self[lower..<upper]
    }
    
}
