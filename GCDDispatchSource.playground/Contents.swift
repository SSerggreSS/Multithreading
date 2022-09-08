import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let timer = DispatchSource.makeTimerSource(queue: .global())
timer.setEventHandler {
    print("!")
}

timer.schedule(wallDeadline: .now(), repeating: 1)
timer.activate()
