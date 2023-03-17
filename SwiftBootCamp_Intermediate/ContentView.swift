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
    
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: []) var fruits: FetchedResults<FruitEntity>

    var body: some View {
        NavigationView {
            List {
                ForEach(fruits) { fruit in
                    Text(fruit.name ?? "")
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Core Data Bootcamp")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: addItem, label: {
                Label("Add Item", systemImage: "plus")
            }))
        }
    }

    private func addItem() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.name = "Organe"

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
