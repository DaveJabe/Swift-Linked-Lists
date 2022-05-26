import UIKit

class DNode<T> {
    var value: T
    
    var next: DNode<T>?
    
    var previous: DNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

struct DLinkedList<T> {
    var head: DNode<T>?
    
    var tail: DNode<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: DNode<T>? {
        print(head?.value ?? "List is empty")
        return head
    }
    
    var last: DNode<T>? {
        print(tail?.value ?? "List is empty")
        return tail
    }
    
    public mutating func prepend(value: T) {
        let newNode = DNode(value: value)
        
        if let headNode = head {
            newNode.next = headNode
            headNode.previous = newNode
            head = newNode
            
            var current = head
            while current != nil {
                if current?.next == nil {
                    tail = current
                    return
                }
                else {
                    current = current?.next
                }
            }
        }
        else {
            head = newNode
            tail = newNode
        }
    }
    
    public mutating func append(value: T) {
        let newNode = DNode(value: value)
        
        if let tailNode = tail {
            tailNode.next = newNode
            newNode.previous = tailNode
        }
        else {
            head = newNode
        }
        tail = newNode
    }
    
    public func nodeAt(index: Int) -> DNode<T>? {
        var node: DNode<T>?
        var current = head
        
        for _ in 0..<index {
            current = current?.next
        }
        
        node = current
        
        if node == nil {
            print("Index out of bounds")
        }
        
        return node
    }
    
    public mutating func insert(value: T, at index: Int) {
        let newNode = DNode(value: value)
        
        if index == 0, tail == nil {
            head = newNode
            tail = newNode
            return
        }
        
        guard let nodeAtIndex = nodeAt(index: index) else {
            print("Index out of bounds")
            return
        }
        
        let previousNode = nodeAtIndex.previous
        
        if previousNode == nil {
            head = newNode
        }
        
        previousNode?.next = newNode
        newNode.previous = previousNode
        
        newNode.next = nodeAtIndex
        nodeAtIndex.previous = newNode
    }
    
    public mutating func insert(node: DNode<T>, at index: Int) {
        if index == 0, tail == nil {
            head = node
            tail = node
            return
        }
        guard let nodeAtIndex = nodeAt(index: index) else {
            print("Index out of bounds")
            return
        }
        
        let previousNode = nodeAtIndex.previous
        
        if previousNode == nil {
            head = node
        }
        previousNode?.next = node
        nodeAtIndex.previous = node
        
        node.previous = previousNode
        node.next = nodeAtIndex
    }
    
    public mutating func remove(at index: Int) {
        var nodeAtIndex = nodeAt(index: index)
        guard nodeAtIndex != nil else {
            print("Index out of bounds")
            return
        }
        
        let previousNode = nodeAtIndex?.previous
        let nextNode = nodeAtIndex?.next
        
        if previousNode == nil {
            head = nextNode
        }
        if nextNode == nil {
            tail = previousNode
        }
        
        previousNode?.next = nextNode
        nextNode?.previous = previousNode
        
        nodeAtIndex = nil
    }
    
    public mutating func remove(node: DNode<T>) -> T {
        let nextNode = node.next
        let previousNode = node.previous
        
        if previousNode == nil {
            head = nextNode
        }
        if nextNode == nil {
            tail = previousNode
        }
        
        nextNode?.previous = previousNode
        previousNode?.next = nextNode
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
    
    public mutating func removeAll() {
        head = nil
        tail = nil
    }
    
    public func printList() {
        if head == nil {
            print("No items in this list")
            print("")
            return
        }
        else {
            print("Items in this list:")
            var current = head
            var count = 1
            while current != nil {
                print("Item \(count): \((current?.value)!)")
                current = current?.next
                count += 1
            }
            print("")
        }
    }
}

var list = DLinkedList<String>()

let coolNode = DNode(value: "blueberries")

list.prepend(value: "strawberries")
list.prepend(value: "watermelon")
list.prepend(value: "oranges")
list.append(value: "lemons")
list.insert(value: "apples", at: 2)
list.insert(node: coolNode, at: 3)

list.printList()

list.removeAll()

list.printList()

//list.removeAll()
//
//list.first
//
//list.last

