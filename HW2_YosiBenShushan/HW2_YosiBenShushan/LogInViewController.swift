//
//  logInViewController.swift
//  HW2_YosiBenShushan
//
//

import UIKit
import CoreLocation

class LogInViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var login_LBL_title: UILabel!
    @IBOutlet weak var login_IMG_leftSide: UIImageView!
    @IBOutlet weak var login_IMG_rightSide: UIImageView!
    @IBOutlet weak var login_BTN_insertName: UIButton!
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var nameTextField: UITextField!

    var locationManager: CLLocationManager!

    let preferences = UserDefaults.standard
    let nameKey = "userName"

    var playerName: String = ""
    var isNameEntered: Bool = false
    var side: Bool = true // False = Left; True = Right

    var isEnabledLocation: Bool = false
    let afekaLon: Double = 34.817549168324334
    var lon: Double?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
       // login_IMG_leftSide.isHidden = true
        //login_IMG_rightSide.isHidden = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        login_BTN_insertName.isHidden = false;
        // Request location permissions
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        
        if let savedName = preferences.string(forKey: nameKey) {
            playerName = savedName
            nameTextField.text = "ChangeName"
            login_LBL_title.text = "Hello \(playerName)!"
            isNameEntered = true
            startGame.isHidden = false
           // showImagesBasedOnLocation();
          
        } else {
            login_LBL_title.text = "Please enter your name"
            startGame.isHidden = true
            //showImagesBasedOnLocation();
        }
        nameTextField.isHidden = false;
        login_BTN_insertName.isHidden = false;
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let name = textField.text, !name.isEmpty {
            playerName = name
            preferences.set(playerName, forKey: nameKey)
            login_LBL_title.text = "Welcome \(name)!"
            textField.isHidden = true
            login_BTN_insertName.isHidden = true
            isNameEntered = true
            startGame.isHidden = false
            //showImagesBasedOnLocation()
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a valid name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func showImagesBasedOnLocation() {
        if let lon = lon {
            if lon < afekaLon {
                side = false
                login_IMG_rightSide.isHidden = true
                login_IMG_leftSide.isHidden = false
            } else {
                side = true
                login_IMG_leftSide.isHidden = true
                login_IMG_rightSide.isHidden = false
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lon = location.coordinate.longitude
            locationManager.stopUpdatingLocation()
            isEnabledLocation = true
            showImagesBasedOnLocation();
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user's location: \(error.localizedDescription)")
        isEnabledLocation = false
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            isEnabledLocation = true
        default:
            isEnabledLocation = false
        }
    }

    @IBAction func login_BTN_insertNameClicked(_ sender: UIButton) {
        if let name = nameTextField.text, !name.isEmpty {
            playerName = name
            preferences.set(playerName, forKey: nameKey)
            login_LBL_title.text = "Welcome, \(name)!"
            nameTextField.isHidden = true
            login_BTN_insertName.isHidden = true
            isNameEntered = true
            startGame.isHidden = false
            showImagesBasedOnLocation()
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a valid name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func startGameClicked(_ sender: UIButton) {
        if isNameEntered && isEnabledLocation {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                viewController.playerName = self.playerName
                viewController.side = self.side
                self.navigationController?.pushViewController(viewController, animated: true)
            } else {
                print("ViewController with identifier 'ViewController' could not be instantiated")
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter your name and enable location services", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

