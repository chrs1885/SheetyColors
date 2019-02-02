//
//  RGBAColors+NSItemProvider.swift
//  SheetyColors_Example
//
//  Created by Christoph Wendt on 23.03.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import MobileCoreServices
import SheetyColors

extension RGBAColor: NSItemProviderWriting {
    public static var writableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeData as String]
    }

    public func loadData(withTypeIdentifier _: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Swift.Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }

        return progress
    }
}

extension RGBAColor: NSItemProviderReading {
    public static var readableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeData as String]
    }

    public static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        do {
            return try object(withItemProviderData: data, typeIdentifier: typeIdentifier)
        } catch {
            fatalError()
        }
    }

    private static func object<T>(withItemProviderData data: Data, typeIdentifier _: String) throws -> T {
        let decoder = JSONDecoder()
        let json = try decoder.decode(RGBAColor.self, from: data) as! T

        return json
    }
}
