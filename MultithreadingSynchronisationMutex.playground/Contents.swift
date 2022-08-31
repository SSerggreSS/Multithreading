import Foundation

// C

final class CSaveThread {
    
    // Обьявление мьютекса
    private var mutex = pthread_mutex_t()
    
    init() {
        // Инициализация мьютекса
        pthread_mutex_init(&mutex, nil)
    }
    
    func makeLock(completion: () -> ()) {
        defer {
            // Разблокировка потока
            pthread_mutex_unlock(&mutex)
        }
        // Блокирование потока
        pthread_mutex_lock(&mutex)
        completion()
    }
    
}

var array = [String]()
let saveThread = CSaveThread()
saveThread.makeLock {
    print("test")
    array.append("1 thread")
}

array.append("2 thread")

// Swift

final class SSaveThread {
    
    private let lockMutex = NSLock()
    
    func makeLock(completion: () -> ()) {
        defer {
            lockMutex.unlock()
        }
        lockMutex.lock()
        completion()
    }
}

var intArray = [Int]()
let ssaveThread = SSaveThread()
ssaveThread.makeLock {
    intArray.append(0)
    intArray.append(1)
}

intArray.append(2)
