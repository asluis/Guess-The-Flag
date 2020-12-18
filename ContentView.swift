//
//  ContentView.swift
//  Flag Guessing Recreation
//
//  Created by Luis Alvarez on 12/16/20.
//

/*
 Player picks designated flag. If correct, score goes up. If wrong, alert shows.
 Regardless, correct flag will spin everytime user clicks a flag to let them know if it was correct or not.
 */

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria","Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State var showAns = false
    @State var correctAns = Int.random(in: 0..<3)
    @State var score = 0
    @State var rotationAngle = 0.0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30){
                VStack{
                    Text("Tap on the flag of \(countries[correctAns])!")
                        .bold()
                        .wordStyle()
                    
                    Text("Score: \(self.score)")
                        .wordStyle()
                }
                
                ForEach(0..<3, id: \.self) { country in
                    Button(action: {
                        print("Pressed \(countries[country]) button!")
                        
                        withAnimation{
                            self.rotationAngle += 360
                        }
                        self.flagTapped(country: country)
                    }) {
                        Image(countries[country])
                            .clipShape(Capsule())
                            .overlay(Capsule().strokeBorder(Color.black, lineWidth: 2))
                            .rotation3DEffect(
                                correctAns == country ? .degrees(self.rotationAngle) : .degrees(0),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                        
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
        self.rotationAngle = 0.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Creates custom modifier for our text on this app
struct Word: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
    }
}


extension View{
    func wordStyle() -> some View{
        self.modifier(Word())
    }
}
