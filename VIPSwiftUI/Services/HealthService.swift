//
//  HealthRecordService.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 6/7/2566 BE.
//

import Foundation
import CoreData

enum HealthRecordError: Error {
    case creationFailed
    case fetchFailed
    case updateFailed
    case deletionFailed
}

protocol HealthServiceProtocol {
    
    @discardableResult
    func createHealthRecord(
        id: UUID,
        value: Double,
        createdDate: Date,
        type: HealthRecordType
    ) -> Result<HealthRecord, HealthRecordError>
    
    func fetchHealthRecords() -> Result<[HealthRecord], HealthRecordError>
    
    func fetchHealthRecords(
        ofType type: HealthRecordType
    ) -> Result<[HealthRecord], HealthRecordError>
    
    @discardableResult
    func updateHealthRecord(
        record: HealthRecord,
        value: Double,
        createdDate: Date,
        type: HealthRecordType
    ) -> Result<HealthRecord, HealthRecordError>
    
    @discardableResult
    func deleteHealthRecord(record: HealthRecord) -> Result<Void, HealthRecordError>
}

extension QueryService: HealthServiceProtocol {
    // CREATE
    func createHealthRecord(
        id: UUID,
        value: Double,
        createdDate: Date,
        type: HealthRecordType
    ) -> Result<HealthRecord, HealthRecordError> {
        let newRecord = NSEntityDescription.insertNewObject(forEntityName: "HealthRecord", into: context) as? HealthRecord
        newRecord?.id = id
        newRecord?.value = value
        newRecord?.createdDate = createdDate
        newRecord?.type = type.rawValue

        do {
            try context.save()
            return .success(newRecord!)
        } catch {
            print("Failed saving")
            return .failure(.creationFailed)
        }
    }
    
    
    // READ
    func fetchHealthRecords() -> Result<[HealthRecord], HealthRecordError> {
        let request = NSFetchRequest<HealthRecord>(entityName: "HealthRecord")
        
        do {
            let result = try context.fetch(request)
            return .success(result)
        } catch {
            print("Failed fetching")
            return .failure(.fetchFailed)
        }
    }
    
    // READ with condition
    func fetchHealthRecords(
        ofType type: HealthRecordType
    ) -> Result<[HealthRecord], HealthRecordError> {
        let request = NSFetchRequest<HealthRecord>(entityName: "HealthRecord")
        request.predicate = NSPredicate(format: "type == %@", type.rawValue as CVarArg)
        
        do {
            let result = try context.fetch(request)
            return .success(result)
        } catch {
            print("Failed fetching")
            return .failure(.fetchFailed)
        }
    }
    
    // UPDATE
    func updateHealthRecord(record: HealthRecord, value: Double, createdDate: Date, type: HealthRecordType) -> Result<HealthRecord, HealthRecordError> {
        record.value = value
        record.createdDate = createdDate
        record.type = type.rawValue
        
        do {
            try context.save()
            return .success(record)
        } catch {
            print("Failed saving")
            return .failure(.updateFailed)
        }
    }
    
    // DELETE
    func deleteHealthRecord(record: HealthRecord) -> Result<Void, HealthRecordError> {
        context.delete(record)
        
        do {
               try context.save()
               return .success(())
           } catch {
               print("Failed saving")
               return .failure(.deletionFailed)
           }
    }
}
