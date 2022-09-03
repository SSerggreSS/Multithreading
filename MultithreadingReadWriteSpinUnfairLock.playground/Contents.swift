import UIKit

final class ReadWriteLock {
    private var lock = pthread_rwlock_t()
    private var rwAttribute = pthread_rwlockattr_t()
    
    private var globalProperty = 0
    
    init() {
        pthread_rwlock_init(&lock, &rwAttribute)
    }
    
    public var workProperty: Int {
        get {
            pthread_rwlock_wrlock(&lock)
            let temp = globalProperty
            pthread_rwlock_unlock(&lock)
            return temp
        }
        set {
            pthread_rwlock_wrlock(&lock)
            globalProperty = newValue
            pthread_rwlock_unlock(&lock)
        }
    }
}

let readWriteLock = ReadWriteLock()
readWriteLock.workProperty = 100
print(readWriteLock.workProperty)

// iOS, deprecated: 10.0
//final class SpinLock {
//    private var lock = OS_SPINLOCK_INIT
//    func someMethod() {
//        OSSpinLockLock(&lock)
//        // some code
//        OSSpinLockUnlock(&lock)
//    }
//}

// from ios 10
final class UnfierLock {
    private var lock = os_unfair_lock_s()
    private var privateArray = [Int]()
    
    public var array: [Int] {
        get {
            os_unfair_lock_lock(&lock)
            let temp = privateArray
            os_unfair_lock_unlock(&lock)
            return temp
        }
        set {
            os_unfair_lock_lock(&lock)
            privateArray = newValue
            os_unfair_lock_unlock(&lock)
        }
    }
}

final class SynchronizedObjc {
    private let lock = NSObject()
    private var array = [Int]()
    func someMethod() {
        objc_sync_enter(lock)
        array.append(10)
        objc_sync_exit(lock)
    }
}
