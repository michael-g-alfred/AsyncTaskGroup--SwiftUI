import SwiftUI

struct PostDetailView: View {
    
    let post: PostModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                
                Text(post.title)
                    .font(.title2)
                    .bold()
                
                Text(post.body)
                    .font(.body)
                
                    // Tags
                HStack {
                    ForEach(post.tags, id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.caption2)
                            .padding(4)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
                
                HStack(spacing: 20) {
                    Label("\(post.views)", systemImage: "eye")
                    Label("\(post.reactions.likes)", systemImage: "hand.thumbsup")
                    Label("\(post.reactions.dislikes)", systemImage: "hand.thumbsdown")
                    Spacer()
                    Text("User: \(post.userID)")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                
            }
            .padding()
        }
        .navigationTitle("Post")
        .navigationBarTitleDisplayMode(.inline)
    }
}
