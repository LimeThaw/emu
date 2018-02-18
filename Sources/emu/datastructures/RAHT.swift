//
//  RAHT.swift
//  ABM
//
//  Created by Tierry Hörmann on 19.05.17.
//
//

/**
 ## Overview
 
 RAHT stands for Random Access Hash Table, while random access is understood here, that this datastructure can output a random entry efficiently.

 Every entry is stored inside the `data` array. The entries of the `table` dictionary serve as pointers to locate a given entry in `data` through its `hashValue`.
 This configuration enables the relocation of elements in `data` and the arbitrary assignment of a location in `data` for elements.
 The density is defined by the number of elements in the collection (`count`) divided by the size (currently available slots) of `data`. An empty `data` has a density of 1.

 When inserting an element, a random (empty) slot in `data` is searched and the element is inserted there.
 If the density is above 0.7, the element is appended to the end of `data`.
 After insertion in `data` a entry is added to `table` which maps the elements `hashValue` to its location in `data`.

 When deleting an element, the according element is searched in `data` via its entry in `table`. Both entries, the one in `data` and the one in `table` are removed. Afterwards a shrink operation is executed that works as follows:
 When the density is below 0.3 and the uppermost entry of `data` is occupied, this entry is moved to a random other location in `data`. Afterwards the uppermost (empty) slots are removed, until one is occupied, or the density reaches 0.5.
 The shrink operation assures, that the density is never below 0.3 and therefore there is a low number of expected iterations until an element is found in `table` during random access.
 A random access selects a random index above or equal to 0 and below `data`'s size and checks whether the entry in `data` is occupied. If yes, the entry is returned, otherwise this procedure is repeated.
 
 ## Generic parameters
 - **Entry:** The type of an entry in this datastructure.
 */
public struct RAHT<Entry: Hashable> {
    /**
     The array that stores the main data.
     */
    var data: [Entry?] = []
    /**
     The dictionary responsible for the functionality of a hash table.
     An entry in this dictionary maps the `hashValue` of an element to its location in `data`.
     */
    var table: [Int:Int] = [:]
    /// Returns the number of elements
    public var count: Int { return table.count }
    /// The random number generator
    public private(set) var rand: Random
    
    /**
     Creates a new RAHT with a given random number generator.
     - parameter generator: The random number generator to be used for this structure.
     */
    public init(generator: Random? = nil) {
        if let g = generator {
            rand = g
        } else {
            rand = CRand()
        }
    }

    /// Indicates the density, which is 1, when `count` is 0 and the ratio of occupied slots and total slots otherwise.
    private var density: Float { return data.count > 0 ? Float(count)/Float(data.count) : 1}

    /**
     Returns the location of a random entry in `data` which satisfies the given condition.
     This function does not guarantee termination, since termination depends on the condition.
     If no entry can satisfy the condition, it won't terminate.
     - parameter condition: The condition a returned entry must fullfill.
     Per default this is a closure which returns `true` if the entry is not `nil`, i.e. `randomEntry` returns the location of an occupied slot in `data`.
     */
    private mutating func randomEntry(_ condition: (Entry?) -> Bool = {$0 != nil}) -> Int {
        var loc = 0
        repeat  {
            loc = rand.next(min: 0, max: data.count)
        } while !condition(data[loc])
        return loc
    }


    /**
     Inserts a new entry into this RAHT.
     If there is already an entry with the hash of the provided entry, it gets replaced with the new entry.
     - parameter val: The entry to be inserted.
     */
    public mutating func insert(_ val: Entry) {
        if let oldEntry = table[val.hashValue] {
            // If there is already an entry with this hash value, replace it with the provided one.
            data[oldEntry] = val
        } else {
            if density > 0.7 {
                table[val.hashValue] = data.count
                data.append(val)
            } else {
                let loc = randomEntry{$0 == nil}
                table[val.hashValue] = loc
                data[loc] = val
            }
        }
    }

    /**
     The shrink operation, which makes the datastrucutre more compact.
     If the density is below 0.3, the topmost entry of `data` is replaced to a random different location, if it is not nil.
     Afterwards `nil`-padding gets removed until the density reaches a maximal value of 0.5.
     This means, the topmost entry of `data` gets removed if it is nil and the density is below 0.5.
     */
    private mutating func shrink() {
        if density < 0.3 && data.last! != nil{
            let last = data.removeLast()!
            let loc = randomEntry{$0 == nil}
            table[last.hashValue] = loc
            data[loc] = last
        }
        while density < 0.5 && data.last! == nil {
            data.removeLast()
        }
    }

    /**
     Removes the element corresponding to a given hash.
     - parameter hash: The hash value of the element to be removed
     - returns: The entry that was removed, or `nil` if there is no entry with the provided hash value.
     */
    @discardableResult
    public mutating func remove(fromHash hash: Int) -> Entry? {
        if let loc = table.removeValue(forKey: hash) {
            let val = data[loc]
            data[loc] = nil
            shrink()
            return val
        }
        return nil
    }

    /**
     Removes a given element by its hash.
     - parameter val: The element to be removed.
     - returns: The removed element, or `nil` if there is no element with `val`'s hash.
     */
    @discardableResult
    public mutating func remove(_ val: Entry) -> Entry? {
        return remove(fromHash: val.hashValue)
    }

    /**
     Checks whether this RAHT contains a element with a provided hash.
     - parameter hash: The hash to be checked against
     - returns: `true` if this RAHT contains a element with `hash`, `false` otherwise
     */
    public func has(with hash: Int) -> Bool {
        return table[hash] != nil
    }

    /**
     Returns the element in this RAHT corresponding to the given hash.
     - parameter hash: The hash indicating the element that should be removed from this RAHT
     - returns: The removed element, or `nil` if there is no element with the provided hash
     */
    public func get(from hash: Int) -> Entry? {
        if let loc = table[hash] {
            return data[loc]
        }
        return nil
    }

    /**
     Returns a random element of this RAHT.
     - returns: A random element of this RAHT.
     */
    public mutating func getRandom() -> Entry? {
        if count == 0 {
            return nil
        }
        return data[randomEntry()]
    }
}

extension RAHT: Sequence {
    public func makeIterator() -> DictionaryIterator<Int, Entry> {
        return data.makeIterator()
    }
}
