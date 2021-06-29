//
//  ComposeViewController.swift
//  MemoApp
//
//  Created by Kim Duk Young on 2021/06/22.
//

import UIKit

class ComposeViewController: UIViewController {
    // 네이게이션 뷰 컨트롤러가 관리하는 첫번째
    
    @IBOutlet weak var memoTextView: UITextView!
    
    
    var editTarget : Memo?
    // 보기화면에서 저장한 내용 여기다 저장
    var originalMemoContent : String?
    
    
    // 키보드가 글을 가리는 것을 방지
    var willShowToken : NSObjectProtocol?
    var willHideToken : NSObjectProtocol?
    
    // 화면 제거되는 시점에 옵저버도 해지시킴
    deinit {
        if let token = willShowToken{
            NotificationCenter.default.removeObserver(token)
        }
        
        if let token = willHideToken{
            NotificationCenter.default.removeObserver(token)

        }
    }
    
    
    var num:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 메모가 없다면 새 메모, 있다면 메모 편집창
        if let memo = editTarget{
            navigationItem.title = "Memo edit"
            memoTextView.text = memo.content
            originalMemoContent = memo.content
        } else {
            //MARK: 이 부분이 새 메모 를 new memo로 바꿈 이 부분 수정
            num = self.updateCharacterCount()
            navigationItem.title = "New memo " + String(num)
            memoTextView.text = ""
            
        }
        // Do any additional setup after loading the view.
        memoTextView.delegate = self
        
        // 키보드 높이 조절을 위한 옵저버 추가해줌
        willShowToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in
            // 키보드 높이 만큼 추가, 유동적으로 높이 구해야함
            guard let strongSelf = self else {return}
            
            if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
                NSValue{
                // height 에 키보드 높이 저장됨.
                let height = frame.cgRectValue.height
                print(height)
                
                var inset = strongSelf.memoTextView.contentInset
                // bottom 을 고정시킴
                inset.bottom = height
                strongSelf.memoTextView.contentInset = inset
                
                inset = strongSelf.memoTextView.scrollIndicatorInsets
                inset.bottom = height
                strongSelf.memoTextView.scrollIndicatorInsets = inset
            }
        })
        
        willHideToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            
            guard let strongSelf = self else {return}
            
            // 현재 inset을 변수에 저장 후 0으로 바꿈
            var inset = strongSelf.memoTextView.contentInset
            inset.bottom = 0
            strongSelf.memoTextView.contentInset = inset
            
            inset = strongSelf.memoTextView.scrollIndicatorInsets
            inset.bottom = 0
            strongSelf.memoTextView.scrollIndicatorInsets = inset
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        // 자동으로 키보드가 나오게 해줌 first responder
        memoTextView.becomeFirstResponder()
        
        navigationController?.presentationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        
        memoTextView.resignFirstResponder()
        navigationController?.presentationController?.delegate = nil

    }
    
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
     
        //MARK: 아래 이거 뭐지? 잘못 붙힌듯..
//        navigationController?.presentationController?.delegate = nil
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
        print("save clicked!")
        guard let memoTextView = memoTextView.text, memoTextView.count > 0 else{
            alert(message: "메모를 입력하세요")
            return
        }
//        Memo.dummyList.append(newMemo)
//        let newMemo = Memo(content: memoTextView)
        // 위에는 하드타입한 경우 호출
        // 아래는 DB에서 호출
        // TODO: [abc]
// MARK: - 밑에가 달라지는 지 확인!! 두번 저장되서 커멘트처리
//        DataManager.shared.addNewMemo(memoTextView)
        
        
        if let target = editTarget{
            print("editTarget IF NOTI")
            target.content = memoTextView
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: ComposeViewController.memoDidChange, object: nil)

        } else {
            print("editTarget ELSE NOTI")
            DataManager.shared.addNewMemo(memoTextView)
            NotificationCenter.default.post(name: ComposeViewController.newMemoDidInserted, object: nil)
            
        }

        // notification to close save
        dismiss(animated: true, completion: nil )
    }

    
    func updateCharacterCount() -> Int{
        let descriptionCount = self.memoTextView.text.count

//        self.navigationItem.text = "\((0) + descriptionCount)/500"
        print("updateCharacterCount")
        print(descriptionCount)
        return descriptionCount
    }
}

extension ComposeViewController: UITextViewDelegate{
    // MARK: 이 부분은 텍스트가 편집 될 때 반복적으로 추가된다.
    //      이 부분을 수정해서 텍스트 글자 수 받아오면 될듯
    func textViewDidChange(_ textView: UITextView) {
        if let original = originalMemoContent, let edit = textView.text{
            // 21강 6분 ios 13 버전 핸들 파트 없음
            isModalInPresentation = original != edit
            // bool flag임 풀다운으로 닫기 전에 취소해줌. IOS 13 이상에서만 사용 가능
            // 오리지날과 에딧이 다르다면 이 변수가 True를 갖게 됨

        }
    }
}


//isModalInPresentation 가 트루인 상태에서 유저가 풀 다운하게 되면 이 함수가 호출됨
extension ComposeViewController: UIAdaptivePresentationControllerDelegate{
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        // 풀 다운 불가능하도록 만듦.
        
        //여기서 경고창 만듦 ->
        let alert = UIAlertController(title: "알림", message: "편집한 내용을 삭제 할까요?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default){
            [weak self] (action) in
            self?.saveClicked(action)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel){
            [weak self] (action) in
            self?.cancelClicked(action)
        }
        alert.addAction(cancelAction)
        
        present(alert,animated: true,completion: nil)

    }
}

// notification 생성
extension ComposeViewController{
    static let newMemoDidInserted = Notification.Name(rawValue: "NewMemoDidInserted")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}

