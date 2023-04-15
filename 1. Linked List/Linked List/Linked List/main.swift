//
//  main.swift
//  blatosek_APIOS_lab_1
//
//  Created by apios on 15/03/2023.
//

import Foundation

class Node {
    let value: Any
    weak var next: Node?
    var prev: Node?
    
    init(_ newValue: Any) {
        print("Node with val: |\(newValue)| init.")
        self.value = newValue
        self.next = nil
        self.prev = nil
    }
    
    deinit {
        print("Node with val: |\(value)| deinit.")
    }
    
    func display() {
        print(value)
    }
}

class Container {
    var first: Node?
    var tail: Node?
    
    init() {
        print("Container init")
        self.first = nil
        self.tail = nil
    }
    
    deinit {
        print("Container deinit")
    }
    
    func add(val newVal: Any) {
        let newNode = Node(newVal)
        if (first == nil) {
            first = newNode
            tail = newNode
        }
        else {
            tail?.next = newNode
            newNode.prev = tail
            tail = newNode
        }
    }
    
    func display() {
        var curNode = self.first
        while (curNode != nil) {
            curNode?.display()
            curNode = curNode?.next
        }
    }
    
    func displayBack() {
        var curNode = self.tail
        while (curNode != nil) {
            curNode?.display()
            curNode = curNode?.prev
        }
    }
}

func main() {
    let container = Container();
    container.add(val: 1);
    container.add(val: "Dzien dobry");
    container.add(val: 3.02);
    container.add(val: 2);
    container.add(val: "Do widzenia");
    container.add(val: 4.03);
    container.display();
    print("============")
    container.displayBack();
}

main();
