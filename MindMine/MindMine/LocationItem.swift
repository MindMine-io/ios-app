//
//  LocationItem.swift
//  MindMine
//
//  Created by SimonDahan on 05/03/2021.
//

import Foundation

// Allows to pass a 'patientInfo' context to encoders
// Used in structs to get different behaviors depending on the decoder
extension CodingUserInfoKey {
  static let patientInfo = CodingUserInfoKey(rawValue: "patientInfo")!
}

struct LocationItem: Codable {
    var date: Date
    var longitude: String
    var latitude: String
    var patient: UUID?
    
    // Keys at coding time needed for custom
    // encoding fucntion below
    enum CodingKeys: CodingKey {
        case date
        case longitude
        case latitude
        case patient
    }
    
    // Custom encoding function, from struct object to JSon, plist...
    func encode(to encoder: Encoder) throws {
        // Get encoder object
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encode standard fields
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(date, forKey: .date)
        
        // Get 'patientInfo' context to encode patient. If not provided, skip the step
        // Allows to set patient for sending data in json format while
        // keeping it undeclared to save data in plist
        guard let patientInfo = encoder.userInfo[CodingUserInfoKey.patientInfo] as? PatientInfo else {
            return
        }
        try container.encode(patientInfo.id!, forKey: .patient)
    }
    
    
// To customize the structure contructor,
// uncomment the example below
    
//    init(date: Date, longitude: String, latitude: String) {
//        self.date = date
//        self.longitude = longitude
//        self.latitude = latitude
//    }
        
// To pass context at decoding time, for example if patient field should be set
// when reading from saved plist data, uncomment the example below
    
//    enum DecodingError: Error {
//        case missingPatientInfo
//    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        date = try container.decode(Date.self, forKey: .date)
//        latitude = try container.decode(String.self, forKey: .latitude)
//        longitude = try container.decode(String.self, forKey: .longitude)
//
//        guard let patientInfo = decoder.userInfo[CodingUserInfoKey.patientInfo] as? PatientInfo else {
//            throw DecodingError.missingPatientInfo
//        }
//
//        patient = patientInfo.id!
//    }
        
}

