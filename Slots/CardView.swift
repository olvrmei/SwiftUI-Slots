//
//  CardView.swift
//  Slots
//
//  Created by Meika Farias de Oliveira on 16/07/20.
//  Copyright © 2020 Meika Farias de Oliveira. All rights reserved.
//

import SwiftUI

struct CardView: View {

    @Binding var symbol:String
    @Binding var background:Color
    
    var body: some View {
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding(.all, 5)
            .background(background.opacity(0.5))
            .cornerRadius(30)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbol: Binding.constant("cherry"), background: Binding.constant(Color.green))
    }
}
