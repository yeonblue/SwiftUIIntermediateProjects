//
//  CloudKitCrudPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/02/01.
//

import SwiftUI
import CloudKit

struct FruitModel: Hashable {
    let name: String
    let imageURL: URL?
    let record: CKRecord // 연습용으로 실제 모델에서 직접 record를 넣는 것은 좋지 않음
}

// CloudKit Console에서 Indexes sort할 키 정의 가능 - queryable이 아닌 sortable
// event는 completion으로 처리
class CloudKitCrudPracticeViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var fruits: [FruitModel] = []
    
    init() {
        fetchItems()
    }
    
    func addButtonTapped() {
        guard !text.isEmpty else { return }
        addItem(name: text)
    }
    
    private func addItem(name: String) {
        let newFruit = CKRecord(recordType: "Fruits")
        newFruit["name"] = name
        
        // CKAsset을 올리고 싶으면 FileManager에 저장을 하고 그 URL을 이용해야 함
        // 하지만 내려올 때는 cloudkit에 저장된 url이 내려옴
        guard
            let image = UIImage(named: "swift"),
            let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("swift.jpg"),
            let data = image.jpegData(compressionQuality: 1.0) else { return }
        
        do {
            try data.write(to: path)
            let asset = CKAsset(fileURL: path)
            newFruit["image"] = asset
            saveItem(record: newFruit)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnRecord, error in
            DispatchQueue.main.async {
                print("Record: \(String(describing: returnRecord))")
                print("Error: \(String(describing: error))")
                
                self?.text = ""
                self?.fetchItems()
            }
        }
    }
    
    func fetchItems() {
        let predicate = NSPredicate(value: true) // 모두를 fetch하고 싶으므로
        // let predicate = NSPredicate(format: "name == %@", "Apple")
        
        let query = CKQuery(recordType: "Fruits", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [FruitModel] = []
        
        // result 콜백을 따로 설정, iOS 15이상 사용 가능, recordMatchedBlock을 이용해서 검색결과를 이용한 핸들러를 정의
        // 단일 실행으로 조회할때마다 실행되는 클로져
        queryOperation.recordMatchedBlock = { (returnRecordID, returnedResult) in
            switch returnedResult {
                case .success(let record):
                    guard let name = record["name"] as? String else { return }
                    let imageAsset = record["image"] as? CKAsset
                    let imageURL = imageAsset?.fileURL
                returnedItems.append(FruitModel(name: name, imageURL: imageURL, record: record))
                case .failure(let error):
                    print("Error recordMatchedBlock: \(error.localizedDescription)")
            }
        }
        
        // queryOperation.recordFetchedBlock = { (returnedRecord) in
        //     guard let name = returnedRecord["name"] as? String else { return }
        //     returnedItems.append(name)
        // }
        
        // result 콜백을 따로 설정, iOS 15이상 사용 가능, fetch가 완전히 끝났을 때 동작
         queryOperation.queryResultBlock = { [weak self] returnResult in
             switch returnResult {
                 case .success(let result):
                     DispatchQueue.main.async {
                         print("queryResultBlock result: \(String(describing: result))")
                         self?.fruits = returnedItems
                     }
                 case .failure(let error):
                    print("Error queryResultBlock: \(error.localizedDescription)")
             }
         }
        
        // queryOperation.queryCompletionBlock = { (returnedCursor, error) in
        //     print(returnedCursor)
        // }
        
        queryOperation.resultsLimit = 5 // 제힌을 둘 수도 있음, 하지만 최대 100개로 제한되어있음.
        addOperations(operation: queryOperation)
    }
    
    func addOperations(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func updateItem(fruit: FruitModel) {
        let record = fruit.record
        record["name"] = "New Name"
        saveItem(record: record)
    }
    
    func delete(_ offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let fruit = fruits[index]
        let record = fruit.record
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] returnID, error in
            DispatchQueue.main.async {
                self?.fruits.remove(at: index)
            }
        }
    }
}

struct CloudKitCrudPractice: View {
    
    @StateObject private var vm = CloudKitCrudPracticeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                headerView
                textField
                addButton
                
                List {
                    ForEach(vm.fruits, id: \.self) { fruit in
                        HStack {
                            Text(fruit.name)
                                .onTapGesture {
                                    vm.updateItem(fruit: fruit)
                                }
                            
                            if let url = fruit.imageURL,
                               let data = try? Data(contentsOf: url),
                               let image = UIImage(data: data) {
                               Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                    .onDelete(perform: vm.delete)
                }
                .listStyle(.plain)
            }
            .padding()
            .toolbar(.hidden)
        }
    }
}

struct CloudKitCrudPractice_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitCrudPractice()
    }
}

extension CloudKitCrudPractice {
    
    private var headerView: some View {
        Text("CloudKit CRUD")
            .font(.headline)
            .underline()
    }
    
    private var textField: some View {
        TextField("Add something here...", text: $vm.text)
            .frame(height: 55)
            .padding(.leading)
            .background(.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var addButton: some View {
        Button {
            vm.addButtonTapped()
        } label: {
            Text("Add")
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(.pink)
                .cornerRadius(10)
        }
    }
}
