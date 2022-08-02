import Foundation
import AVFAudio

@available(macOS 10.15, *)
public class TimeTextPair: ObservableObject, Identifiable, Hashable {
    
    public let id = UUID()
    @Published public var time: Double?
    @Published public var text: String?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: TimeTextPair, rhs: TimeTextPair) -> Bool {
        return lhs.id == rhs.id
    }
    
    public init(time: Double?, text: String?) {
        self.time = time
        self.text = text
    }
    
    public var timeInFormat: String? {
        if let time = time {
            return String(String(format: "%02d", Int(time)/60) + ":" + String(format: "%02d", Int(time)%60) + "." + String(format: "%02d", Int(time*100)%100))
        } else {
            return nil
        }
    }
}

@available(macOS 10.15, *)
public class SyncableLyrics: ObservableObject {
    
    @Published public private(set) var lines: [TimeTextPair] = []
    @Published public private(set) var index: Int = -1
    
    public var timer: Timer?       // Sync use
    public var isEmpty: Bool { indices.isEmpty }
    public var count: Int { lines.count }
    public var indices: Range<Int> { 0..<lines.count }
    
    public init() {}
    
    public func clear() {
        self.lines = []
        index = -1
    }
    
    public func append(_ line: TimeTextPair) {
        self.lines.append(line)
    }
    
    public func setTime(at index: Int, time: Double) {
        if self.indices.contains(index) {
            self.lines[index].time = time
            self.objectWillChange.send()
        }
    }
    
    public func loadText(fromString rawString: String) {
        self.clear()
        for text in splitToLine(rawString: rawString) {
            self.append(TimeTextPair(time: nil, text: text))
        }
    }
    
    private func splitToLine(rawString: String) -> [String] {
        var lines: [String] = []
        for line in rawString.components(separatedBy: "\n") {
            if !line.isEmpty {
                lines.append(line)
            }
        }
        return lines
    }
    
    public func exportToString() -> String {
        var output = "[00:00.00]\n"
        
        for line in lines {
            output += "[" + (line.timeInFormat ?? "") + "]" + (line.text ?? "") + "\n"
        }
        
        return output
    }
    
    public func importFromLRC(lrcString: String) {
        for line in splitToLine(rawString: lrcString) {
            if line.count > 1 && line[1].isNumber {
                let minutes = Double(line.substring(from: "[", to: ":") ?? "0") ?? 0
                let seconds = Double(line.substring(from: ":", to: ".") ?? "0") ?? 0
                let hundredthSeconds = Double(line.substring(from: ".", to: "]") ?? "0") ?? 0
                let text = String(line.substring(from: "]") ?? "")
                
                self.append(TimeTextPair(time: minutes*60 + seconds + hundredthSeconds/100, text: text))
            }
        }
    }
    
    //
    // Methods used to sync
    //
    
    public func sync(player: AVAudioPlayer) {
        stopAutoSync()
        var lastIndex = -1
        
        for (index, line) in lines.enumerated() {
            if let nthTime = line.time {
                if player.currentTime >= nthTime {
                    lastIndex = index
                }
            } else { break }
        }
        
        self.index = lastIndex
        startAutoSync(player: player)
    }
    
    public func startAutoSync(player: AVAudioPlayer) {
        if indices.contains(index+1) {
            if let nextTime = lines[index+1].time {
                self.timer?.invalidate()
                self.timer = Timer.scheduledTimer(withTimeInterval: nextTime - player.currentTime, repeats: false) { _ in
                    self.index += 1
                    self.startAutoSync(player: player)
                }
            }
        }
    }
    
    public func stopAutoSync() {
        self.timer?.invalidate()
        self.timer = nil
    }
        
}
