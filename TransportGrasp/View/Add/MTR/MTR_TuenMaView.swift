//
//  MTR_TuenMaView.swift
//  MTR_TuenMaView
//
//  Created by Johnny on 22/8/2021.
//

import SwiftUI

struct MTR_TuenMaView: View {
    @ObservedObject var favouriteRoutes: FavouriteRoutes
    @State var mtr_tuenMa = MTR_TuenMa()
    
    @State var showAlert:Bool = false
    @State var alertText:String = "Loading..."
    
    var body: some View {
        ZStack{
            VStack{
                Text("上車地點")
                    .font(.title3)

                ScrollView{
                    ForEach(mtr_tuenMa.stations,id:\.self){station in
                        let details_up:[String:String] = ["lineCode":station.lineCode,
                                                          "line":station.line,
                                                          "stationCode":station.stationCode,
                                                          "station":station.station,
                                                          "dest": mtr_tuenMa.stations[0].station,
                                                          "orig":mtr_tuenMa.stations[mtr_tuenMa.stations.count-1].station,
                                                          "dir":"UP"]
                        let details_down:[String:String] = ["lineCode":station.lineCode,
                                                            "line":station.line,
                                                            "stationCode":station.stationCode,
                                                            "station":station.station,
                                                            "dest": mtr_tuenMa.stations[mtr_tuenMa.stations.count-1].station,
                                                            "orig":mtr_tuenMa.stations[0].station,
                                                            "dir":"DOWN"]
                        Menu {
                            Text("Add to favourite")
                            Button {
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                                if favouriteRoutes.checkFavourite(category: "mtr_tuenMa", details: details_up){
                                    for route in favouriteRoutes.favouriteArray{
                                        if route.details == details_up, route.category == "mtr_tuenMa"{
                                            print("Remove: \(route.favouriteID)")
                                            favouriteRoutes.removeFavourite(id: route.favouriteID)
                                        }
                                    }
                                }else{
                                    if favouriteRoutes.favouriteArray.count == 5{
                                        self.alertText = "Max favourite is 5 currently"
                                        self.showAlert = true
                                    }
                                    else{
                                        favouriteRoutes.saveFavourite(category: "mtr_tuenMa", details: details_up)
                                    }
                                }
                            } label: {
                                Image(systemName: favouriteRoutes.checkFavourite(category: "mtr_tuenMa", details: details_up) ? "flag.slash.fill":"arrow.up")
                                if let station = mtr_tuenMa.stations.first?.station{
                                    Text("往 \(station)")
                                }
                            }
                            .disabled(station == mtr_tuenMa.stations.first)
                            
                            Button {
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                                if favouriteRoutes.checkFavourite(category: "mtr_tuenMa", details: details_down){
                                    for route in favouriteRoutes.favouriteArray{
                                        if route.details == details_down, route.category == "mtr_tuenMa"{
                                            print("Remove: \(route.favouriteID)")
                                            favouriteRoutes.removeFavourite(id: route.favouriteID)
                                        }
                                    }
                                }else{
                                    if favouriteRoutes.favouriteArray.count == 5{
                                        self.alertText = "Max favourite is 5 currently"
                                        self.showAlert = true
                                    }
                                    else{
                                        favouriteRoutes.saveFavourite(category: "mtr_tuenMa", details: details_down)
                                    }
                                }
                            } label: {
                                Image(systemName: favouriteRoutes.checkFavourite(category: "mtr_tuenMa", details: details_down) ? "flag.slash.fill":"arrow.down")
                                if let station = mtr_tuenMa.stations.last?.station{
                                    Text("往 \(station)")
                                }
                            }
                            .disabled(station == mtr_tuenMa.stations.last)
                        } label: {
                            let chosen = favouriteRoutes.checkFavourite(category: "mtr_tuenMa", details: details_up)||favouriteRoutes.checkFavourite(category: "mtr_tuenMa", details: details_down)
                            HStack{
                                Spacer()
                                Text(station.station)
                                    .font(.title3)
                                    .padding(.vertical,5)
                                    .padding(.horizontal)
                                VStack{
                                    if station != mtr_tuenMa.stations.first{
                                        Image(systemName: favouriteRoutes.checkFavourite(category: "mtr_tuenMa", details: details_up) ? "arrow.up.circle.fill":"arrow.up.circle")
                                        //                                        .foregroundColor(.black)
                                    }
                                    if station != mtr_tuenMa.stations.last{
                                        Image(systemName: favouriteRoutes.checkFavourite(category: "mtr_tuenMa", details: details_down) ? "arrow.down.circle.fill":"arrow.down.circle")
                                        //                                        .foregroundColor(.black)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical,3)
                                
                                Spacer()
                            }
                            .background(chosen ? Color.init("mtrTuenMa"):Color.white)
                            .foregroundColor(chosen ? .white:.black)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black,lineWidth:0.2)
                            )
                            
                        }
                        .padding(.horizontal,30)
                    }
                }
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertText))
        }
    }
}

