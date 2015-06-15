//
//  DiaryLocationHelper.swift
//  Diary
//
//  Created by wyatt on 15/6/14.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import CoreLocation

class DiaryLocationHelper: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var address: String?
    var geocoder = CLGeocoder()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        // 位置更新的位移触发条件
        locationManager.distanceFilter = kCLDistanceFilterNone
        // 精度
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // 如果用户停止移动则停止更新位置
        locationManager.pausesLocationUpdatesAutomatically = true
        // 指南针触发条件
        locationManager.headingFilter = kCLHeadingFilterNone
        // 请求位置权限
        locationManager.requestWhenInUseAuthorization()
        println("Location Right")
        // 判断是否有位置权限
        if (CLLocationManager.locationServicesEnabled()) {
            // 开始更新位置
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

        var locationInfo = locations.last as! CLLocation
        
//        println(locationInfo)
        
        geocoder.reverseGeocodeLocation(locationInfo, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("reverse geodcode fail: \(error.localizedDescription)")
            }
            if let pm = placemarks.first as? CLPlacemark {
                self.address = pm.name
                NSNotificationCenter.defaultCenter().postNotificationName("DiaryLocationUpdated", object: self.address)
            }
        })
    }
    
    // 失败则停止定位
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
        locationManager.stopUpdatingLocation()
    }
    
//    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
//        // 位置更新后通过CLGeocoder获取位置描述， 例如广州市
//        geocoder.reverseGeocodeLocation(newLocation, completionHandler: { (placemarks, error) -> Void in
//            if (error != nil) {
//                println("reverse geodcode fail: \(error.localizedDescription)")
//            }
//            if let pm = placemarks as? [CLPlacemark] {
//                if pm.count > 0 {
//                    var placemark = pm.first
//                    self.address = placemark?.locality
//                    NSNotificationCenter.defaultCenter().postNotificationName("DiaryLocationUpdated", object: self.address)
//                }
//            }
//        })
//    }
}