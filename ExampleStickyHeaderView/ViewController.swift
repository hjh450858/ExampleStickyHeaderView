//
//  ViewController.swift
//  ExampleStickyHeaderView
//
//  Created by 황재현 on 3/7/24.
//

import UIKit
import SnapKit
import RxSwift
import Then




class ViewController: UIViewController {
    /// 스크롤뷰
    var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    /// 스택뷰
    var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    let disposeBag = DisposeBag()
    /// 더미뷰1
    let dummy1View = UIView().then {
        $0.backgroundColor = .red
    }
    /// 더미뷰2
    let dummy2View = UIView().then {
        $0.backgroundColor = .orange
    }
    /// 더미뷰3
    let dummy3View = UIView().then {
        $0.backgroundColor = .yellow
    }
    /// 더미뷰4
    let dummy4View = UIView().then {
        $0.backgroundColor = .green
    }
    /// 더미뷰5
    let dummy5View = UIView().then {
        $0.backgroundColor = .blue
    }
    /// 더미뷰6
    let dummy6View = UIView().then {
        $0.backgroundColor = .brown
    }
    /// 더미뷰7
    let dummy7View = UIView().then {
        $0.backgroundColor = .purple
    }
    /// 첫번째 뷰 높이
    var firstViewHeight: CGFloat = 240
    /// 뷰 높이 최소값
    var minTopViewHeight: CGFloat = 44
    
    /// 상단 고정 뷰
    var stickyHaederView = UIView().then {
        $0.backgroundColor = .orange
        // 상단 고정 뷰 초반에는 숨기기
        $0.isHidden = true
        // 상단 고정 뷰 맨 위로 설정
        $0.layer.zPosition = 1
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    /// UI 구현
    func configureUI() {
        print("configureUI()")
        
        view.addSubview(stickyHaederView)
        
        stickyHaederView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(minTopViewHeight)
        }
        
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
        }
        
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        stackView.addArrangedSubview(dummy1View)
        stackView.addArrangedSubview(dummy2View)
        stackView.addArrangedSubview(dummy3View)
        stackView.addArrangedSubview(dummy4View)
        stackView.addArrangedSubview(dummy5View)
        stackView.addArrangedSubview(dummy6View)
        stackView.addArrangedSubview(dummy7View)
        
        dummy1View.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(firstViewHeight)
        }
        dummy2View.snp.makeConstraints { make in
            make.top.equalTo(dummy1View.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(minTopViewHeight)
        }
        dummy3View.snp.makeConstraints { make in
            make.top.equalTo(dummy2View.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
        }
        dummy4View.snp.makeConstraints { make in
            make.top.equalTo(dummy3View.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
        }
        dummy5View.snp.makeConstraints { make in
            make.top.equalTo(dummy4View.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
        }
        dummy6View.snp.makeConstraints { make in
            make.top.equalTo(dummy5View.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
        }
        dummy7View.snp.makeConstraints { make in
            make.top.equalTo(dummy6View.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
            make.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤 위치
        let position = scrollView.contentOffset.y
        
        /*
         TODO: 'position'값이 'firstViewHeight'보다 커지면
                커지면 'stickyHeaderView' 숨김 해제
                아니면 'stickyHeaderView' 숨김
         */
        
        if position > firstViewHeight {
            print("over")
            stickyHaederView.isHidden = false
        } else {
            print("not over")
            stickyHaederView.isHidden = true
        }
    }
}
