//
//  TranslateText.swift
//  TranslaterSUI
//
//  Created by Oleg Arnaut  on 09.02.2024.
//

import Foundation

class Translate: ObservableObject {
    @Published var fromLanguage : String = "auto"{
        didSet{
            if toLanguage != oldValue {
                translate()
            }
        }
    }
    
    @Published var toLanguage : String = "en"{
        didSet{
            if toLanguage != oldValue {
                translate()
            }
        }
    }
    @Published var textBefore : String = "Привет"
    @Published var textAfter : String = ""
   

        func translate(){
           
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "X-RapidAPI-Key": "0e2860071amsh99a96e3eefc8831p11e023jsn250cd8192f47",
                "X-RapidAPI-Host": "google-translate113.p.rapidapi.com"
            ]

            let postData = NSMutableData(data: "from=\(fromLanguage)".data(using: String.Encoding.utf8)!)
            postData.append("&to=\(toLanguage)".data(using: String.Encoding.utf8)!)
            postData.append("&text=\(textBefore)".data(using: String.Encoding.utf8)!)

            let request = NSMutableURLRequest(url: NSURL(string: "https://google-translate113.p.rapidapi.com/api/v1/translator/text")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("error")
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse else {
                        print("no response")
                        return
                    }
                    if httpResponse.statusCode == 200, let data = data {
                        do{
                            let decodedResponse = try JSONDecoder().decode(TranslateText.self, from: data)
                            self.textAfter =  decodedResponse.trans
                           
                            
                        }catch{
                            print("sdf")
                        }
                    }
                    
                }
            })

            dataTask.resume()
               
        }
    }


