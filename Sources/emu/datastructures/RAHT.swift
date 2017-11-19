//
//  RAHT.swift
//  ABM
//
//  Created by Tierry Hörmann on 19.05.17.
//
//

public protocol DynamicHashable: class, Hashable {
    var dynamicHashValue: Int { get set }
}

/**
 RAHT stands for Random Access Hash Table, while random access is understood here, that this datastructure can output a random entry efficiently.

 RAHT requires its entries to inherit from the protocol DynamicHashable. The dynamicHashValue should be reserved to operations of RAHT and should not be accessed anywhere else.
 Every entry is stored inside the data dictionary with its hashValue as key and the table array. The dynamicHashValue indicates the position inside the table and is therefore set, whenever the entry changes its place inside the table or gets added to the table.
 The density is defined as the number of elements in the collection (count) and the size of the table. An empty table has a density of 1.

 When inserting an element, a random (unoccupied) place in the table is searched and the element is inserted there. If the density is above 0.7, the element is appended to the end of the table. Obviously the element is also added to data.

 When deleting an element, the according element is searched in data and removed from there. The dynamic hash value of the element then indicates where to find it in table and is removed from there as well. Afterwards a shrink operation is executed that works as follows:
 When the density is below 0.3 and the uppermost entry of table is occupied, the entry is moved to a random other place in the table and the uppermost entry is removed. Afterwards the uppermost entry gets removed, until it is occupied, or the density reaches 0.5.
 The shrink operation assures, that the density is never below 0.3 and therefore random accesses are fast enough.
 A random access selects a random index above equal to 0 and below table's size and checks whether the entry in table is occupied. If yes, the entry is returned, otherwise it is tried again.
 
 ## Generic parameters
 - Entry: The type of an entry in this datastructure
 */
public struct RAHT<Entry: DynamicHashable> {
    var table: [Entry?] = []
    var data: [Int:Entry] = [:]
    public var count: Int { return data.count }
    public private(set) var rand: Random
    
    public init(generator: Random? = nil) {
        if let g = generator {
            rand = g
        } else {
            rand = CRand()
        }
    }

    private var density: Float { return table.count > 0 ? Float(count)/Float(table.count) : 1}

    private mutating func randomEntry(_ condition: (Entry?) -> Bool = {$0 != nil}) -> Int {
        var hash = 0
        repeat  {
            hash = rand.next(min: 0, max: table.count)
        } while hash != table.count && !condition(table[hash])
        return hash
    }


    public mutating func insert(_ val: Entry) {
        if data[val.hashValue] == nil {
            data[val.hashValue] = val
            if density > 0.7 {
                val.dynamicHashValue = table.count
                table.append(val)
            } else {
                let hash = randomEntry({$0 == nil})
                val.dynamicHashValue = hash
                table[hash] = val
            }
        }
    }

    private mutating func shrink() {
        if density < 0.3 && table.last! != nil{
            let last = table.removeLast()!
            let hash = randomEntry({$0 == nil})
            last.dynamicHashValue = hash
            table[hash] = last
        }
        while density < 0.5 && table.last! == nil {
            table.removeLast()
        }
    }

    @discardableResult
    public mutating func remove(staticHash: Int) -> Entry? {
        if let entry = data.removeValue(forKey: staticHash) {
            let dhash = entry.dynamicHashValue
            table[dhash] = nil
            shrink()
        }
        return nil
    }

    @discardableResult
    public mutating func remove(_ val: Entry) -> Entry? {
        return remove(staticHash: val.hashValue)
    }

    public func has(staticHash: Int) -> Bool {
        return data[staticHash] != nil
    }

    public func get(staticHash: Int) -> Entry? {
        return data[staticHash]
    }

    public mutating func getRandom() -> Entry? {
        if count == 0 {
            return nil
        }
        return table[randomEntry()]
    }
}

extension RAHT: Sequence {
    public func makeIterator() -> DictionaryIterator<Int, Entry> {
        return data.makeIterator()
    }
}
