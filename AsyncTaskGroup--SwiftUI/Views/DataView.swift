import SwiftUI

struct DataView: View {
    
    @State var vm = DataViewModel()
    
    
    var body: some View {
        TabView {
            UserView(vm: vm)
                .tabItem {
                    Label("Users", systemImage: "person.2")
                }
            
            PostView(vm: vm)
                .tabItem {
                    Label("Posts", systemImage: "book")
                }
        }
        .onAppear {
            Task {
                try? await vm.fetchData()
            }
        }
    }
}

#Preview {
    DataView()
}
