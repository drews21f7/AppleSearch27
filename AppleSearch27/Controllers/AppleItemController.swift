//
//  AppleItemController.swift
//  AppleSearch27
//
//  Created by Drew Seeholzer on 6/27/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit

class AppleItemController {
    
    //https://itunes.apple.com/search?term=nickelback&media=music
    
    static let baseURL = URL(string: "https://itunes.apple.com")
    
    static func fetchAppleItemFor(term: String, completion: @escaping ([AppleItem]?) -> Void) {
        guard var url = baseURL else {completion(nil); return}
        
        url.appendPathComponent("search")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let searchTermQuery = URLQueryItem(name: "term", value: term)
        //term=\(term)
        //term=nickelback
        let mediaQuery = URLQueryItem(name: "media", value: "music")
        //media=music
        
        //At the end of these two QueryItems
        //search?term=\(term)&media=music
        components?.queryItems = [searchTermQuery, mediaQuery]
        
        guard let finalURL = components?.url else {completion(nil); return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Oh snap, that search didn't work: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil); return}
            
            do {
                let decoder = JSONDecoder()
                let topLevelJSON = try decoder.decode(TopLevelJSON.self, from: data)
                completion(topLevelJSON.results)
            } catch {
                print("Error decoding data yo: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }.resume()
        
    }
    
    static func fetchImageFor(appleItem: AppleItem, completion: @escaping (UIImage?) -> Void) {
        
        let url = appleItem.imageURL
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print ("Error fetching image data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Something didn't fetch correctly with the image data")
                completion(nil)
                return
                
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
}
