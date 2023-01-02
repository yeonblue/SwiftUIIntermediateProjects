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
                        // viewModel.addBusiness()
                        // viewModel.addDepartment()
                        viewModel.addEmployee()
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
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(alignment: .top, spacing: 8) {
                        ForEach(viewModel.employees) { employee in
                            EmployView(entity: employee)
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
    @Published var employees: [EmployeeEntity] = []
    let manager = CoreDataManager.instance
    
    init() {
        getBusiness()
        getDepartments()
        getEmployees()
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
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 20
        newEmployee.name = "Chris"
        newEmployee.dateJoined = Date()
        
        newEmployee.business = businesses[0] // To one이라 하나만 가질 수 있음
        newEmployee.department = departments[0]
        save()
    }
    
    func save() {
        businesses.removeAll() // struct가 아닌 class라 내용변경만으로는 objectWillChange가 발생하지 않음
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.manager.save()
            self.getBusiness()
            self.getDepartments()
            self.getEmployees()
        }
    }
    
    func getBusiness() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        let filter = NSPredicate(format: "name == %@", "Apple")
        request.sortDescriptors = [sort]
        request.predicate = filter
        
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
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
    
    func getEmployees(business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        let filter = NSPredicate(format: "business == %@", business) // to one일때 적합
        request.predicate = filter
        
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
    
    func updateBusiness() {
        let existingBusiness = businesses[1]
        existingBusiness.addToDepartments(departments[1])
        save()
    }
    
    func deleteDepartment() {
        let department = departments[2]
        
        // delete rule - nullify 삭제하면 그것만 지워짐
        // cascade면 연관된 모든 것이 같이 삭제
        // deny 다른 것들이 삭제되기 전까진 삭제 불가
        manager.context.delete(department)
        save()
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

struct EmployView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Name: \(entity.name ?? "")")
                .font(.body)
            Text("Age: \(entity.age)")
                .font(.body)
            Text("DateJoined: \(entity.dateJoined ?? Date())")
                .font(.body)
            
            Text("Busines:")
                .bold()
            
            Text(entity.business?.name ?? "") // to one이라 한개만 가짐
            
            Text("Department:")
                .bold()
            
            Text(entity.department?.name ?? "") // to one이라 한개만 가짐
            
            // if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
            //     Divider()
            //
            //     Text("Departments")
            //         .bold()
            //     ForEach(businesses) { business in
            //         Text(business.name ?? "")
            //     }
            // }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.orange.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
