//
// Shotcut function for creating NSURLSessionDataTask.
//

import UIKit

struct MoaHttp {
  static func createDataTask(url: String,
    onSuccess: (NSData, NSHTTPURLResponse)->(),
    onError: (NSError?, NSHTTPURLResponse?)->()) -> NSURLSessionDataTask? {
      
    if let nsUrl = NSURL(string: url) {
      return createDataTask(nsUrl, onSuccess: onSuccess, onError: onError)
    }
    
    return nil
  }
  
  private static func createDataTask(nsUrl: NSURL,
    onSuccess: (NSData, NSHTTPURLResponse)->(),
    onError: (NSError?, NSHTTPURLResponse?)->()) -> NSURLSessionDataTask? {
      
    return NSURLSession.sharedSession().dataTaskWithURL(nsUrl) { (data, response, error) in
      if let httpResponse = response as? NSHTTPURLResponse {
        if error == nil {
          if httpResponse.statusCode != 200 {
            onError(nil, httpResponse)
          } else {
            onSuccess(data, httpResponse)
          }
        } else {
          onError(error, httpResponse)
        }
      } else {
        onError(error, nil)
      }
    }
  }
}