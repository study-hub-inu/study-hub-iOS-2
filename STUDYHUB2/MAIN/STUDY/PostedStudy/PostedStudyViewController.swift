//
//  PostedStudyViewController.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/10/30.
//

import UIKit

import SnapKit

final class PostedStudyViewController: NaviHelper, SendPostData {
  let detailPostDataManager = PostDetailInfoManager.shared
  func sendData(data: CreateStudyRequest) {
    print("11")
  }
  
  // 여기에 데이터가 들어오면 관련 UI에 데이터 넣어줌
  var postedDate: PostDetailData? {
    didSet {
      DispatchQueue.main.async {
        self.redrawUI()
      }
    }
  }
  
  var memberNumberCount: Int = 0 {
    didSet {
      memeberNumberCountLabel.text = "\(memberNumberCount)/30명"
      memeberNumberCountLabel.changeColor(label: memeberNumberCountLabel,
                                          wantToChange: memberNumberCount,
                                          color: .changeInfo)
    }
  }
  
  var fineCount: Int = 0 {
    didSet{
      fineCountLabel.text = "\(fineCount)원"
      fineCountLabel.changeColor(label: fineCountLabel,
                                 wantToChange: fineCount,
                                 color: .changeInfo)

      fineAmountLabel.text = "결석비 \(fineCount)원"
    }
  }
  
  var gender: String = "무관" {
    didSet {
      fixedGenderLabel.text = "\(gender)"
    }
  }
  
  // 작성일, 관련학과, 제목
  private lazy var postedDateLabel = createLabel(title: "2023-10-31",
                                                 textColor: .lightGray,
                                                 fontType: "Pretendard",
                                                 fontSize: 12)
  
  private lazy var postedMajorLabel = createLabel(title: " 세무회계학과 ",
                                                  textColor: .postedMajor,
                                                  fontType: "Pretendard",
                                                  fontSize: 14)
  
  private lazy var postedMajorStackView = createStackView(axis: .horizontal,
                                                          spacing: 10)
  
  private lazy var postedTitleLabel = createLabel(title: "전산세무 같이 준비해요",
                                                  textColor: .white,
                                                  fontType: "Pretendard",
                                                  fontSize: 20)
  
  private lazy var postedInfoStackView = createStackView(axis: .vertical, spacing: 10)
  
  // 팀원수 관련
  private lazy var memeberNumberLabel = createLabel(title: "인원수",
                                                    textColor: .lightGray,
                                                    fontType: "Pretendard",
                                                    fontSize: 12)
  private lazy var memberImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "MemberNumberImage")
    return imageView
  }()
  
  private lazy var memeberNumberCountLabel = createLabel(title: "1" + "/30명",
                                                         textColor: .lightGray,
                                                         fontType: "Pretendard",
                                                         fontSize: 16)
  private lazy var memberNumberStackView = createStackView(axis: .vertical,
                                                           spacing: 8)
  // 벌금 관련
  private lazy var fineLabel = createLabel(title: "벌금",
                                           textColor: .lightGray,
                                           fontType: "Pretendard",
                                           fontSize: 12)
  private lazy var fineImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "MoneyImage")
    
    return imageView
  }()
  
  private lazy var fineCountLabel = createLabel(title: "1000"+"원",
                                                textColor: .lightGray,
                                                fontType: "Pretendard",
                                                fontSize: 16)
  private lazy var fineStackView = createStackView(axis: .vertical,
                                                   spacing: 8)
  // 성별 관련
  private lazy var genderLabel = createLabel(title: "성별",
                                             textColor: .lightGray,
                                             fontType: "Pretendard",
                                             fontSize: 12)
  private lazy var genderImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "GenderImage")
    
    return imageView
  }()
  
  private lazy var fixedGenderLabel = createLabel(title: "여자",
                                                  textColor: .white,
                                                  fontType: "Pretendard",
                                                  fontSize: 16)
  private lazy var genderStackView = createStackView(axis: .vertical,
                                                     spacing: 8)
  
  private lazy var spaceView4 = UIView()
  private lazy var spaceView5 = UIView()
  
  private lazy var redesignCoreInfoStackView = createStackView(axis: .horizontal,
                                                               spacing: 10)
  // 팀원수, 벌금, 성별 들어감
  private lazy var coreInfoStackView = createStackView(axis: .horizontal,
                                                       spacing: 10)
  // 페이지 위에 정보 들어감
  private lazy var topInfoStackView = createStackView(axis: .vertical,
                                                      spacing: 12)
  private lazy var spaceView = UIView()
  
  // 소개, 소개내용 , 회색구분선
  private lazy var aboutStudyLabel = createLabel(title: "소개",
                                                 textColor: .black,
                                                 fontType: "Pretendard",
                                                 fontSize: 14)
  private lazy var aboutStudyDeatilLabel = createLabel(title: "스터디에 대해 알려주세요\n (운영 방법, 대면 여부,벌금,공부 인증 방법 등)",
                                                       textColor: .lightGray,
                                                       fontType: "Pretendard",
                                                       fontSize: 15)
  
  private lazy var aboutStudyStackView = createStackView(axis: .vertical,
                                                         spacing: 10)
  
  
  // 기간,벌금,대면여부, 관련학과
  private lazy var periodTitleLabel = createLabel(title: "기간",
                                                  textColor: .black,
                                                  fontType: "Pretendard",
                                                  fontSize: 14)
  private lazy var periodLabel = createLabel(title: "2023.9.12 ~ 2023.12.30",
                                             textColor: .lightGray,
                                             fontType: "Pretendard",
                                             fontSize: 14)
  
  private lazy var fineTitleLabel = createLabel(title: "벌금",
                                                textColor: .black,
                                                fontType: "Pretendard",
                                                fontSize: 14)
  private lazy var fineAmountLabel = createLabel(title: "결석비  " + "1000원",
                                                 textColor: .lightGray,
                                                 fontType: "Pretendard",
                                                 fontSize: 14)
  
  private lazy var meetTitleLabel = createLabel(title: "대면여부",
                                                textColor: .black,
                                                fontType: "Pretendard",
                                                fontSize: 14)
  private lazy var meetLabel = createLabel(title: "혼합",
                                           textColor: .lightGray,
                                           fontType: "Pretendard",
                                           fontSize: 14)
  
  private lazy var majorTitleLabel = createLabel(title: "관련학과",
                                                 textColor: .black,
                                                 fontType: "Pretendard",
                                                 fontSize: 14)
  private lazy var majorLabel = createLabel(title: " 세무회계학과 ",
                                            textColor: .lightGray,
                                            fontType: "Pretendard",
                                            fontSize: 14)
  private lazy var majorStackView = createStackView(axis: .horizontal,
                                                    spacing: 10)
  private lazy var detailInfoStackView = createStackView(axis: .vertical,
                                                         spacing: 10)
  private lazy var spaceView6 = UIView()
  private lazy var spaceView7 = UIView()
  private lazy var spaceView8 = UIView()
  
  private lazy var periodStackView = createStackView(axis: .horizontal,
                                                     spacing: 10)
  private lazy var fineInfoStackView = createStackView(axis: .horizontal,
                                                       spacing: 10)
  private lazy var meetStackView = createStackView(axis: .horizontal,
                                                   spacing: 10)
  
  private lazy var periodImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "CalenderImage")
    imageView.contentMode = .left
    imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    return imageView
  }()
  
  private lazy var meetImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "MixMeetImage")
    imageView.contentMode = .left
    imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    return imageView
  }()
  
  private lazy var smallFineImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "MoneyImage")
    imageView.contentMode = .left
    imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    return imageView
  }()
  // 작성자 정보
  private lazy var writerLabel = createLabel(title: "작성자",
                                             textColor: .black,
                                             fontType: "Pretendard",
                                             fontSize: 18)
  
  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 15
    imageView.image = UIImage(named: "ProfileAvatar")
    imageView.contentMode = .left
    imageView.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
    return imageView
  }()
  
  private lazy var writerMajorLabel = createLabel(title: "세무회계학과",
                                                  textColor: .gray,
                                                  fontType: "Pretendard",
                                                  fontSize: 14)
  
  private lazy var nickNameLabel = createLabel(title: "비어있음",
                                               textColor: .black,
                                               fontType: "Pretendard",
                                               fontSize: 16)
  // 학과, 닉네임 스택
  private lazy var writerInfoStackView = createStackView(axis: .vertical,
                                                         spacing: 1)
  // 학과 닉네임 이미지 스택
  private lazy var writerInfoWithImageStackView = createStackView(axis: .horizontal,
                                                                  spacing: 5)
  // 학과 닉네임 이미지 작성자 스택
  private lazy var totalWriterInfoStackView = createStackView(axis: .vertical,
                                                              spacing: 10)
  private lazy var spaceView1 = UIView()
  
  // 비슷한 게시글
  private lazy var similarPostLabel = createLabel(title: "이 글과 비슷한 스터디예요",
                                                  textColor: .black,
                                                  fontType: "Pretendard",
                                                  fontSize: 18)
  
  var dataSource: [String] = []
  
  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = 50 // cell사이의 간격 설정
    let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    view.backgroundColor = .white
    
    return view
  }()
  
  private lazy var similarPostStackView = createStackView(axis: .vertical,
                                                          spacing: 10)
  
  // 회색 라인 생성
  private lazy var createGrayDividerLine: (CGFloat) -> UIView = { size in
    let dividerLine = UIView()
    dividerLine.backgroundColor = .bg30
    dividerLine.heightAnchor.constraint(equalToConstant: size).isActive = true
    dividerLine.translatesAutoresizingMaskIntoConstraints = false
    return dividerLine
  }
  
  // 전체 요소를 담는 스택
  private lazy var pageStackView = createStackView(axis: .vertical,
                                                   spacing: 10)
  
  private lazy var scrollView: UIScrollView = UIScrollView()
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupDelegate()
    registerCell()
    
    navigationItemSetting()
    setUpLayout()
    makeUI()
    
  }
  
  // MARK: - setUpLayout
  func setUpLayout(){
    // 게시일, 관련학과, 제목
    let spaceView9 = UIView()
    let postedMajorData = [postedMajorLabel, spaceView9]
    for view in postedMajorData {
      postedMajorStackView.addArrangedSubview(view)
    }
    
    let postedInfoData = [postedDateLabel, postedMajorStackView, postedTitleLabel]
    for view in postedInfoData {
      postedInfoStackView.addArrangedSubview(view)
    }
    // 인원수
    memberNumberStackView.alignment = .center
    let memberNumberData = [memeberNumberLabel, memberImageView, memeberNumberCountLabel]
    for view in memberNumberData {
      memberNumberStackView.addArrangedSubview(view)
    }
    // 벌금
    fineStackView.alignment = .center
    let fineData = [fineLabel,fineImageView,fineCountLabel]
    for view in fineData {
      fineStackView.addArrangedSubview(view)
    }
    // 성별
    genderStackView.alignment = .center
    let genderData = [genderLabel, genderImageView, fixedGenderLabel]
    for view in genderData {
      genderStackView.addArrangedSubview(view)
    }
    
    let spaceView12 = UIView()
    let coreInfoData = [memberNumberStackView, fineStackView, genderStackView, spaceView12]
    for view in coreInfoData {
      coreInfoStackView.addArrangedSubview(view)
    }
    
    let redesignData = [spaceView4,coreInfoStackView,spaceView5]
    for view in redesignData {
      redesignCoreInfoStackView.addArrangedSubview(view)
    }
    
    let topInfoData = [postedInfoStackView, redesignCoreInfoStackView, spaceView]
    for view in topInfoData{
      topInfoStackView.addArrangedSubview(view)
    }
    
    // 소개
    let grayDividerLine1 = createGrayDividerLine(1.0)
    let aboutStudyData = [aboutStudyLabel, aboutStudyDeatilLabel, grayDividerLine1]
    for view in aboutStudyData {
      aboutStudyStackView.addArrangedSubview(view)
    }
    
    // 기간, 벌금, 대면여부, 관련학과
    let grayDividerLine2 = createGrayDividerLine(8.0)
    
    let periodData = [periodImageView, periodLabel, spaceView6]
    for view in periodData {
      periodStackView.addArrangedSubview(view)
    }
    
    let fineInfoData = [smallFineImageView, fineAmountLabel, spaceView7]
    for view in fineInfoData {
      fineInfoStackView.addArrangedSubview(view)
    }
    
    let meetData = [meetImageView, meetLabel, spaceView8]
    for view in meetData {
      meetStackView.addArrangedSubview(view)
    }
    
    majorLabel.backgroundColor = .bg30
    
    let spaceView10 = UIView()
    let majorData = [majorLabel, spaceView10]
    for view in majorData {
      majorStackView.addArrangedSubview(view)
    }
    
    let detailInfo = [periodTitleLabel, periodStackView,
                      fineTitleLabel, fineInfoStackView,
                      meetTitleLabel, meetStackView,
                      majorTitleLabel, majorStackView,
                      grayDividerLine2]
    
    for view in detailInfo {
      detailInfoStackView.addArrangedSubview(view)
    }
    
    // 작성자 정보
    let writerData = [writerMajorLabel, nickNameLabel]
    for view in writerData {
      writerInfoStackView.addArrangedSubview(view)
    }
    
    let writerDataWithImage = [profileImageView, writerInfoStackView, spaceView1]
    for view in writerDataWithImage {
      writerInfoWithImageStackView.addArrangedSubview(view)
    }
    
    let spaceView8 = UIView()
    let grayDividerLine3 = createGrayDividerLine(8.0)
    let totalWriterData = [writerLabel, writerInfoWithImageStackView,
                           spaceView8, grayDividerLine3]
    for view in totalWriterData {
      totalWriterInfoStackView.addArrangedSubview(view)
    }
    
    // 유사 스터디 추천
    let spaceView11 = UIView()
    let collectionView = [similarPostLabel,collectionView, spaceView11]
    for view in collectionView {
      similarPostStackView.addArrangedSubview(view)
    }
    
    // 전체 페이지
    let pageData = [topInfoStackView, aboutStudyStackView,
                    detailInfoStackView, totalWriterInfoStackView,
                    similarPostStackView]
    for view in pageData {
      pageStackView.addArrangedSubview(view)
    }
    
    scrollView.addSubview(pageStackView)
    
    view.addSubview(scrollView)
  }
  // MARK: - makeUI
  func makeUI(){
    coreInfoStackView.distribution = .fillProportionally
    coreInfoStackView.backgroundColor = .deepGray
    
    topInfoStackView.backgroundColor = .black
    
    postedMajorLabel.backgroundColor = .postedMajorBackGorund
    
    // 스터디 제목
    postedInfoStackView.layoutMargins = UIEdgeInsets(top: 50, left: 10, bottom: 0, right: 0)
    postedInfoStackView.isLayoutMarginsRelativeArrangement = true
    
    // 인원수 벌금 성별여부
    [
      periodStackView,
      fineInfoStackView,
      meetStackView,
      majorStackView
    ].forEach {
      $0.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
      $0.isLayoutMarginsRelativeArrangement = true
    }
 
    coreInfoStackView.spacing = 10  // 수평 여백 설정
    coreInfoStackView.layer.cornerRadius = 10
    coreInfoStackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
    coreInfoStackView.isLayoutMarginsRelativeArrangement = true
    
    redesignCoreInfoStackView.distribution = .fillProportionally
    
    spaceView.snp.makeConstraints { make in
      make.height.equalTo(20)
    }
    
    // 스터디 소개
    aboutStudyStackView.backgroundColor = .white
    aboutStudyDeatilLabel.numberOfLines = 0
    aboutStudyStackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 10)
    aboutStudyStackView.isLayoutMarginsRelativeArrangement = true
    
    // 기간 벌금 대면여부 관련학과
    detailInfoStackView.backgroundColor = .white
    detailInfoStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 10)
    detailInfoStackView.isLayoutMarginsRelativeArrangement = true
    
    // 작성자 정보
    writerInfoWithImageStackView.distribution = .fillProportionally
    
    totalWriterInfoStackView.backgroundColor = .white
    totalWriterInfoStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 10)
    totalWriterInfoStackView.isLayoutMarginsRelativeArrangement = true
    
    spaceView1.snp.makeConstraints { make in
      make.width.equalTo(200)
    }
    
    // 비슷한 게시글
    similarPostStackView.backgroundColor = .white
    similarPostStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    similarPostStackView.isLayoutMarginsRelativeArrangement = true
    
    collectionView.snp.makeConstraints { make in
      make.height.equalTo(171)
    }
    
    // pageStackView의 설정
    pageStackView.snp.makeConstraints { make in
      make.top.equalTo(scrollView.contentLayoutGuide)
      make.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
      make.width.equalTo(view.safeAreaLayoutGuide)
    }
    
    // scrollView의 설정
    scrollView.snp.makeConstraints { make in
      make.edges.equalTo(view)
    }
    
  }

  private func setupDelegate() {
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  private func registerCell() {
    collectionView.register(SimilarPostCell.self,
                            forCellWithReuseIdentifier: SimilarPostCell.id)
  }
  
  func redrawUI(){
    if let postDate = self.postedDate?.createdDate {
      self.postedDateLabel.text = "\(postDate[0]). \(postDate[1]). \(postDate[2])"
    }
    
    self.postedMajorLabel.text = self.convertMajor(self.postedDate?.major ?? "",
                                              isEnglish: false)
    self.postedTitleLabel.text = self.postedDate?.title
    self.memberNumberCount = self.postedDate?.remainingSeat ?? 0
    self.fineCount = self.postedDate?.penalty ?? 0
    
   
    self.gender = self.convertGender(gender: self.postedDate?.filteredGender ?? "무관")
    
    self.aboutStudyDeatilLabel.text = self.postedDate?.content
    
    guard let startDate = self.postedDate?.studyStartDate,
          let endDate = self.postedDate?.studyEndDate else { return }
    
    self.periodLabel.text = "\(startDate[0]). \(startDate[1]). \(startDate[2]) ~ \(endDate[0]). \(endDate[1]). \(endDate[2])"
    self.meetLabel.text = self.convertStudyWay(wayToStudy: self.postedDate?.studyWay ?? "혼합")
    self.majorLabel.text = self.convertMajor(self.postedDate?.major ?? "",
                                             isEnglish: false)
    self.writerMajorLabel.text = self.convertMajor(self.postedDate?.postedUser.major ?? "",
                                                   isEnglish: false)
    self.nickNameLabel.text = self.postedDate?.postedUser.nickname
  }
}
// MARK: - collectionView
extension PostedStudyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return postedDate?.relatedPost.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarPostCell.id,
                                                  for: indexPath)
    if let cell = cell as? SimilarPostCell {
      if indexPath.item < postedDate?.relatedPost.count ?? 0 {
        let data = postedDate?.relatedPost[indexPath.item]
        cell.model = data
      }
    }
    
    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    if let cell = collectionView.cellForItem(at: indexPath) as? SimilarPostCell {
      let postedVC = PostedStudyViewController()
      detailPostDataManager.getPostDetailData(postID: cell.postID ?? 0) {
        let cellData = self.detailPostDataManager.getPostDetailData()
        postedVC.postedDate = cellData
      }
      self.navigationController?.pushViewController(postedVC, animated: true)
    }
  }
  
}

extension PostedStudyViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 250, height: collectionView.frame.height)
  }
}
