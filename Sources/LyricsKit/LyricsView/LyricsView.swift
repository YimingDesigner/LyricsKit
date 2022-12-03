//
//  LyricsView.swift
//  
//
//  Created by Yiming Liu on 12/3/22.
//

import SwiftUI

@available(macOS 12.0, *)
public struct LyricsView: View {
    
    @ObservedObject var lyrics: SyncableLyrics
    let tapAction: (_ time: Double?) -> Void
    
    public init(lyrics: ObservedObject<SyncableLyrics>, tapAction: @escaping (_ time: Double?) -> Void) {
        self._lyrics = lyrics
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

@available(macOS 12.0, *)
struct LyricsView_Previews: PreviewProvider {
    
    static let lyrics = SyncableLyrics()
    
    init() {
        LyricsView_Previews.lyrics
            .append(TimeTextPair(time: 10, text: "We should be daydreamers"))
        LyricsView_Previews.lyrics
            .append(TimeTextPair(time: 20, text: "We all should be daydreamers"))
    }
    
    static var previews: some View {
        LyricsView(lyrics: ObservedObject(wrappedValue: lyrics)) { time in
            print(time ?? 0)
        }
    }
}
