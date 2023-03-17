//
//  ContentView.swift
//  SwiftBootCamp_Intermediate
//
//  Created by Thuocsi on 17/03/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors:[NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)]) var fruits: FetchedResults<FruitEntity>
    
    @State var textFieldText:String = ""

    var body: some View {
        NavigationView {
            VStack(spacing:20) {
                TextField("Add fruit here....", text:$textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.4))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    addItem()
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.blue)
                        .cornerRadius(10)
                        .padding(.horizontal,20)
                    
                }

                List {
                    ForEach(fruits) { fruit in
                        Text(fruit.name ?? "")
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Fruits")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: addItem, label: {
                    Label("Add Item", systemImage: "plus")
            }))
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.name = textFieldText
            textFieldText = ""
            saveItem()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
            print("khanh offset",offsets)
            print("khanh",offsets.first)
            guard let index = offsets.first else {return}
            print("khanh index",index)
            let fruitEntity = fruits[index]
            viewContext.delete(fruitEntity)
            saveItem()
        }
    }
    
    private func saveItem(){
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
