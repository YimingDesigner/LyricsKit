//
//  LyricsRow.swift
//  
//
//  Created by Yiming Liu on 12/3/22.
//

import SwiftUI
import ModernUI

@available(macOS 13.0, *)
struct LyricsRow: View {
    
    let line: TimeTextPair
    let isHighlighted: Bool
    let tapAction: (_ time: Double?) -> Void
    
    var body: some View {
        Button {
            tapAction(line.time)
        } label: {
            Text(line.text ?? "")
                .font(.title)
                .bold()
                .padding(10)
                .foregroundColor(isHighlighted ? .primary : .tertiary)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(ShadeButtonStyle(.wrapped, size: .huge))
    }
}

// MARK: - Preview

@available(macOS 13.0, *)
struct LyricsRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LyricsRow(line: TimeTextPair(time: 10, text: "Come together"), isHighlighted: false) { time in
                print(time ?? 0)
            }
            LyricsRow(line: TimeTextPair(time: 15, text: "Come together"), isHighlighted: true) { time in
                print(time ?? 0)
            }
        }
        .frame(height: 300)
    }
}
