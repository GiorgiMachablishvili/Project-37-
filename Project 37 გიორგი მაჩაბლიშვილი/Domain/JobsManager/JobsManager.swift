//
//  JobsManager.swift
//  Project 37 გიორგი მაჩაბლიშვილი
//
//  Created by Gio's Mac on 03.07.24.
//

import UIKit

class JobsManager {
    private var jobInfo: [Job] = []
    
    //Append new note
    func appendNewNote(note: Job) {
        jobInfo.append(note)
    }
    
    //Returns notes
    func getJobInfo() -> [Job] {
        return jobInfo
    }
    
    // Set job info
    func setJobInfo(_ jobs: [Job]) {
        jobInfo = jobs
    }
    
    //Returns notes count
    func jobInfoCount() -> Int {
        return jobInfo.count
    }
    
    //Save Notes to File Manager
    func saveNotes() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let notesURL = documentsDirectory?.appendingPathComponent("jobs.json") else {
            return
        }
        
        do {
            let jsonData = try JSONEncoder().encode(jobInfo)
            fileManager.createFile(atPath: notesURL.path, contents: jsonData)
        } catch {
            dump(error)
        }
    }
    
    //Read note data
    func loadNotes() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let notesURL = documentsDirectory?.appendingPathComponent("jobs.json") else {
            return
        }
        
        let path = notesURL.path
        
        if fileManager.fileExists(atPath: path) {
            do {
                guard let jsonData = fileManager.contents(atPath: path) else {
                    return
                }
                jobInfo = try JSONDecoder().decode([Job].self, from: jsonData)
            } catch {
                dump(error)
            }
        } else {
            print("not exist")
        }
    }
}



