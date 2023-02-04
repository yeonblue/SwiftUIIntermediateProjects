//
//  CloudKitUtility.swift
//  Advanced
//
//  Created by yeonBlue on 2023/02/04.
//

import SwiftUI
import CloudKit
import Combine

protocol CloudKitableProtocol {
    var record: CKRecord { get }
    
    init?(record: CKRecord)
}

class CloudKitUtility {
    
    @frozen enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAcountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
        case iCloudApplicationNotGranted
        case iCloudCouldNotFetchRecrdID
        case iCloudCouldNotDiscoverUsername
    }
}

// MARK: - User Fuctions
extension CloudKitUtility {
    static func getCloudStatus() -> Future<Bool, Error> {
        Future { promise in
            CloudKitUtility.getCloudStatus { result in
                promise(result)
            }
        }
    }
    
    static func requestAplicationPermission() -> Future<Bool, Error> {
        Future { promise in
            CloudKitUtility.requestApplicationPermission { result in
                promise(result)
            }
        }
    }
    
    static func discoverUserIdentity() -> Future<String, Error> {
        Future { promise in
            discoverUserIdentity { result in
                promise(result)
            }
        }
    }
}

// MARK: - CRUD
extension CloudKitUtility {
    static func fetch<T: CloudKitableProtocol>(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultLimit: Int? = nil,
        completion: @escaping (_ items: [T]) -> Void) {
            
            // Create Operation
            let operation = createOperation(predicate: predicate,
                                            recordType: recordType,
                                            sortDescriptors: sortDescriptors,
                                            resultLimit: resultLimit)
            
            var returnedItems: [T] = []
            addRecordMatchedBlock(operation: operation) { fruit in
                returnedItems.append(fruit)
            }
            
            addQueryResultBlock(operation: operation) { finish in
                completion(returnedItems)
            }
            
            // Execute operation
            addOperation(operation: operation)
        }
    
    static func fetchUsingCombine<T: CloudKitableProtocol>(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultLimit: Int? = nil) -> Future<[T], Error> {
            Future { promise in
                fetch(predicate: predicate, recordType: recordType, sortDescriptors: sortDescriptors, resultLimit: resultLimit) { items in
                    promise(.success(items))
                }
            }
        }
    
    static func add<T: CloudKitableProtocol>(item: T, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        
        // Get Record
        let record = item.record
        
        // Save to CloutKit
        save(record: record, completion: completion)
    }
    
    static func save(record: CKRecord, completion: @escaping (Result<Bool, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}

// MARK: - Private
extension CloudKitUtility {
    
    static private func getCloudStatus(completion: @escaping (Result<Bool, Error>) -> Void) {
        CKContainer.default().accountStatus { status, error in
            switch status {
                case .couldNotDetermine:
                    completion(.failure(CloudKitError.iCloudAcountNotDetermined))
                case .available:
                    completion(.success(true))
                case .restricted:
                    completion(.failure(CloudKitError.iCloudAccountRestricted))
                case .noAccount:
                    completion(.failure(CloudKitError.iCloudAccountNotFound))
                default:
                    completion(.failure(CloudKitError.iCloudAccountUnknown))
            }
        }
    }
    
    static private func requestApplicationPermission(completion: @escaping (Result<Bool, Error>) -> Void) {
        CKContainer.default().requestApplicationPermission(.userDiscoverability) { status, error in
            if status == .granted {
                completion(.success(true))
            } else {
                completion(.failure(CloudKitError.iCloudApplicationNotGranted))
            }
        }
    }
    
    static private func fetchUserRecordID(completion: @escaping (Result<CKRecord.ID, Error>) -> Void) {
        CKContainer.default().fetchUserRecordID { returnID, error in
            if let id = returnID {
                completion(.success(id))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(CloudKitError.iCloudCouldNotFetchRecrdID))
            }
        }
    }
    
    static private func discoverUserIdentity(id: CKRecord.ID, completion: @escaping (Result<String, Error>) -> Void) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { returnIdentity, error in
            if let name = returnIdentity?.nameComponents?.givenName {
                completion(.success(name))
            } else {
                completion(.failure(CloudKitError.iCloudCouldNotDiscoverUsername))
            }
        }
    }
    
    static private func discoverUserIdentity(completion: @escaping (Result<String, Error>) -> Void) {
        fetchUserRecordID { result in
            switch result {
            case .success(let recordID):
                CloudKitUtility.discoverUserIdentity(id: recordID, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static private func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    static private func createOperation(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultLimit: Int? = nil) -> CKQueryOperation {
            let query = CKQuery(recordType: recordType, predicate: predicate)
            query.sortDescriptors = sortDescriptors
            
            let queryOperation = CKQueryOperation(query: query)
            if let resultLimit = resultLimit {
                queryOperation.resultsLimit = resultLimit
            }
            
            return queryOperation
        }
    
    /// 하나씩 fetch될 때마다 수행할 completion 동작 지정
    static private func addRecordMatchedBlock<T: CloudKitableProtocol>(operation: CKQueryOperation, completion: @escaping (_ item: T) -> Void) {
        operation.recordMatchedBlock = { recordID, result in
            switch result {
                case .success(let record):
                    guard let item = T(record: record) else { return }
                    completion(item)
                case .failure(_):
                    break
            }
        }
    }
    
    // operation이 끝났을 때 호출 completion
    static private func addQueryResultBlock(operation: CKQueryOperation, completion: @escaping (_ finish: Bool) -> Void) {
        operation.queryResultBlock = { result in
            completion(true)
        }
    }
}
