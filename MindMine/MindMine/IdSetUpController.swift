//
//  IdSetUpController.swift
//  MindMine
//
//  Created by Hugo on 12/04/2021.
//

import UIKit
import Foundation

class IdSetUpController: UIViewController {
    
    @IBOutlet weak var inputId: UILabel!
    
    @IBOutlet weak var validateButton: UIButton!
    
    @IBAction func didPressValidate(_ sender: UIButton) {
        
        guard let patientId = UUID(uuidString: inputId.text!) else {
            self.view.makeToast("Please enter a valid UID.")
            return
        }
        let patientInfo = PatientInfo(id:patientId)
        verifyPatientId(patientInfo: patientInfo) { result in
            do {
                let _ = try result.get()
                self.savePatientInfo(patientInfo: patientInfo)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "idInputToHome", sender: self)
                }
            } catch IdValidationError.EncodingError {
                self.displayErrorAlert(message: "The ID you entered cannot be sent to the server. Please check that you entered a valid UID.")
            } catch IdValidationError.AlreadyVerified {
                self.displayErrorAlert(message: "This ID is already being used. Please verify the value you entered and check with your clinician if necessary.")
            } catch IdValidationError.ServerError {
                self.displayErrorAlert(message: "Server unreachable, please try again in a few minutes. If the error persists, you can contact the support.")
            } catch IdValidationError.NotFound {
                self.displayErrorAlert(message: "ID not found. Please check the value you entered. If the error persists, you can contact the support or your clinician to verify the validity of the ID you received.")
            } catch {
                print(error)
            }
        }
    }
    
    func displayErrorAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    enum IdValidationError: Error {
        case EncodingError
        case AlreadyVerified
        case ServerError
        case NotFound
    }
    
    func verifyPatientId(patientInfo: PatientInfo, completion: @escaping (Result<Int, IdValidationError>) -> Void) {
        let encoder = JSONEncoder()
        
        guard let jsondata = try? encoder.encode(patientInfo) else {
            completion(.failure(IdValidationError.EncodingError))
            return
        }
            
        // Uncomment below to print JSon data as string
        // if let JSONString = String(data: jsondata, encoding: String.Encoding.utf8) {
        //     print(JSONString)
        // }
        
        // Main network handler
        let session = URLSession.shared

        // Creating request and updating header
        // CHANGE URL TO LOCAL IF NEEDED (get your local IP)
        let url = URL(string: "http://192.168.0.13:8000/api/patient-verif/")!
        // let url = URL(string: "https://dashboard.mindmine.io/api/patient-verif/")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")

        // Define upload task and manage returned data
        let task = session.uploadTask(with: request, from: jsondata) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(httpResponse.statusCode))
                case 403:
                    completion(.failure(IdValidationError.AlreadyVerified))
                case 404:
                    completion(.failure(IdValidationError.NotFound))
                default:
                    completion(.failure(IdValidationError.ServerError))
                }
            } else {
                completion(.failure(IdValidationError.ServerError))
            }
        }
        // Execute request
        task.resume()
    }
    
    
    func savePatientInfo(patientInfo: PatientInfo) {
        let encoder = PropertyListEncoder()
        do{
            
            let data = try encoder.encode(patientInfo)
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("PatientInfo.plist")
            try data.write(to: path,
                           options:  Data.WritingOptions.atomic)
        }
        catch{
            print("Error encoding item array \(error.localizedDescription)")
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
    
}
