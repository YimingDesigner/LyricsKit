//
//  LyricsButtonStyle.swift
//  
//
//  Created by Yiming Liu on 4/9/23.
//

import Foundation
import SwiftUI

@available(macOS 13.0, *)
public struct LyricsButtonStyle: ButtonStyle {
    
    @Environment(\.controlSize) var controlSize
    @State var onHover: Bool = false
    
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .foregroundColor(configuration.isPressed ? .primary : .secondary)
            .background {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(onHover ? (configuration.isPressed ? .secondaryShade : .primaryShade) : .clear)
            }
            .onHover { onHover = $0 }
    }
}
