//
//  Model.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/04.
//

import Foundation

class Model {
    
    func getVideo() {
        // creating url object -> Why?
        let url = URL(string: Constant.API_URL)
        guard let url = url else { return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            
            // check for any errors or data is nil
            if error != nil || data == nil {
                return
            }
        }
        dataTask.resume()
    }
}
