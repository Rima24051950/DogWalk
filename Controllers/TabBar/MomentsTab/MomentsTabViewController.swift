//
//  MomentsTabViewController.swift
//  DogWalk
//
//  Created by MacBook on 01.05.2026.
//
import UIKit


class MomentsTabViewController: UIViewController, UICollectionViewDelegate, WaterfallLayoutDelegate


{
    
    private let avatar: [AvatarModel] = [
        AvatarModel(name: "New", image: UIImage(named: "plus")),
        AvatarModel(name: "Chloe H.", image: UIImage(named: "chloe")),
        AvatarModel(name: "Charles G.", image: UIImage(named: "charles")),
        AvatarModel(name: "Kerry H.", image: UIImage(named: "kerry")),
        AvatarModel(name: "Diane S.", image: UIImage(named: "diane"))
    ]

  
    private let galleryItems: [GalleryItem] = [
        GalleryItem(image: UIImage(named: "Stiv"), height: 198),
        GalleryItem(image: UIImage(named: "Garry"), height: 256),
        GalleryItem(image: UIImage(named: "Mark"), height: 256),
        GalleryItem(image: UIImage(named: "Kary"), height: 198),
        GalleryItem(image: UIImage(named: "Mark"), height: 256),
        GalleryItem(image: UIImage(named: "Kary"), height: 198)
    ]

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    
    
  
    private lazy var galleryCollectionView: UICollectionView = {
        let layout = WaterfallLayout()
        layout.columns = 2
        layout.interItemSpacing = 15
        layout.lineSpacing = 19
        layout.delegate = self
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GalleryPhotoCell.self, forCellWithReuseIdentifier: GalleryPhotoCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    // MARK: - UI Elements (без изменений)
    private let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 7
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let pawsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.paws.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let wooDogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.wooDog.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let iconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Book a walk", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColor.primary
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentHorizontalAlignment = .left
        
       
        return button
    }()
    
    private let recentlyAdd: UILabel = {
        let label = UILabel()
        label.text = "Recently added"
        label.font = UIFont(name: "Poppins-Bold", size: 17)
        label.textColor = .textColors
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = creatlayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(StoryAvatarCell.self, forCellWithReuseIdentifier: StoryAvatarCell.identifier)
        cv.dataSource = self
        return cv
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(iconButton)
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(galleryCollectionView)
        
 
        view.addSubview(headerStackView)
        view.addSubview(recentlyAdd)
        view.addSubview(collectionView)
       
        view.bringSubviewToFront(iconButton)
        
        
        
           
        
        headerStackView.addArrangedSubview(pawsImageView)
        headerStackView.addArrangedSubview(wooDogImageView)
        galleryCollectionView.backgroundColor = .white
        
        setupConstraints()
        
        iconButton.removeTarget(nil, action: nil, for: .allEvents)
            iconButton.addTarget(self, action: #selector(bookWalkTapped), for: .touchUpInside)
        collectionView.delegate = self
    }
    
    private func creatlayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(64),
            heightDimension: .absolute(86)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(76),
            heightDimension: .absolute(86)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
        return UICollectionViewCompositionalLayout(section: section)
    }
    

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 62),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            pawsImageView.widthAnchor.constraint(equalToConstant: 40),
            pawsImageView.heightAnchor.constraint(equalToConstant: 40),
            wooDogImageView.widthAnchor.constraint(equalToConstant: 59),
            wooDogImageView.heightAnchor.constraint(equalToConstant: 36),
            
            iconButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 62),
            iconButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            iconButton.widthAnchor.constraint(equalToConstant: 103),
            iconButton.heightAnchor.constraint(equalToConstant: 41),
            //iconButton.centerYAnchor.constraint(equalTo: headerStackView.centerYAnchor),
            
            recentlyAdd.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            recentlyAdd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.widthAnchor.constraint(equalToConstant: 380),
            collectionView.heightAnchor.constraint(equalToConstant: 86),
            scrollView.topAnchor.constraint(equalTo: recentlyAdd.bottomAnchor, constant: 16),
                    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                    
         
            galleryCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    galleryCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    galleryCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                    galleryCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                    galleryCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            galleryCollectionView.heightAnchor.constraint( equalTo: view.heightAnchor, constant: 600)
       ])
    }
    
    @objc private func bookWalkTapped() {
        guard let nav = navigationController else {
            print(" ОШИБКА: нет navigationController!")
            return
        }
        
        let provilVC = ProfileViewController()
        provilVC.hidesBottomBarWhenPushed = true
        nav.pushViewController(provilVC, animated: true)
    }
}

// MARK: - DataSource
extension MomentsTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == galleryCollectionView {
            return galleryItems.count
        } else {
            return avatar.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == galleryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GalleryPhotoCell.identifier,
                for: indexPath
            ) as? GalleryPhotoCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: galleryItems[indexPath.item])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StoryAvatarCell.identifier,
                for: indexPath
            ) as? StoryAvatarCell else {
                return UICollectionViewCell()
            }
            let avatar = self.avatar[indexPath.item]
            let isNew = (indexPath.item == 0)
            cell.configure(with: avatar, isNew: isNew)
            return cell
        }
    }
}

// ✅ ПРАВИЛЬНЫЙ делегат для WaterfallLayout:
extension MomentsTabViewController {
    func collectionView(_ collectionView: UICollectionView,
                        layout: WaterfallLayout,
                        heightForItemAt indexPath: IndexPath) -> CGFloat {
        guard collectionView == galleryCollectionView else { return 86 }
        return galleryItems[indexPath.item].height
    }
}
