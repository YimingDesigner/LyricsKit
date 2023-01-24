//
//  LyricsView.swift
//  
//
//  Created by Yiming Liu on 12/3/22.
//

import SwiftUI
import ModernUI

@available(macOS 13.0, *)
public struct LyricsView: View {
    
    @ObservedObject var lyrics: SyncableLyrics
    let tapAction: (_ time: Double?) -> Void
    
    let font: Font
    let scrollIndicatorVisibility: ScrollIndicatorVisibility
    
    public init(lyrics: SyncableLyrics,
                font : Font = .system(size: 22),
                scrollIndicatorVisibility: ScrollIndicatorVisibility = .automatic,
                tapAction: @escaping (_ time: Double?) -> Void) {
        self.lyrics = lyrics
        self.tapAction = tapAction
        
        self.font = font
        self.scrollIndicatorVisibility = scrollIndicatorVisibility
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(lyrics.indices, id: \.self) { index in
                    let line = lyrics.lines[index]
                    Button {
                        tapAction(line.time)
                    } label: {
                        Text(line.text ?? "")
                            .font(font)
                            .bold()
                            .padding(10)
                            .foregroundColor((index == lyrics.index) ? .primary : .tertiary)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(ShadeButtonStyle(.wrapped, size: .huge))
                }
            }
            .padding()
        }
        .scrollIndicators(scrollIndicatorVisibility)
    }
    
}

@available(macOS 13.0, *)
struct LyricsView_Previews: PreviewProvider {
    
    static var previews: some View {
        LyricsView(lyrics: SyncableLyrics()) { time in
            print(time ?? 0)
        }
    }
}
