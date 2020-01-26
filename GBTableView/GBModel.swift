//
//  GBModel.swift
//  GBTableView
//
//  Created by IOS on 26/01/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

struct GBModel: Codable {
    var name: String!
    var details: [GBModelInnder]!
}

struct GBModelInnder: Codable {
    var name: String!
}
