# SyncableLyrics

A data model as well as a operational manager which use an array of `TimeTextPair` to store lines of lyrics. Through it you can edit, import and export lyrics, or sync lyrics real-time whose result is represented by `index`.

___

## Properties

```swift
class TimeTextPair: ObservableObject, Identifiable, Hashable {
    
    let id = UUID()
    @Published var time: Double?
    @Published var text: String?
    
    init(time: Double?, text: String?)
    
    var timeInFormat: String?
}

class SyncableLyrics: ObservableObject {
    
    @Published private(set) var lines: [TimeTextPair]
    @Published private(set) var index: Int
    
    var timer: Timer?
    var isEmpty: Bool { indices.isEmpty }
    var count: Int { lines.count }
    var indices: Range<Int> { 0..<lines.count }    
}

```

## Initializing and editing data

There's no explicit `init()`.

```swift
self.lines = []
self.index = -1
```

```swift
// Clear everything
func clear()
// Set nth item's time
func setTime(at index: Int, time: Double)
// Append a new line at the tail
func append(_ line: TimeTextPair)
```

## Importing and exporting

**Pure Text Without Time**: Text is line to line, seperated by `\n`.

**.lrc Format**: `[mm:ss:tt]Text`

```swift
// Import text from String, leaving time nil
func loadText(fromString rawString: String)
// Import time and text from String (.lrc format)
func importFromLRC(lrcString: String)

// Export time and text to String (.lrc format)
func exportToString() -> String
```

## Syncing lyrics with player

Syncing will set `index` to indicate which line is now playing. But if the `time` of the next line is `nil`, syncing will stop working.

```swift
// Manually syncing, often used after editing the process
func sync(player: AVAudioPlayer)
// Start auto syncing, often used after starts playing. It works until stopping at the last line.
func startAutoSync(player: AVAudioPlayer)
// Stop auto syncing, often used after paused or deprecated (often pausing before deprecating).
func stopAutoSync()
```
