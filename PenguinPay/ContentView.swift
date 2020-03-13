//
//  ContentView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var btclick = false    
    
    fileprivate func btClicked() -> Text {
        return self.btclick ? Text("Hello, World!") : Text("Ola") .foregroundColor(.red)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            foregroundColor(.white).edgesIgnoringSafeArea(.all)
            HStack {
                Button(action: {
                    
                }) {
                    VStack {
                        Image(systemName: "coloncurrencysign.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Send money")
                    }
                }
                .padding()
                    
                .foregroundColor(Color.white)
                .background(Color.yellow)
                .cornerRadius(.infinity)
                .shadow(radius: 10)
                .padding()
                
                
                Button(action: {
                    self.btclick.toggle()
                }) {
                    btClicked()
                }
                .foregroundColor(.gray)
                Button(action: {
                    self.btclick.toggle()
                }) {
                    btClicked()
                }
                .foregroundColor(.gray)
            }
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
