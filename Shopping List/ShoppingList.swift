//
//  List.swift
//  Shopping List
//
//  Created by Cezary Róg on 22.08.2018.
//  Copyright © 2018 Cezary Róg. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    @objc dynamic var title = ""
    let elements = List<ShoppingListElement>()
}
