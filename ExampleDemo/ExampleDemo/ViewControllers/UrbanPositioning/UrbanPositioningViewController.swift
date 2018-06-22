//
//  UrbanPositioningViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/4/13.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class UrbanPositioningViewController: BaseViewController,CLLocationManagerDelegate {

    var lacationManager = CLLocationManager()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "UrbanPositioningViewController", bundle: nil)
        let vc:UrbanPositioningViewController=storyboard.instantiateViewController(withIdentifier: "UrbanPositioningViewController") as! UrbanPositioningViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "获取城市"
          dingwei()
    }

    func dingwei(){
        if CLLocationManager.locationServicesEnabled() {
            
        }else{
            
        }
        self.lacationManager = CLLocationManager()
        self.lacationManager.distanceFilter = kCLDistanceFilterNone
        //self.lacationManager.desiredAccuracy = 1
        self.lacationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.lacationManager.requestAlwaysAuthorization()
        self.lacationManager.delegate = self
        self.lacationManager.startUpdatingLocation()
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.lacationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let curLoc:CLLocation = locations.first!
        print("经度："+String(curLoc.coordinate.longitude)+" 纬度："+String(curLoc.coordinate.latitude))
        //print("高度："+String(curLoc.altitude)+"    垂直精确度："+String(curLoc.verticalAccuracy))
        //print("垂直精确度："+String(curLoc.verticalAccuracy))
        //print("楼层高度："+String(describing: curLoc.floor?.level))
        let geoCoder = CLGeocoder.init()
        geoCoder.reverseGeocodeLocation(curLoc) {[weak self] (placemarks, error) in
            for placemark in placemarks! {
                let address:NSDictionary = placemark.addressDictionary! as NSDictionary
                print(address.object(forKey: "Country") ?? String())
                print(address.object(forKey: "State") ?? String())
                print(address.object(forKey: "City") ?? String())
                self?.lacationManager.stopUpdatingLocation()
            }
        }
 
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    
    

  

}
