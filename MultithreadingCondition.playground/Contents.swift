import UIKit

//MARK: - C

var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()
var arrayWrite = [String]()

final class ConditionMutextPrinter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printerMethod()
    }
    
    private func printerMethod() {
        defer {
            print("Printer exit")
            pthread_mutex_unlock(&mutex)
        }
        pthread_mutex_lock(&mutex)
        print("Printer enter")
        if !available {
            pthread_cond_wait(&condition, &mutex)
        }
        print(arrayWrite)
        available = false
    }
}

final class ConditionMutextWraiter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writerMethod()
    }
    
    private func writerMethod() {
        defer {
            print("Wraiter exit")
            pthread_mutex_unlock(&mutex)
        }
        pthread_mutex_lock(&mutex)
        print("Wraiter enter")
        arrayWrite.append(contentsOf: ["one", "two", "tree", "four"])
        available = true
        pthread_cond_signal(&condition)
    }
}


let printer = ConditionMutextPrinter()
let writer = ConditionMutextWraiter()
printer.start()
writer.start()



//MARK: - Swift

var cond = NSCondition()
var ava = false

final class PrinterThread: Thread {
    
    override func main() {
        defer {
            cond.unlock()
            print("PrinterThread exit")
        }
        cond.lock()
        print("PrinterThread enter")
        while !ava {
            cond.wait()
        }
        print(arrayWrite)
        ava = false
    }
}

final class WriterThread: Thread {
    
    override func main() {
        defer {
            cond.unlock()
            print("WriterThread exit")
        }
        cond.lock()
        print("WriterThread enter")
        arrayWrite.removeFirst()
        arrayWrite.insert("testFirst", at: 0)
        ava = true
        cond.signal()
    }
}

let printing = PrinterThread()
let writing = WriterThread()

printing.start()
writing.start()













