//
//  PersonObject.swift
//  GDTest
//
//  Created by Сергей Шестаков on 15.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class PersonObject {
    var pictureURL: String!
    var pictureURLFull: String!
    var title: String!
    var first: String!
    var last: String!
    lazy var fullName = title + " " + first + " " + last
    
    var email: String!
    var dataBorn: String!
    var age: String!
    var gmt: String!
    var gender: String!

    // MARK: Получаем данные из json файла
    required init(json: JSON) {
        pictureURL = json["picture"]["medium"].stringValue
        pictureURLFull = json["picture"]["large"].stringValue
        title = json["name"]["title"].stringValue
        first = json["name"]["first"].stringValue
        last = json["name"]["last"].stringValue
        email = json["email"].stringValue
        dataBorn = json["dob"]["date"].stringValue
        age = json["dob"]["age"].stringValue
        gmt = json["location"]["timezone"]["offset"].stringValue
        gender = json["gender"].stringValue
    }
}

