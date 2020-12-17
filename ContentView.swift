//
//  ContentView.swift
//  Flag Guessing Recreation
//
//  Created by Luis Alvarez on 12/16/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria","Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State var showAns = false
    @State var correctAns = Int.random(in: 0..<3)
    @State var score = 0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30){
                VStack{
                    Text("Tap on the flag of \(countries[correctAns])!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Score: \(self.score)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
                ForEach(0..<3, id: \.self) { country in
                    Button(action: {
                        print("Pressed \(countries[country]) button!")
                        
                        self.flagTapped(country: country)
                        
                        
                    }) {
                        Image(countries[country])
                            .clipShape(Capsule())
                            .overlay(Capsule().strokeBorder(Color.black, lineWidth: 2))
                    }
                }.alert(isPresented: $showAns){
                    Alert(title: Text("Wrong"), message: Text("The correct answer was flag number \(correctAns + 1)!"), dismissButton: .default(Text("Dismiss")){
                            countries.shuffle()
                            correctAns = Int.random(in: 0..<3)
                    })
                }
            }
        }
    }
    
    func flagTapped(country:Int){
        if country == correctAns{
            score = score + 1
            countries.shuffle()
            correctAns = Int.random(in: 0..<3)
        } else{
            showAns = true

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
