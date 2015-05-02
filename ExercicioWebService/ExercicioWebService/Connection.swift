//
//  Connection.swift
//  ExercicioWebService
//
//  Created by Jorge Henrique P. Garcia on 4/29/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit

class Connection: NSObject, NSURLConnectionDelegate{
   
    var data: NSData?
    var response: NSURLResponse?
    var error: NSError?
    
    func getData (url: String) {
        // set up the base64-encoded credentials
        let username = "webserviceGit"
        let password = "webserviceGit123"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        // create the request
        let url2 = NSURL(string: url)
        let request = NSMutableURLRequest(URL: url2!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        // fire off the request
        // make sure your class conforms to NSURLConnectionDelegate
        //let urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        
        self.data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &self.response, error: &self.error)
    }
    
    
//    
//    func send(url: String, f: (String)-> ()) {
//        var request = NSURLRequest(URL: NSURL(string: url)!)
//        var response: NSURLResponse?
//        var error: NSErrorPointer = nil
//        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: error)
//        var reply = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        f(reply)
//    }

    
    
    
    
    
    func connection(connection:NSURLConnection!, didReceiveResponse response: NSURLResponse) {
        let status = (response as! NSHTTPURLResponse).statusCode
        println("status code is \(status)")
        // 200? Yeah authentication was successful
    }
    
    //NSURLConnection delegate method
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        //Append incoming data
        self.data = data
    }
    
    //NSURLConnection delegate method
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        NSLog("connectionDidFinishLoading");
    }
    
    //NSURLConnection delegate method
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        println("Failed with error:\(error.localizedDescription)")
    }
    

}
