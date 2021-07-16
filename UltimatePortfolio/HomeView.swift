//
//  Home.swift
//  UltimatePortfolio
//
//  Created by Charles Johler on 16.07.21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataController: DataController
    
    
    var body: some View {
        NavigationView {
            VStack{
                Button("Add Data") {
                  try? dataController.createSampleData()
                }
                .padding()
                Button("del Data") {
                    dataController.deleteAll()
                        //     try? dataController.createSampleData()
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
