//
//  UserStatView.swift
//  InstagramClone
//
//  Created by bogdanov on 11.05.21.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String

    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 15, weight: .semibold))

            Text("\(title)")
                .font(.system(size: 15))
        }.frame(width: 80, alignment: .center)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 3, title: "Followers")
    }
}
