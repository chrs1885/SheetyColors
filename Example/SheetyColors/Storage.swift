//
//  Storage.swift
//  SheetyColors_Example
//
//  Created by Christoph Wendt on 07.03.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class Storage {
    func save<T: Encodable>(_ object: T, to filename: String) {
        let url = getDocumentsDirectory().appendingPathComponent(filename, isDirectory: false)

        do {
            let encoder = JSONEncoder()
            let encodedObject = try? encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: encodedObject, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func load<T: Decodable>(from filename: String, as type: T.Type) -> T? {
        let url = getDocumentsDirectory().appendingPathComponent(filename, isDirectory: false)

        if !FileManager.default.fileExists(atPath: url.path) {
            return nil
        }

        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            let decodedObject = try! decoder.decode(type, from: data)
            return decodedObject
        } else {
            fatalError("No data found  at\(url.path)!")
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
