//
//  GetLanguage.swift
//  TranslaterSUI
//
//  Created by Oleg Arnaut  on 07.02.2024.
//

import Foundation

class ArrayOfLanguage : ObservableObject {
    @Published var languageArray : [Language] = []
    
    init(){
        getLanguageArray()
    }
    
    func getLanguageArray() {
        
        let headers = [
            "X-RapidAPI-Key": "0e2860071amsh99a96e3eefc8831p11e023jsn250cd8192f47",
            "X-RapidAPI-Host": "google-translate113.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://google-translate113.p.rapidapi.com/api/v1/translator/support-languages")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil  else {
                    
                    return
                    
                }
                do {
                    let decodeData = try  JSONDecoder().decode([Language].self, from: data)
                    self.languageArray = decodeData
                    
                }
                catch{
                    print("error")
                }
                

            }
            
        })

        dataTask.resume()
    }
    
}
