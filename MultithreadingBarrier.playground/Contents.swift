import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var array = [Int]()

for i in 0...9 {
    array.append(i)
}
print(array)
print(array.count)

var array2 = [Int]()

DispatchQueue.concurrentPerform(iterations: 10) { index in
    array2.append(index)
}
print(array2)
print(array2.count)

final class SafeArray<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "queue", qos: .utility, attributes: .concurrent)
    func append(element: T) {
        queue.async(flags: .barrier) {
            self.array.append(element)
        }
    }

    var valueArray: [T] {
        var result = [T]()
        queue.sync {
            result = self.array
        }
        return result
    }
}

let safeArray = SafeArray<Int>()
print("safeArray", safeArray.valueArray)

DispatchQueue.concurrentPerform(iterations: 10) { i in
    safeArray.append(element: i)
}

print("safeArray", safeArray.valueArray)
