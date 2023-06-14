//
//  User.swift
//  ESDiac_Auth
//
//  Created by Gbenga Abayomi on 14/06/2023.
//

import Foundation
import CoreData

class Users: NSManagedObject {
    @NSManaged var username: String?
    @NSManaged var password: String?
    @NSManaged var firstName: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var email: String?
}
