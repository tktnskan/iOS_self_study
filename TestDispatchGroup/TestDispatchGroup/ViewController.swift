//
//  ViewController.swift
//  TestDispatchGroup
//
//  Created by GJC03280 on 2021/11/08.
//

import UIKit

class ViewController: UIViewController {
    
    let labelTitle = UILabel()
    let labelDescription = UILabel()
    let imageView = UIImageView()
    let button: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        btn.setTitle("시작", for: .normal)
        btn.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var labelTitleCenterXConstraint: NSLayoutConstraint?
    var imageViewWidthConstraint: NSLayoutConstraint?
    var imageViewHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        
        view.addSubview(labelTitle)
        view.addSubview(labelDescription)
        view.addSubview(imageView)
        view.addSubview(button)
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(systemName: "heart")
        labelTitle.textAlignment = .center
        labelDescription.textAlignment = .center
        
        setContraintsForAnimation()
        
        NSLayoutConstraint.activate([
    
            labelTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelTitle.widthAnchor.constraint(equalToConstant: 200),
            labelTitle.heightAnchor.constraint(equalToConstant: 44),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
            
            labelDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            labelDescription.widthAnchor.constraint(equalToConstant: 200),
            labelDescription.heightAnchor.constraint(equalToConstant: 44),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 10),
        ])
    }
    
    func setContraintsForAnimation() {
        
        labelTitle.text = "이미지가 나옵니다."
        labelDescription.text = "애니메이션 시작"
        
        labelTitleCenterXConstraint = labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 500)
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 0)
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 0)
        labelTitleCenterXConstraint?.isActive = true
        imageViewWidthConstraint?.isActive = true
        imageViewHeightConstraint?.isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    @objc func startAnimation() {
        labelTitle.text = "이미지가 나옵니다."
        labelDescription.text = "애니메이션 시작"
        
        let group = DispatchGroup()
        
        group.enter()
        UIView.animate(withDuration: 1, animations: { [weak self] in
            guard let self = self else { return }
            self.labelTitleCenterXConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            self.labelDescription.text = "아직 이미지는 애니메이션중"
            group.leave()
        }
        
        group.enter()
        UIView.animate(withDuration: 3, animations: { [weak self] in
            guard let self = self else { return }
            self.imageViewHeightConstraint?.constant = 200
            self.imageViewWidthConstraint?.constant =  200
            self.view.layoutIfNeeded()
        }) { (_) in
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            self.labelDescription.text = "애니메이션 끝"
            self.labelTitle.text = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.labelTitleCenterXConstraint?.constant = 500
                self.imageViewHeightConstraint?.constant = 0
                self.imageViewWidthConstraint?.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
}

