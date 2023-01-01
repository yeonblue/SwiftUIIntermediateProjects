//
//  CoreDataRelationshipPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/01.
//

import SwiftUI
import CoreData

// entity: Business, Department, Employee 총 3개

struct CoreDataRelationshipPractice: View {
    
    // MARK: - Properties
    @StateObject var viewModel = CoreDataRelationshipViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    Button {
                        //viewModel.addBusiness()
                        viewModel.addDepartment()
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                            .padding()
                    }

                }
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(alignment: .top, spacing: 8) {
                        ForEach(viewModel.businesses) { business in
                            BusinessView(entity: business)
                        }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(alignment: .top, spacing: 8) {
                        ForEach(viewModel.departments) { department in
                            DepartmentView(entity: department)
                        }
                    }
                }
            }
            .navigationTitle("CoreData Relationships")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct CoreDataRelationshipPractice_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipPractice()
    }
}

// MARK: - Manager
class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            } else {
                
            }
        }
        context = container.viewContext
    }
    
    func save(){
        do {
            try context.save()
            print("Save Success")
        } catch {
            print("Error Save CoreData: \(error.localizedDescription)")
        }
    }
}

// MARK: - ViewModel
class CoreDataRelationshipViewModel: ObservableObject {
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    
    let manager = CoreDataManager.instance
    
    init() {
        getBusiness()
        getDepartments()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        
        // newBusiness.departments = []
        // newBusiness.employees = []
        // newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        // newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Marketing"
        newDepartment.businesses = [businesses[0]]
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.manager.save()
            self.getBusiness()
            self.getDepartments()
        }
    }
    
    func getBusiness() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Name: \(entity.name ?? "")")
                .font(.body)
            
            if let departsments = entity.departments?.allObjects as? [DepartmentEntity] {
                Divider()
                
                Text("Departments")
                    .bold()
                ForEach(departsments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Divider()
                
                Text("Employees")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Name: \(entity.name ?? "")")
                .font(.body)
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Divider()
                
                Text("Departments")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Divider()
                
                Text("Employees")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
