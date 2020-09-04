//
//  AstronautView.swift
//  Moonshot
//
//  Created by Erik on 5/20/20.
//  Copyright © 2020 Erik. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        
        for mission in missions {
            for member in mission.crew {
                if astronaut.id == member.name {
                    matches.append(mission)
                }
            }
        }
        self.missions = matches
    }
    
    var missionsString: String {
        var string = ""
        
        for mission in missions {
            if string.count == 0 {
                string.append(mission.displayName)
            } else {
                string.append(", \(mission.displayName)")
            }
        }
        return string
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
//                    ForEach(self.missions) { mission in
//                        Text(mission.displayName)
//                    }
                    Text("Missions: \(self.missionsString)")
                        .padding()
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
