//
//  BackgroundThreadBootcamp.swift
//  SwiftBootCamp_Intermediate
//
//  Created by Thuocsi on 17/03/2023.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject{
    @Published var dataArray: [String] = []
    
    func fetchData(){
        DispatchQueue.global().async {
            // call in background
            let newData = self.downloadData() // self to get strong referencer class BackgroundThreadViewModel at Background
            DispatchQueue.main.async {
                self.dataArray = newData
                print("khanh data", self.dataArray)
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data:[String] = []
        for x in 0..<100 {
            data.append("\(x)")
            
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView{
            Button {
                vm.fetchData()
            } label: {
                Text("Fetch data")
            }
            
            ForEach(vm.dataArray, id: \.self) { text in
                
                Text(text)
            }

        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp(vm: BackgroundThreadViewModel())
    }
}
