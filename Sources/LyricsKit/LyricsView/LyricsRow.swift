//
//  LyricsRow.swift
//  
//
//  Created by Yiming Liu on 12/3/22.
//

import SwiftUI

@available(macOS 12.0, *)
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
                .padding()
                .foregroundColor(isHighlighted ? .primary : .secondary)
        }
        .buttonStyle(LyricsButtonStyle())
    }
}

@available(macOS 12.0, *)
struct LyricsButtonStyle: ButtonStyle {
    
    @State private var isOnHover: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .background(isOnHover ? AnyShapeStyle(.ultraThickMaterial) : AnyShapeStyle(Color.black.opacity(0)))
            .cornerRadius(6)
            .onHover { onHover in
                self.isOnHover = onHover
            }
    }
    
}

@available(macOS 12.0, *)
struct LyricsRow_Previews: PreviewProvider {
    static var previews: some View {
        LyricsRow(line: TimeTextPair(time: 1124, text: "Come together"), isHighlighted: true) { time in
            print(time ?? 0)
        }
    }
}
