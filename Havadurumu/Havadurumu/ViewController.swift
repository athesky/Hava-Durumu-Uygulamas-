//
//  ViewController.swift
//  Havadurumu
//
//  Created by Yakup Solmaz on 19.09.2020.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var weathericon: UIImageView!
    
    @IBOutlet weak var lbltemperature: UILabel!
    
    @IBOutlet weak var lblhumidity: UILabel!
    
    @IBOutlet weak var lblprecipitation: UILabel!
    
    @IBOutlet weak var btnrefresh: UIButton!
    
    @IBOutlet weak var lblsummary: UILabel!
    
    @IBOutlet weak var lbllongtitudetext: UITextField!
    @IBOutlet weak var lbllatitudetext: UITextField!
    @IBOutlet weak var lbllongtitude: UILabel!
    @IBOutlet weak var lbllangtitude: UILabel!
    let clients = DarkSkyApiClient()
    
    var location_manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        lbllongtitudetext.text = "loading..."
        lbllatitudetext.text = "loading..."
        lbltemperature.text = "loading..."
        lblsummary.text = "loading..."
        lblhumidity.text = "loading..."
        lblsummary.text = "loading..."
        lblprecipitation.text = "loading..."
        
        self.location_manager.delegate = self
//        uygulama acildiginda bizden konum bilgimizi kullanmamizi isteyecek
        self.location_manager.requestAlwaysAuthorization()
        location_manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        location_manager.startUpdatingLocation()
       
        
    }
//    konum bilgimiz degisirse eger burdaki fonksiypn calisacak
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationvalue: CLLocationCoordinate2D = manager.location!.coordinate
        let clientcoordinates = Coordinate(latitude: locationvalue.latitude, longitude: locationvalue.longitude)
        updateweather(coordinate: clientcoordinates)
        
    }
    
    func updateweather(coordinate : Coordinate){
        clients.getCurrentWeather(at: coordinate){veri , error in
            if let veri = veri {
            let vieving = CurrentWeatherModel(data: veri)
                DispatchQueue.main.sync {
                    self.showweather(model: vieving)
                    self.lbllongtitude.text = String(coordinate.latitude)
                    self.lbllangtitude.text = String(coordinate.longitude)
                    self.lbllatitudetext.text = "Enlem "
                    self.lbllongtitudetext.text = "Boylam"
                    print (veri)
                    
                }}}}
    
    func showweather(model : CurrentWeatherModel){
        lbltemperature.text = model.temperature
        lblsummary.text = model.summary
        lblhumidity.text =  model.humidity
        lblprecipitation.text = model.precipitationProbability
        weathericon.image = model.icon}
        @IBAction func refreshbtnclicked(_ sender: UIButton){
            locationManager(location_manager, didUpdateLocations: [])
        }
        }
    

   
   
    




