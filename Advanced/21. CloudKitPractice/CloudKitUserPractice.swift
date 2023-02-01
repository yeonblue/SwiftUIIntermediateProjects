//
//  CloudKitUserPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/19.
//

// CloudKit
// Public Database: 앱을 사용하는 모든 사용자간 공유 가능
// Private Database: 앱을 사용하는 한 사용자와 그 계정간 공유 가능, 아니면 FamilyShare

import SwiftUI
import CloudKit

class CloudKitUserPracticeViewModel: ObservableObject {
    
    @Published var permissionStatus: Bool = false
    @Published var isSignedIntoiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
    }
    
    private func getiCloudStatus() {
        
        // iCloud에 로그인 여부를 알 수 있음
        CKContainer.default().accountStatus { [weak self] status, error in
            DispatchQueue.main.async {
                switch status {
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAcountNotDetermined.localizedDescription
                case .available:
                    self?.isSignedIntoiCloud = true
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.localizedDescription
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.localizedDescription
                case .temporarilyUnavailable:
                    break
                @unknown default:
                    self?.error = CloudKitError.iCloudAccountUnknown.localizedDescription
                }
            }
        }
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission(.userDiscoverability) { [weak self] permission, error in
            DispatchQueue.main.async {
                if  permission == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    func fetchiCloudUserRecordID() {
        
        // 현재 사용자의 RecordID를 fetch
        CKContainer.default().fetchUserRecordID { [weak self] id, error in
            if let id = id, let self = self {
                self.discoveriCloudUser(id: id)
            }
        }
    }
    
    // email, phone번호로도 가능하지만, Record의 id로 검색
    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] identity, error in
            DispatchQueue.main.async {
                
                // 보통 givenName은 존재하므로, middleName등은 nil이 올 수 있음
                if let name = identity?.nameComponents?.givenName {
                    self?.userName = name
                }
                
                // print(identity?.lookupInfo?.emailAddress) recordID로 검색했기에 recordID는 볼 수 있음
                // print(identity?.lookupInfo?.phoneNumber) 하지만 email과 phone번호는 nil로 내려옴
                // email로 찾았으면 email은 볼 수 있음
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAcountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
}

struct CloudKitUserPractice: View {
    
    @StateObject private var vm = CloudKitUserPracticeViewModel()
    
    var body: some View {
        VStack {
            Text("Is Signed In: \(vm.isSignedIntoiCloud.description.uppercased())")
            Text(vm.error)
            Text("Permission: \(vm.permissionStatus.description.uppercased())")
            Text("Name: \(vm.userName)")
        }
    }
}

struct CloudKitUserPractice_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitUserPractice()
    }
}
