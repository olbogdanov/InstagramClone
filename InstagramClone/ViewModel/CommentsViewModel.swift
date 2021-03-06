//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by bogdanov on 22.05.21.
//

import Firebase
import SwiftUI

class CommentsViewModel: ObservableObject {
    private let post: Post
    @Published var comments = [Comment]()

    init(post: Post) {
        self.post = post
        fetchComments()
    }

    func uploadComment(commentText: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let postId = post.id else { return }
        let data: [String: Any] = ["userName": user.userName,
                                   "profileImageUrl": user.profileImageUrl,
                                   "uid": user.uid,
                                   "timestamp": Timestamp(date: Date()),
                                   "postOwnerUid": post.ownerUid,
                                   "commentText": commentText]
        COLLECTION_POSTS.document(postId)
            .collection("post-comments")
            .addDocument(data: data) { error in
                if let error = error {
                    print("DEBUG: Error uploading comment \(error)")
                }
                
                NotificationsViewModel.uploadNotification(toUid: self.post.ownerUid, type: .comment, post: self.post)
            }
    }

    func fetchComments() {
        guard let postId = post.id else { return }
        let query = COLLECTION_POSTS.document(postId)
            .collection("post-comments")
            .order(by: "timestamp", descending: true)
        query.addSnapshotListener { snapshot, error in
            if let error = error {
                print("DEBUG: Error uploading comment \(error)")
            } else {
                guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
                self.comments.append(contentsOf: addedDocs.compactMap { try? $0.document.data(as: Comment.self) })
            }
        }
    }
}
