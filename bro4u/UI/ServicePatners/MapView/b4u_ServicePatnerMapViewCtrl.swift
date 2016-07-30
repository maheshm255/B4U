//
//  b4u_ServicePatnerMapViewCtrl.swift
//  bro4u
//
//  Created by Tools Team India on 04/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit
import MapKit

class b4u_ServicePatnerMapViewCtrl: UIViewController ,MKMapViewDelegate{
    
    @IBOutlet weak var mapView:MKMapView!

    var annotationTag = 100

    var annotationView2 = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.zoomToRegion()
        
        let annotations = getMapAnnotations()

        // Add mappoints to Map
        mapView.delegate = self

        dispatch_async(dispatch_get_main_queue(), {
            
            self.mapView.addAnnotations(annotations)

            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- Zoom to region
    
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 12.9121, longitude:77.6076)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 1000.0, 1000.0)
        
        mapView.setRegion(region, animated: true)
    }
    
    
    //MARK:- Annotations
    
    func getMapAnnotations() -> [MKPointAnnotation]
    {
        var annotations:Array = [MKPointAnnotation]()
        
        if let suggestedPatners = bro4u_DataManager.sharedInstance.suggestedPatnersResult?.suggestedPatners{
            for aSuggestedPatner in suggestedPatners {
                let information = MKPointAnnotation()
                let lat = Double(aSuggestedPatner.latitude!)
                let long = Double(aSuggestedPatner.longitude!)

                let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, long!)
                information.coordinate = location
                information.title = "titrle"
                annotations.append(information)
                annotationTag += 1
            }
        }
        
        return annotations
    }
    

    //This Function is used for change the pin of Annotation
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            //To change Pin Image
            anView!.image = UIImage(named:"user")
            anView!.canShowCallout = false
            
            //Top put image inside Anotation View
//            let image : UIImage = UIImage(named:"user")!
//            let myImageView = UIImageView(image: image)
//            myImageView.frame = CGRectMake(0,0,48,48); // Change the size of the image to fit the callout
//            
            //      anView!.leftCalloutAccessoryView = myImageView;
            
            //      anView!.rightCalloutAccessoryView = self.bookButton;
        }
        else {
            anView!.annotation = annotation
        }
        
        anView!.tag = annotationTag;
        
        return anView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        annotationView2  = (NSBundle.mainBundle().loadNibNamed("CustomAnnotationView", owner: self, options: nil).first as? UIView)!
        let hitPoint : CGPoint = self.view.convertPoint(CGPointZero, fromView: mapView)
        annotationView2.frame  = CGRectMake(hitPoint.x-94,hitPoint.y-73, 300, 100)
        annotationView2.tag = view.tag;
        
        view.addSubview(annotationView2)
    }
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
