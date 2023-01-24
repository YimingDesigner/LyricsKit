# LyricsKit

## SyncableLyrics

`SyncableLyrics` is all you need to store, manage, and sync your lyrics with time tag attached.

Inside the class, an array of `TimeTextPair` is borrowed to store lines of lyrics. Through it you can edit, import and export lyrics, or sync lyrics in real-time with `index`.

There are some frequently used properties of `SyncableLyrics`.

```swift
isEmpty: Bool
count: Int
indices: Range<Int>
```

###  Editing data

```swift
// Clear everything
func clear()
// Set time for nth item
func setTime(at index: Int, time: Double)
// Append a new line at the tail
func append(_ line: TimeTextPair)
```

### Importing and exporting

```swift
// Import text from String, leaving time nil
func loadText(fromString rawString: String)
// Import time and text from String (.lrc format)
func importFromLRC(lrcString: String)

// Export time and text to String (.lrc format)
func exportToString() -> String
```

> **Pure Text Without Time**: Text is line to line, seperated by `\n`.
>
> **.lrc Format**: `[mm:ss:tt]Text`

### Syncing lyrics with player

Syncing will set `index` to indicate which line is now playing. But if the `time` of the next line is `nil`, syncing will stop working.

```swift
// Manually syncing, often used after moving process
func sync(player: AVAudioPlayer)
// Start auto syncing, often used after starts playing. It works until reaching the last line.
func startAutoSync(player: AVAudioPlayer)
// Stop auto syncing, often used after paused or deprecated (often pause it before deprecate).
func stopAutoSync()
```

## LyricsView

The elegant `LyricsView` is employed to display lyrics in real-time manner.

```swift
LyricsView(lyrics: SyncableLyrics
           font: Font = .system(size: 22),
           scrollIndicatorVisibility: ScrollIndicatorVisibility = .automatic) { time in
    // player.currentTime = time
    // action when lyrics button is pressed
}
```

