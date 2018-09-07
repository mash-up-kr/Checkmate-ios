//
//  MapViewController.swift
//  NMapSampleSwift
//
//  Created by Junggyun Ahn on 2016. 11. 9..
//  Copyright © 2016년 Naver. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, NMapViewDelegate, NMapPOIdataOverlayDelegate {
    let CLIENT_ID = "AQNOaedkCYLCDt0HpEGR"
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapLayout: UIView!
    @IBOutlet weak var okBtn: UIButton!
    var mapView: NMapView?
    var addressCallback: ((String, Double, Double) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        mapView = NMapView(frame: self.mapLayout.bounds)
        
        if let mapView = mapView {
            
            // set the delegate for map view
            mapView.delegate = self
            
            // set the application api key for Open MapViewer Library
            mapView.setClientId(CLIENT_ID)
            
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            mapLayout.addSubview(mapView)
        }
    }
    
    private func refreshUI(address: String) {
        let noAddr = address == ""
        
        self.addressLabel.text = address
        self.okBtn.backgroundColor = noAddr ? UIColor.grey204 : UIColor.blue1
        self.okBtn.isEnabled = !noAddr
    }
    
    @IBAction func backBtnClicked() {
        self.dismiss(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        mapView?.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView?.viewDidAppear()
        
        addMarker()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView?.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mapView?.viewDidDisappear()
    }
    
    // MARK: - NMapViewDelegate Methods
    
    open func onMapView(_ mapView: NMapView!, initHandler error: NMapError!) {
        if (error == nil) { // success
            // set map center and level
            mapView.setMapCenter(NGeoPoint(longitude:126.978371, latitude:37.5666091), atLevel:11)
            // set for retina display
            mapView.setMapEnlarged(true, mapHD: true)
            // set map mode : vector/satelite/hybrid
            mapView.mapViewMode = .vector
        } else { // fail
            print("onMapView:initHandler: \(error.description)")
        }
    }
    
    // MARK: - NMapPOIdataOverlayDelegate Methods
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!,
                           imageForOverlayItem poiItem: NMapPOIitem!,
                           selected: Bool) -> UIImage! {
        return NMapViewResources.imageWithType(poiItem.poiFlagType, selected: selected);
    }
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!,
                           anchorPointWithType poiFlagType: NMapPOIflagType) -> CGPoint {
        return NMapViewResources.anchorPoint(withType: poiFlagType)
    }
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!,
                           calloutOffsetWithType poiFlagType: NMapPOIflagType) -> CGPoint {
        return CGPoint.zero
    }
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!,
                           imageForCalloutOverlayItem poiItem: NMapPOIitem!,
                           constraintSize: CGSize,
                           selected: Bool,
                           imageForCalloutRightAccessory: UIImage!,
                           calloutPosition: UnsafeMutablePointer<CGPoint>!,
                           calloutHit calloutHitRect: UnsafeMutablePointer<CGRect>!) -> UIImage! {
        return nil
    }
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!,
                           didChangePOIitemLocationTo location: NGeoPoint,
                           withType poiFlagType: NMapPOIflagType) {
        ServerClient.coordToAddress(latitude: location.latitude, longitude: location.longitude) { address in
            DispatchQueue.main.async {
                let addr = address ?? ""
                self.addressCallback?(addr, location.latitude, location.longitude)
                self.refreshUI(address: addr)
            }
        }
    }
    
    func addMarker() {
        
        if let mapOverlayManager = mapView?.mapOverlayManager {
            
            // create POI data overlay
            if let poiDataOverlay = mapOverlayManager.newPOIdataOverlay() {
                
                poiDataOverlay.initPOIdata(1)
                
                let poiItem = poiDataOverlay.addPOIitem(atLocation: NGeoPoint(longitude: 126.979, latitude: 37.567), title: "Touch & Drag to Move", type: UserPOIflagTypeDefault, iconIndex: 0, with: nil)
                
                // set floating mode
                poiItem?.setPOIflagMode(.touch)
                
                // hide right button on callout
                poiItem?.hasRightCalloutAccessory = false
                
                poiDataOverlay.endPOIdata()
                
                // select item
                poiDataOverlay.selectPOIitem(at: 0, moveToCenter: true)
                
                // show all POI data
                poiDataOverlay.showAllPOIdata()
            }
        }
    }
    
    func clearOverlays() {
        if let mapOverlayManager = mapView?.mapOverlayManager {
            mapOverlayManager.clearOverlays()
        }
    }
}
