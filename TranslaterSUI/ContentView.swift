//
//  ContentView.swift
//  TranslaterSUI
//
//  Created by Oleg Arnaut  on 07.02.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var languages = ArrayOfLanguage()
    @StateObject var translate = Translate()
    
    
     
    var body: some View {
        // MARK: - Body start
        VStack{
            HStack{
            Spacer()
            if languages.languageArray.count > 0 {
                Picker("language", selection: $translate.fromLanguage) {
                    ForEach(0..<languages.languageArray.count) {i in
                        Text(languages.languageArray[i].language).tag(languages.languageArray[i].code)
                        
                    }
                }.pickerStyle(.menu)

            }
                Spacer()
            
            if languages.languageArray.count > 0 {
                Picker("", selection: $translate.toLanguage) {
                    ForEach(1..<languages.languageArray.count) {i in
                        Text(languages.languageArray[i].language).tag(languages.languageArray[i].code)
                        
                    }
                }.pickerStyle(.menu)
                    

            }
            Spacer()
            }
            TextEditor(text: $translate.textBefore).border(.gray, width: 1)
            HStack{
               
                Spacer()
                Button {
                    translate.translate()
                   
                   
                    
                } label: {
                    Text("Перевести")
                }
                Spacer()
            }
            
            
            TextEditor(text: $translate.textAfter ).border(.gray, width: 1)

        }.padding()
        // MARK: - Body finish
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
