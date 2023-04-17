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
    
    @Environment(\.font) var font
    @Environment(\.verticalScrollIndicatorVisibility) var verticalScrollIndicatorVisibility
    @Environment(\.scrollAnchor) var scrollAnchor
    @Environment(\.emptyLinePlaceholder) var emptyLinePlaceholder
    
    public init(lyrics: SyncableLyrics, tapAction: @escaping (_ time: Double?) -> Void) {
        self.lyrics = lyrics
        self.tapAction = tapAction
    }
    
    public var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(lyrics.indices, id: \.self) { index in
                        Button {
                            tapAction(lyrics.lines[index].time)
                        } label: {
                            Text(lyrics.lines[index].text ?? emptyLinePlaceholder)
                                .font(font)
                                .bold()
                                .padding(10)
                                .foregroundColor((index == lyrics.index) ? .primary : .tertiary)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(WrapUmbrageButtonStyle())
                        .id(index)
                    }
                }
                .padding()
            }
            .scrollIndicators(verticalScrollIndicatorVisibility)
            .onChange(of: lyrics.index) { newIndex in
                withAnimation {
                    scrollProxy.scrollTo(newIndex, anchor: UnitPoint(x: 0.5, y: scrollAnchor))
                }
            }
            
        }
    }
    
}

// MARK: - Environment Values

private struct ScrollAnchorKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.1
}

private struct EmptyLinePlaceholderKey: EnvironmentKey {
    static let defaultValue: String = "•••"
}

@available(macOS 13.0, *)
extension EnvironmentValues {
    var scrollAnchor: CGFloat {
        get { self[ScrollAnchorKey.self] }
        set { self[ScrollAnchorKey.self] = newValue }
    }
    var emptyLinePlaceholder: String {
        get { self[EmptyLinePlaceholderKey.self] }
        set { self[EmptyLinePlaceholderKey.self] = newValue }
    }
}

@available(macOS 13.0, *)
public extension View {
    func scrollAnchor(_ anchor: CGFloat) -> some View {
        environment(\.scrollAnchor, anchor)
    }
    
    func emptyLinePlaceholder(_ placeholder: String) -> some View {
        environment(\.emptyLinePlaceholder, placeholder)
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
