//
//  HealthDataStore.swift
//  MindMine
//
//  Created by SimonDahan on 12/10/2021.
//

import Foundation
import HealthKit


class HealthDataStore{
    
    // HKHealthStore enable access to all features in HK for reading and writting
    var healthStore: HKHealthStore?
    
    init() {
        // for initialising the healthStore
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    //authorisation function for accessing the data
    func requestAuthorisation(completion: @escaping (Bool) -> Void){
        
        //list all data type intersted in HK
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        //access to HealtStore
        guard let healthStore = self.healthStore else {return completion(false)}
        
        //request authorisation over healthstore
        //toShare: in case of writting data, [] otherwise
        //read: data to read, [] otherwise
        healthStore.requestAuthorization(toShare: [], read: [stepType]) { (success, error) in
            completion(success)
        }
    }
    
    

}
