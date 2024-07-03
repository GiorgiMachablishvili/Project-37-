//
//  JobInfoStruct.swift
//  Project 37 გიორგი მაჩაბლიშვილი
//
//  Created by Gio's Mac on 02.07.24.
//

import UIKit

struct JobsResponse: Codable {
    let jobs: [Job]
}

struct Job: Codable {
    let jobTitle: String
    let companyName: String
    let companyLogo: String
    let jobIndustry: [String]
    let jobType: [String]
    let jobGeo: String
    let jobLevel: String
    let pubDate: String
}
