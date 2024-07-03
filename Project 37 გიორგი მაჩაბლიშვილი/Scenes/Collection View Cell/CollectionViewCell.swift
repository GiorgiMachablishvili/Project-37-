//
//  CollectionViewCell.swift
//  Project 37 გიორგი მაჩაბლიშვილი
//
//  Created by Gio's Mac on 02.07.24.
//

import UIKit
import SnapKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    private lazy var jobTitleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .systemFont(ofSize: 25)
        view.textAlignment = .left
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var companyNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .systemFont(ofSize: 20)
        view.textAlignment = .left
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var companyLogoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    private lazy var jobIndustryLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .systemFont(ofSize: 20)
        view.textAlignment = .left
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var jobTypeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .systemFont(ofSize: 20)
        view.textAlignment = .left
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var jobGeoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .systemFont(ofSize: 20)
        view.textAlignment = .left
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var jobLevelLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .systemFont(ofSize: 20)
        view.textAlignment = .left
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var pubDateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .systemFont(ofSize: 20)
        view.textAlignment = .left
        view.numberOfLines = 1
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(jobTitleLabel)
        addSubview(companyNameLabel)
        addSubview(companyLogoImageView)
        addSubview(jobIndustryLabel)
        addSubview(jobTypeLabel)
        addSubview(jobGeoLabel)
        addSubview(jobLevelLabel)
        addSubview(pubDateLabel)
    }
    
    func setupConstraints() {
        companyLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(20)
            make.leading.equalTo(snp.leading).offset(20)
            make.width.height.equalTo(50)
        }
        
        jobTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(companyLogoImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(jobTitleLabel.snp.bottom).offset(5)
            make.left.equalTo(companyLogoImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        jobIndustryLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(5)
            make.left.equalTo(companyLogoImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        jobTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(jobIndustryLabel.snp.bottom).offset(5)
            make.left.equalTo(companyLogoImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        jobGeoLabel.snp.makeConstraints { make in
            make.top.equalTo(jobTypeLabel.snp.bottom).offset(5)
            make.left.equalTo(companyLogoImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        jobLevelLabel.snp.makeConstraints { make in
            make.top.equalTo(jobGeoLabel.snp.bottom).offset(5)
            make.left.equalTo(companyLogoImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        pubDateLabel.snp.makeConstraints { make in
            make.top.equalTo(jobLevelLabel.snp.bottom).offset(5)
            make.left.equalTo(companyLogoImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func configure(with data: Job) {
        jobTitleLabel.text = data.jobTitle
        companyNameLabel.text = data.companyName
        if let url = URL(string: data.companyLogo) {
                    companyLogoImageView.kf.setImage(with: url)
                }
        jobIndustryLabel.text = data.jobIndustry.first ?? ""
        jobTypeLabel.text = data.jobType.first ?? ""
        jobGeoLabel.text = data.jobGeo
        jobLevelLabel.text = data.jobLevel
        pubDateLabel.text = data.pubDate
    }
}
