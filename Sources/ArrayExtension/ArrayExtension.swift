//
//  ArrayExtension.swift
//
//
//  Created by Yiming Liu on 12/17/22.
//

import Foundation

@available(macOS 13.0, *)
public extension Array where Element: Identifiable {
    func find(id: Element.ID) -> [Element] {
        var foundElements: [Element] = []
        for element in self {
            if element.id == id {
                foundElements.append(element)
            }
        }
        return foundElements
    }
    
    func findFirst(id: Element.ID) -> Element? {
        if let element = self.first(where: {$0.id == id}) {
            return element
        } else {
            return nil
        }
    }
    
    func find(where condition: (_ element: Element) -> Bool) -> [Element] {
        var foundElements: [Element] = []
        for element in self {
            if condition(element) {
                foundElements.append(element)
            }
        }
        return foundElements
    }
    
    func findFirst(where condition: (_ element: Element) -> Bool) -> Element? {
        if let element = self.first(where: {condition($0)}) {
            return element
        } else {
            return nil
        }
    }
    
    mutating func remove(id: Element.ID) {
        for (index, element) in self.enumerated() {
            if element.id == id {
                self.remove(at: index)
            }
        }
    }
    
    mutating func remove(where condition: (_ element: Element) -> Bool) {
        for element in self {
            if condition(element) {
                self.remove(id: element.id)
            }
        }
    }
    
    mutating func removeFirst(where condition: (_ element: Element) -> Bool) {
        if let element = self.first(where: {condition($0)}) {
            self.remove(id: element.id)
        }
    }
}

public extension Array where Element: Comparable {
    mutating func addInOrder(_ element: Element) {
        if self.isEmpty {
            self.append(element)
        } else {
            for (index, nthElement) in self.enumerated() {
                if element < nthElement {
                    self.insert(element, at: index)
                    return
                }
            }
            self.append(element)
        }
    }
}
