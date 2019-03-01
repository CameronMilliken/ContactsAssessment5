//
//  Contact.swift
//  ContactsAssessment5
//
//  Created by Cameron Milliken on 3/1/19.
//  Copyright © 2019 Cameron Milliken. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    // Properties
    var name: String
    var phoneNumber: Int?
    var email: String?
    
    // CouldKit Access
    let ckRecordId: CKRecord.ID
    
    // Contact Keys
    struct ContactKeys {
        static let recordKey = "Contact"
        static let nameKey = "name"
        static let phoneNumberKey = "phoneNumber"
        static let emailKey = "email"
    }
    
    // Initialize
    init(name: String, phoneNumber: Int, email: String, ckRecordId: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.ckRecordId = ckRecordId
    }
    
    // Falible Initializer
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[ContactKeys.nameKey] as? String,
            let phoneNumber = ckRecord[ContactKeys.phoneNumberKey] as? Int,
            let email = ckRecord[ContactKeys.emailKey] as? String else { return nil }
            self.init(name: name, phoneNumber: phoneNumber, email: email, ckRecordId: ckRecord.recordID)
    }
} // End of Class

// Extension
extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: Contact.ContactKeys.recordKey, recordID: contact.ckRecordId)
        self.setValue(contact.name, forKey: Contact.ContactKeys.nameKey)
        self.setValue(contact.phoneNumber, forKey: Contact.ContactKeys.phoneNumberKey)
        self.setValue(contact.email, forKey: Contact.ContactKeys.emailKey)
    }
}

// Equatable
extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.email == rhs.email && lhs.phoneNumber == rhs.phoneNumber && lhs.name == rhs.name && lhs.ckRecordId == rhs.ckRecordId
    }
    
}
