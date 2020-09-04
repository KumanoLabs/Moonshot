//
//  ContentView.swift
//  Moonshot
//
//  Created by Erik on 5/19/20.
//  Copyright © 2020 Erik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingDates = true

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: self.missions)) {
                    
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if self.showingDates == true {
                            Text(mission.formattedLaunchDate)
                                .foregroundColor(.secondary)
                        } else {
                            Text("\(self.astronautsFiltered(by: mission))")
                                //.font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                }
            }
        .navigationBarTitle("Moonshot")
        .navigationBarItems(trailing:
            Button(action: {
                self.showingDates.toggle()
            }) {
                if showingDates == true {
                    Text("Show Names")
                } else {
                    Text("Show Dates")
                }
            }
        )}
    }
    
    func astronautsFiltered(by mission: Mission) -> String {
        var members = [Astronaut]()
        for member in mission.crew {
            for astronaut in astronauts {
                if member.name == astronaut.id {
                    members.append(astronaut)
                }
            }
        }

        var string = ""
        for member in members {
            if string.count == 0 {
                string += "\(member.name)"
            } else {
                string += ", \(member.name)"
            }
        }
        return string
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
