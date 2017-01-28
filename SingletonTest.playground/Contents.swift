//: Playground - noun: a place where people can play

import UIKit

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    private init() {
        print("The Singleton is Bornnn")
    }
    
    func printWords() {
        print("HELLO from inside CoreDataManager!")
    }
}

let x = CoreDataManager.sharedInstance
x.printWords()

// And to prove to you it's all the 'same' singleton behind the scenes!
let y = CoreDataManager.sharedInstance

// What I'm doing above is essentially the same as doing below with standard Apple singletons
let z = NotificationCenter.default


// Credits to Hector Matos @ https://krakendev.io/blog/the-right-way-to-write-a-singleton
// @allonsykraken on Twitter