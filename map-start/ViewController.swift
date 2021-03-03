//
//  ViewController.swift
//  map-start
//
//  Created by karlis.berzins on 03/03/2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, SecondVCDelegate {
    func updateText(text: String) {
        print(text)
        myLabel.text = text
    }


    let locationManager = CLLocationManager()

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()

        let firstPoint = MKPointAnnotation()
        firstPoint.coordinate = CLLocationCoordinate2D(latitude: 57.53506, longitude: 25.4242)

        mapView.addAnnotation(firstPoint)
        mapView.delegate = self
    }

    func drawRoute(to: CLLocationCoordinate2D) {
      let sourcePlacemark = MKPlacemark(coordinate: mapView.userLocation.coordinate)
      let destPlacemark = MKPlacemark(coordinate: to)

      let directionRequest = MKDirections.Request()
      directionRequest.source = MKMapItem(placemark: sourcePlacemark)
      directionRequest.destination = MKMapItem(placemark: destPlacemark)
      directionRequest.transportType = .automobile

      let directions = MKDirections(request: directionRequest)

      directions.calculate { response, error in
        if let response = response, let route = response.routes.first {
          self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
        }
      }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let coordinate = view.annotation?.coordinate {
            print(coordinate)
            drawRoute(to: coordinate)
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = .red
        render.lineWidth = 10

        return render
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SecondViewController {
            vc.delegate = self
        }
    }
}

