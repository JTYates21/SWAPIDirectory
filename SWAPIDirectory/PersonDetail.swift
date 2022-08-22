//
//  UserDetailView.swift
//  APIDirectory
//
//  Created by Jacek Yates on 8/17/22.
//

import Foundation
import SwiftUI
import CoreData

struct PersonDetail: View {
    let person: Person
    //let forceSensitive = person.forceSensitive
    
    var body: some View {
        
        VStack {
            Spacer()
            URLImage(urlString: person.profilePicture, data: nil)
            Spacer()
            Text("\(person.firstName) \(person.lastName)")
            Text("Birthday: \(person.birthdate)")
            //Text("Force Sensitive: \(forceSensitive)")
            Text("Affiliation: \(person.affiliation)")
            Spacer()
        }
        .navigationTitle(Text("\(person.firstName) \(person.lastName)"))
    }
}
struct PersonDetail_Previews : PreviewProvider {
    static var previews: some View {
        PersonDetail(person: Person(
            id: 1,
            firstName: "Luke",
            lastName: "Skywalker",
            birthdate: "111-12",
            profilePicture: "https://edge.ldscdn.org/mobile/interview/07.png",
            forceSensitive: true,
            affiliation: "Jedi"))
    }
}
