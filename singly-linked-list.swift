import UIKit

class SNode<T> {
    var value: T
    
    var next: SNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

struct SLinkedList<T> {
    var head: SNode<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: SNode<T>? {
        return head
    }
    
    public mutating func prepend(value: T) {
        let newNode = SNode(value: value)
        
        if let h = head {
            head = newNode
            head?.next = h
        }
        else {
            head = newNode
        }
    }
    
    public mutating func append(value: T) {
        let newNode = SNode(value: value)
        
        if head != nil {
            var currentNode = head
            while currentNode?.next != nil {
                currentNode = currentNode?.next
            }
            currentNode?.next = newNode
        }
        else {
            head = newNode
        }
    }
    
    public mutating func insert(value: T, at index: Int) {
        let newNode = SNode(value: value)
        
        if index == 0 {
            newNode.next = head
            head = newNode
        }
        else {
            var previous = head
            var current = head
            for _ in 0..<index {
                previous = current
                current = current?.next
            }
            if previous == nil {
                print("Could not insert -- Index out of bounds")
                return
            }
            newNode.next = previous?.next
            previous?.next = newNode
        }
    }
    
    public mutating func remove(at index: Int) {
        if index == 0 {
            head = head?.next
        }
        else {
            var previous = head
            var current = head
            for _ in 0..<index {
                previous = current
                current = current?.next
            }
            if previous?.next == nil {
                print("Nothing not remove -- Index out of bounds")
                return
            }
            previous?.next = current?.next
            print("Deleted node at \(index)")
            print("")
        }
    }
    
    public mutating func removeAll() {
        head = nil
    }
    
    // ZTM Exercise: reverse() -- Create a function to reverse the order of the linked list
    
    public mutating func reverse() {
        if isEmpty {
            print("No items in this list")
            print("")
            return
        }
        var nodeArray = [SNode<T>]()
        var current = head
        
        while current != nil {
            nodeArray.append(current!)
            current = current?.next
        }
        
        head = nodeArray.popLast()
        current = head
        
        for _ in 0...nodeArray.count {
            current?.next = nodeArray.popLast()
            current = current?.next
        }
        
        print("List was reversed")
        print("")
    }

    
    public func printList() {
        if isEmpty {
            print("No items in this list")
            print("")
            return
        }
        else {
            var count = 1
            var currentNode = head
            
            print("Items in this list:")
            
            while currentNode != nil {
                print("Item \(count): \((currentNode?.value)!)")
                count += 1
                currentNode = currentNode?.next
            }
            print("")
        }
    }
}

var list = SLinkedList<Int>()

list.prepend(value: 3)
list.prepend(value: 4)
list.append(value: 19)
list.append(value: 32)
list.insert(value: 2, at: 0)

//list.removeAll()

list.printList()

list.reverse()

list.printList()


