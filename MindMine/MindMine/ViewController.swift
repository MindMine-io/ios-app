//
//  ViewController.swift
//  MindMine
//
//  Created by SimonDahan on 02/03/2021.
//

import UIKit
import CoreLocation //SDK to access user's location

class ViewController: UIViewController,
                      CLLocationManagerDelegate {       // a lot of iOS SDKs works via a delegate
    
    let manager: CLLocationManager = CLLocationManager() //this is the object that will provid GPS coordinates
    private var savedLocation = [LocationItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath())
        loadLocationList()
        print("current saved location in the app")
        print(savedLocation)
            }
    
    // define a outlet for the switch button
    @IBOutlet weak var stateSwitch: UISwitch!
    
    // define an action for the switch button
    // on On: ask for permissions and start displaying coordinates
    @IBAction func switchButton(_ sender: UISwitch) {
                
        if  stateSwitch.isOn {
                
            // request permission from the user
            let authStatus = CLLocationManager.authorizationStatus() // deprecated from iOS14 but still working and better to support previous iOS versions.
            if authStatus == .notDetermined {
                // need to add info.plist to actually ask the system
                manager.requestWhenInUseAuthorization() // might change to Always
                stateSwitch.isOn = false
                return
            }
            
            // check whether location service is enabled if not then display alert
            if authStatus == .denied || authStatus == .restricted{
                showLocationServicesDeniedAlert()
                stateSwitch.isOn = false
            }

            
            manager.delegate = self // set the view controler as delegate of the location manager
            // the accuracy of the location data that your app wants to receive
            // can choose between: best; reduced; kilometer; 3km; nearest ten meters, 100 meters; best for navigation
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation() // the location manager send location updates to its delegate ie view controler
            print("start recording data")
            
        }
        
        else {print("stop recording data")
              manager.stopUpdatingLocation()
            print("saved location after recording")
            print(savedLocation)
        }
        
    }

    // this function will collect the successive locations
    // this is a locsation manager delegate function
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // to be sure there is at least one location
        guard let newLocation = locations.first else {  // guard is used to exit the function is case it fails
            return
        }
        
        print(newLocation.timestamp,newLocation.coordinate.longitude, newLocation.coordinate.latitude)
        print("didUpdateLocation \(newLocation)")
        
        let item = LocationItem()
        item.date = newLocation.timestamp
        item.longitude = String(newLocation.coordinate.longitude)
        item.latitude = String(newLocation.coordinate.latitude)
        savedLocation.append(item)
        saveLocationList()
        }
    
    // this function will be called when data collection fails or when user doesn't allow
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("didFailWithError \(error.localizedDescription)")
    }
    
    
    // MARK: - Helper Methods
    func showLocationServicesDeniedAlert(){
        
        let alert = UIAlertController(
            title: "Location Services Disabled",
            message: "Please enable location services for MindMineApp in Settings",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL{
        return documentsDirectory().appendingPathComponent("LocationList.plist")
        
    }
    
    func saveLocationList(){
        
        let encoder = PropertyListEncoder()
        
        do{
            
            let data = try encoder.encode(savedLocation)
            
            try data.write(to: dataFilePath(),
                           options:  Data.WritingOptions.atomic)
        }
        catch{
            print("Error encoding item array \(error.localizedDescription)")
        }
    }
    
    func loadLocationList() {
        
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            
            let decoder = PropertyListDecoder()
            do {
                
                savedLocation = try decoder.decode([LocationItem].self,
                                          from:data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    
    /**
    NOTES:
     -let are constants whiile var are variables
    -CoreLocation deals with the choice between Wifi; CellularData or GPS. Need to look how to set this choice.
    -CoreLocation sends location data to the app as soon as it gets it; and then follows up with more and more accurate readings.
    -Instead of collecting data all the time maybe use function that detects when there is a movement and start recording at that moment?
    -Look at significantLocationChangeMonitoringAvailable
    -Location is an asynchronous operation (done in the background )
     -very important concept for data management: persistence=saving and loading items.
     -There is a memory space while the app is still running. But when the app is closed it disappear. There is also a device's long-term flash storage: document.
     -each app as it's own Document folder in its sandbox. The content of the document folder is backed up to icloud when syncs. Document folder remains the same after updating the app. Document folder are private by apps.
     - Question: do we want to send dqtq on icloud? maybe a solution is CoreData
     -Process of converting objects to file qnd bqck again is known as serialisation.
     - Option1: Document folder with .plist files = xml files. Codable is a protocol to save object
     -create a file object per day/ per hour etc...?
    
     */
    
}

