//
//  LyricsView.swift
//  
//
//  Created by Yiming Liu on 12/3/22.
//

import SwiftUI

@available(macOS 13.0, *)
public struct LyricsView: View {
    
    let lyrics: SyncableLyrics
    let tapAction: (_ time: Double?) -> Void
    
    public init(lyrics: SyncableLyrics, tapAction: @escaping (_ time: Double?) -> Void) {
        self.lyrics = lyrics
        self.tapAction = tapAction
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(lyrics.indices, id: \.self) { index in
                    LyricsRow(line: lyrics.lines[index], isHighlighted: index == lyrics.index ? true : false, tapAction: tapAction)
                }
            }
            .padding()
        }
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
