//
//  ContentView.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import SwiftUI
import UIKit
import CardViewSPM

struct ContentView: View {
    
    @State private var btclick = false
    
    var body: some View {
        HStack {
            Button(action: {
                self.btclick.toggle()
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
//            .sheet(isPresented: $btclick, onDismiss: {
//                print("Dismiss")
//            }) {
//                createCardView()
//                
//            }
                
            
        }
    }
//
//    private func createCardView() -> View {
//        let controller = UIViewController()
//        let contentList = UIHostingController(rootView: ContentList())
//        controller.view = contentList.view
//        contentList.view?.fillSuperview()
//        let cardView = CardViewActivityVC(innerController: controller).view
//        let controller2 = UIViewController()
//        controller2.view = cardView
//
//        let host = UIHo
//
//    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ContentList: View {
    var body: some View {
        List {
            Text("1 - brazil")
            Text("2 - NIgeria")
            Text("3 - Kenya")
        }
    }
}
