//
//  ContentView.swift
//  CoreDataPractice
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var textFieldText: String = ""
    
    @FetchRequest(entity: FruitEntity.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name,
                                                     ascending: true)])
    var fruits: FetchedResults<FruitEntity>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    TextField("Add Fruit Here...", text: $textFieldText)
                        .background(Color(UIColor.lightGray))
                        .padding(4)
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        addItem()
                        textFieldText = ""
                    } label: {
                        Text("Add Fruit")
                            .font(.headline)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    ForEach(fruits) { fruit in
                        NavigationLink {
                            Text("fruits: \(fruit.name!)")
                        } label: {
                            Text(fruit.name!)
                                .onTapGesture {
                                    updateItem(fruit: fruit)
                                }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                            .labelStyle(.titleAndIcon)
                    }
                }
            }
            .navigationTitle("Fruits")
            .listStyle(.plain)
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.name = textFieldText.isEmpty ? "Orange" : textFieldText

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { fruits[$0] }.forEach(viewContext.delete)
            
            // guard let index = offsets.first else { return }
            // let fruitEntity = fruits[index]
            // viewContext.delete(fruitEntity)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func updateItem(fruit: FruitEntity) {
        withAnimation {
            let currentName = fruit.name ?? ""
            let newName = currentName + "!"
            fruit.name = newName
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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
