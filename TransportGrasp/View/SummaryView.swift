//
//  SummaryView.swift
//  SummaryView
//
//  Created by Johnny on 20/8/2021.
//

import SwiftUI

struct SummaryView: View {
    @ObservedObject var favouriteRoutes: FavouriteRoutes
    @State var routesHandler = RoutesHandler()
    
    @State var showSheet = false
    
    func delete(at offsets: IndexSet){
        if let index = offsets.first,
           favouriteRoutes.favouriteArray[index].favouriteID == favouriteRoutes.favouriteArray[index].favouriteID{
            favouriteRoutes.removeFavourite(id: favouriteRoutes.favouriteArray[index].favouriteID)
            
        }
    }
    
    func updateETA(){
        favouriteRoutes.updateETA()
    }
    
    var body: some View {
        NavigationView{
            
            ZStack{
                VStack{
                    List{
                        ForEach(favouriteRoutes.favouriteArray,id:\.self){ route in
                            VStack(alignment:.leading){
                                HStack{
                                    Text("Route \(route.favouriteID)")
                                        .padding(5)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(Color.gray,lineWidth:1)
                                        )
                                    
                                    Text(routesHandler.getCategory(targetRoute: route))
                                        .padding(2)
                                        .foregroundColor(.white)
                                        .background(routesHandler.getCatrgoryColor(targetRoute: route))
                                        .cornerRadius(5)
                                }
                                HStack(alignment:.top){
                                    VStack(alignment:.leading){
                                        Text(routesHandler.getTitle(targetRoute: route))
                                            .fontWeight(.heavy)
                                        Text(routesHandler.getStationName(targetRoute: route))
                                    }
                                    Spacer()
                                    Divider()
                                    VStack(alignment:.leading){
                                        ForEach(route.eta,id:\.self){ eta in
                                            Text(eta)
                                        }
                                    }
                                    
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.plain)
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        
                        self.showSheet = true
                        
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 25))
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        
                        favouriteRoutes.updateETA()
                        
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 25))
                    }
                }
                
            }
            .sheet(isPresented: $showSheet,  content: {
                Help_siriShortcut(showSheet: $showSheet)
            })
            
            .onAppear(perform: {
                updateETA()
                print("Arr: \(favouriteRoutes.favouriteArray)")
            })
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}
