//
//  CoreDataPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/01.
//

import SwiftUI
import CoreData

struct CoreDataPractice: View {
    
    // MARK: - Properties
    @StateObject var viewModel = CoreDataViewModel()
    @State var textFieldText = ""
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Add Fruit here...", text: $textFieldText)
                    .font(.headline)
                    .frame(height: 55)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding()
                
                Button {
                    guard !textFieldText.isEmpty else { return }
                    viewModel.addFruit(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                List {
                    ForEach(viewModel.savedEntities) { entity in
                        Text(entity.name ?? "No Name")
                            .onTapGesture {
                                viewModel.updateData(fruit: entity)
                            }
                    }
                    .onDelete(perform: viewModel.deleteFruits)
                    .listStyle(.plain)
                }

            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataPractice_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataPractice()
    }
}

// MARK: - ViewModel
class CoreDataViewModel: ObservableObject {
    
    @Published var savedEntities: [FruitEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successfully Loaded")
                self.fetchFruits()
            }
        }
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error Fetching.. \(error.localizedDescription)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruits(offsets: IndexSet) {
        offsets.map { savedEntities[$0] }.forEach { container.viewContext.delete($0) }
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateData(fruit: FruitEntity) {
        let currentName = fruit.name ?? ""
        let newName = currentName + "!"
        fruit.name = newName
        saveData()
    }
}
