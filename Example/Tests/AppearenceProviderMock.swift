//
//  AppearenceProviderMock.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 05.08.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
@testable import SheetyColors

struct AppearenceProviderMock: AppearenceProviderProtocol {
    var expectedAppearence: Appearence = .unknown

    var current: Appearence {
        return expectedAppearence
    }
}
