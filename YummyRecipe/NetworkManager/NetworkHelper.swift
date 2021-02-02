//
//  NetworkHelper.swift
//  YummyRecipe
//
//  Created by Avnish on 30/01/21.
//

import Foundation

class NetworkHelper {
    
    static func getTagList() {

        let headers = [
            "x-rapidapi-key": "f829bcee5fmshb5c81d45f3920c7p1c169bjsnb5be62636ec7",
            "x-rapidapi-host": "tasty.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://tasty.p.rapidapi.com/tags/list")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                print(error?.localizedDescription)
            }
        })

        dataTask.resume()
    }
}
