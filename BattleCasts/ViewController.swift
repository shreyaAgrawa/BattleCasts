//
//  ViewController.swift
//  BattleCastsApp
//
//  Created by Shreya Agrawal on 6/29/24.
//

//
//  ViewControllerAlias.swift
//  BattleCastsApp
//
//  Created by Shreya Agrawal on 7/2/24.
//

import Foundation
//
//  ViewController.swift
//  BattleCastsApp
//
//  Created by Shreya Agrawal on 6/29/24.
//

import UIKit
import SceneKit
import ARKit
import CoreLocation

class ViewController: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        // improve lighting
        sceneView.autoenablesDefaultLighting = true
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        setupLocationManager()
        
        // Create a new scene
        // loadHermes3DModel()
    }
    
    func loadHermes3DModel() {
        print("triggered hermes")
        let scene = SCNScene()
        let hermesPraxScene = SCNScene(named: "hermesPrax.dae")
        guard let hermesNode = hermesPraxScene?.rootNode.childNode(withName: "hermesPrax", recursively: true) else {
            fatalError("hermesModel is not found")
        }
        hermesNode.position = SCNVector3(0, -1, -1.0)
        hermesNode.scale = SCNVector3(0.1, 0.1, 0.1)
        scene.rootNode.addChildNode(hermesNode)
        sceneView.scene = scene
    }
    
    func setupLocationManager() {
        print("called setup loc manager")
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    
        guard let currentLocation = locationManager.location else {
            return
        }
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print("came into location manager")
        
            guard let currentLocation = locations.last else { return }
            
            let targetLocation = CLLocation(latitude: 33.2375, longitude: -96.9225) // Example target location
            let distance = currentLocation.distance(from: targetLocation)
            
            if distance < 50 { // within 50 meters
                loadHermes3DModel()
            }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}


//import UIKit
//import SceneKit
//import ARKit
//import CoreLocation
//import MapKit
//
//class ViewController: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate {
//    
//    @IBOutlet weak var mapView: MKMapView!
//    fileprivate let locationManager:CLLocationManager = CLLocationManager()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = kCLDistanceFilterNone
//        locationManager.startUpdatingLocation()
//        
//        mapView.showsUserLocation = true
//        
//    }
//    
//}

