//
//  ContentView.swift
//  Slots
//
//  Created by Meika Farias de Oliveira on 13/07/20.
//  Copyright © 2020 Meika Farias de Oliveira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var images = ["apple", "cherry", "star"]
    //@State private var numbers = [0,0,0,0,0,0,0,0,0]
    @State private var numbers = Array(repeating: 0, count: 9)
    //@State private var backgrounds = [Color.white, Color.white, Color.white, Color.white, Color.white, Color.white, Color.white, Color.white, Color.white]
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var points = 100
    private var betAmount = 5
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .foregroundColor(Color(red: 230/255, green: 170/255, blue: 200/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red: 230/255, green: 220/255, blue: 230/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                // Title
                HStack{
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("SwiftUI Slots!")
                        .foregroundColor(Color(red: 68/255, green: 77/255, blue: 85/255))
                        .fontWeight(.semibold)
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }.scaleEffect(1.8)
                Spacer()
                
                // Points counter
                Text("Points: " + String(points))
                    .foregroundColor(Color(red: 68/255, green: 77/255, blue: 85/255))
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                Spacer()
                
                // Images
                VStack{
                    HStack(alignment: .center){
                        Spacer()
                        CardView(symbol: $images[numbers[0]],background: $backgrounds[0])
                        CardView(symbol: $images[numbers[1]],background: $backgrounds[1])
                        CardView(symbol: $images[numbers[2]],background: $backgrounds[2])
                        Spacer()
                    }
                    HStack(alignment: .center){
                        Spacer()
                        CardView(symbol: $images[numbers[3]],background: $backgrounds[3])
                        CardView(symbol: $images[numbers[4]],background: $backgrounds[4])
                        CardView(symbol: $images[numbers[5]],background: $backgrounds[5])
                        Spacer()
                    }
                    HStack(alignment: .center){
                        Spacer()
                        CardView(symbol: $images[numbers[6]],background: $backgrounds[6])
                        CardView(symbol: $images[numbers[7]],background: $backgrounds[7])
                        CardView(symbol: $images[numbers[8]],background: $backgrounds[8])
                        Spacer()
                    }
                }
                Spacer()
                HStack(spacing: 20){
                    VStack{
                        // Play button 1
                        Button(action: {
                            self.processResults(false)
                            
                        }) {
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount) credits").padding(.top, 7)
                    }
                    VStack{
                        // Play button 2
                        Button(action: {
                            self.processResults(true)
                        }) {
                            Text("Max Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount*5) credits").padding(.top, 7)
                    }
                }
                Spacer()
                
            }
        }
    }
    
    func processResults(_ isMax:Bool = false){
        // Set all backgrounds back to white
        self.backgrounds = self.backgrounds.map({ _ in Color.white
        })
        
        if isMax{
            // Spin all the cards
            self.numbers = self.numbers.map{ _ in
                Int.random(in: 0...self.images.count-1)
            }
        }
        else{
            self.numbers[3] = Int.random(in: 0...self.images.count-1)
            self.numbers[4] = Int.random(in: 0...self.images.count-1)
            self.numbers[5] = Int.random(in: 0...self.images.count-1)
        }
        
        processWin(isMax)
    }
    
    func processWin(_ isMax:Bool = false){
        
        var matches = 0
        
        if !isMax{
            self.points -= betAmount
            // Processing for single spin
            if isMatch(3,4,5){
                self.points += betAmount * 2
            }
        }
        else{
            self.points -= betAmount * betAmount
            // Processing for max spin
            // Top row
            if isMatch(0,1,2){
                matches += 1
            }
            
            // Middle row
            if isMatch(3,4,5){
                matches += 1
            }
            
            // Bottom row
            if isMatch(6,7,8){
                matches += 1
            }
            
            // Diagonal 1
            if isMatch(0,4,8){
                matches += 1
            }
            
            // Diagonal 2
            if isMatch(2,4,6){
                matches += 1
            }
            
            self.points += matches * betAmount * betAmount * 2
        }
    }
    
    func isMatch(_ a:Int, _ b:Int, _ c:Int) -> Bool{
        if self.numbers[a] == self.numbers[b] && self.numbers[b] == self.numbers[c]{
            // Update backgrounds
            self.backgrounds[a] = Color.green
            self.backgrounds[b] = Color.green
            self.backgrounds[c] = Color.green
            
            return true
        }
        return false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
