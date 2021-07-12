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
    private var patientInfo = PatientInfo()
    
    
    override func viewDidLoad() {
        
        patientInfo = loadPatientInfo()
        print(patientInfo)
        print(dataFilePath())
        loadLocationList()
        print("current saved location in the app")
        print(savedLocation)
        print("app folder path is \(NSHomeDirectory())")
        
    }
    
    // SEND button reference and action
    @IBOutlet weak var sendButton: UIButton!
    @IBAction func sendData(_ sender: UIButton) {
        
        // Prepare to encode in JSON. Specify date format and pass context to LocationItem,
        // so that it serializes patient id in addition to measurement data
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.userInfo[.patientInfo] = patientInfo
        
        do{
            // Serialize LocationItem list
            let jsondata = try encoder.encode(savedLocation)
            
            // Uncomment below to print JSon data as string
            // if let JSONString = String(data: jsondata, encoding: String.Encoding.utf8) {
            //    print(JSONString)
            // }
            
            // Main network handler
            let session = URLSession.shared
            
            // Creating request and updating header
            // CHANGE URL TO LOCAL IF NEEDED (get your local IP)
            // let url = URL(string: "http://192.168.0.13:8000/api/measurements/")!
            let url = URL(string: "https://dashboard.mindmine.io/api/measurements/")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
            
            // Define upload task and manage returned data
            let task = session.uploadTask(with: request, from: jsondata) { data, response, error in
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print(dataString)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                }
            }
            // Execute request
            task.resume()
            
        }
        catch {
            print("Error encoding item array or sending data to server: \(error.localizedDescription)")
        }
    
    }
    // GPS SWITCH button reference and action
    @IBOutlet weak var stateSwitch: UISwitch!
    @IBAction func switchButton(_ sender: UISwitch) {
              
        // on On: ask for permissions and start displaying coordinates
        if stateSwitch.isOn {
                
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
    // this is a location manager delegate function
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // to be sure there is at least one location
        guard let newLocation = locations.first else {  // guard is used to exit the function is case it fails
            return
        }
        
        print(newLocation.timestamp,newLocation.coordinate.longitude, newLocation.coordinate.latitude)
        print("didUpdateLocation \(newLocation)")
        
        let item = LocationItem(date: newLocation.timestamp,
                                longitude: String(newLocation.coordinate.longitude),
                                latitude: String(newLocation.coordinate.latitude))
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
    
    func patientFilePath() -> URL{
        return documentsDirectory().appendingPathComponent("PatientInfo.plist")
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
            decoder.userInfo[.patientInfo] = patientInfo
            do {
                
                savedLocation = try decoder.decode([LocationItem].self,
                                          from:data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    func loadPatientInfo() -> PatientInfo {
        var patientInfo = PatientInfo()
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("PatientInfo.plist")

        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            patientInfo = try! decoder.decode(PatientInfo.self, from:data)
        }
        return patientInfo
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

