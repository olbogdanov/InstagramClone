//
//  CommentCell.swift
//  InstagramClone
//
//  Created by bogdanov on 22.05.21.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            KFImage(URL(string: comment.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())

            Text(comment.userName).font(.system(size: 14, weight: .semibold))
                + Text(" \(comment.commentText)").font(.system(size: 14))

            Spacer()
            
            Text(comment.timestamp.dateValue().timeAgo())
                .foregroundColor(.gray)
                .font(.system(size: 12))
        }.padding(.horizontal)
    }
}
