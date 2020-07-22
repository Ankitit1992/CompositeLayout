//
//  ViewController.swift
//  CompostionCollectionLayout
//
//  Created by Ankit Tiwari on 21/07/20.
//  Copyright © 2020 Ankit Tiwari. All rights reserved.
//

import UIKit

enum Section:CaseIterable {
    case one
    case two
    case three
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var dataSource : UICollectionViewDiffableDataSource <Section, MyModel> = {
        return UICollectionViewDiffableDataSource<Section, MyModel>(collectionView: collectionView) { (collectionview, indexPath, myModel) -> UICollectionViewCell? in
            let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "ComPositeCVCell", for: indexPath)
            cell.backgroundColor = myModel.color
            return cell
        }
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.setCollectionViewLayout(makeDiffLayout1(), animated: true)
        collectionView.dataSource = dataSource
        createItem()
      //  createItemForSection()
    }
    
    func createItemForSection() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, MyModel>()
            snapShot.appendSections(Section.allCases)
            snapShot.appendItems([MyModel(.cyan)], toSection: .one)
        
            snapShot.appendItems([MyModel(.green), MyModel(.gray)], toSection: .one)
            snapShot.appendItems([MyModel(.red), MyModel(.blue)], toSection: .two)
            snapShot.appendItems([MyModel(.darkText), MyModel(.systemPink)], toSection: .two)
          
                   snapShot.appendItems([MyModel(.green), MyModel(.gray)], toSection: .three)
                   snapShot.appendItems([MyModel(.red), MyModel(.blue)], toSection: .three)
                   snapShot.appendItems([MyModel(.darkText), MyModel(.systemPink)], toSection: .three)
           
                       snapShot.appendItems([MyModel(.cyan)], toSection: .three)
                   
            snapShot.appendItems([MyModel(.systemTeal), MyModel(.systemGray2), MyModel(.systemRed)], toSection: .two)
            dataSource.apply(snapShot)
    }
    func createItem () {
        var snapShot = NSDiffableDataSourceSnapshot<Section, MyModel>()
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems([MyModel(.cyan)], toSection: .one)
    
        snapShot.appendItems([MyModel(.green), MyModel(.gray)], toSection: .one)
        snapShot.appendItems([MyModel(.red), MyModel(.blue)], toSection: .one)
        snapShot.appendItems([MyModel(.darkText), MyModel(.systemPink)], toSection: .one)
      
               snapShot.appendItems([MyModel(.green), MyModel(.gray)], toSection: .one)
               snapShot.appendItems([MyModel(.red), MyModel(.blue)], toSection: .one)
               snapShot.appendItems([MyModel(.darkText), MyModel(.systemPink)], toSection: .one)
       
                   snapShot.appendItems([MyModel(.cyan)], toSection: .one)
               
        snapShot.appendItems([MyModel(.systemTeal), MyModel(.systemGray2), MyModel(.systemRed)], toSection: .one)
        dataSource.apply(snapShot)
     
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0), heightDimension: NSCollectionLayoutDimension.absolute(44)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(5.0),  heightDimension: .absolute(50))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }
   
    private func createLayout() -> UICollectionViewLayout {
           let sectionProvider = { (sectionIndex: Int,
               layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
               let contentSize = layoutEnvironment.container.effectiveContentSize
               let columns = contentSize.width > 800 ? 3 : 2
               let spacing = CGFloat(10)
               let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(1.0))
               let item = NSCollectionLayoutItem(layoutSize: itemSize)
               let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(32))
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
               group.interItemSpacing = .fixed(spacing)

               let section = NSCollectionLayoutSection(group: group)
               section.interGroupSpacing = spacing
               section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

               return section
           }

           let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
           return layout
       }
   
    
    func makeDiffLayout () -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section, layoutEnvoirment) -> NSCollectionLayoutSection? in
            var coloumnes = 1
            switch section {
            case 0:
                coloumnes = 1
            case 1:
                coloumnes = 3
            case 2:
                coloumnes = 5
            default:
                coloumnes = 3
            }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
             item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let groupHeight = coloumnes == 1 ?
                NSCollectionLayoutDimension.absolute(120) :
                NSCollectionLayoutDimension.fractionalHeight(0.2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
            heightDimension: groupHeight)
            
            
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: coloumnes)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                return section
            
            
        }
        return layout
    }
    
    
    func makeDiffLayout1() -> UICollectionViewLayout {
        let fullPhotoItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3)))

        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
          top: 2,
          leading: 2,
          bottom: 2,
          trailing: 2)
        
        let mainItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalHeight(1.0)))

        mainItem.contentInsets = NSDirectionalEdgeInsets(
          top: 2,
          leading: 2,
          bottom: 2,
          trailing: 2)

        // 2
        let pairItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.2)))

        pairItem.contentInsets = NSDirectionalEdgeInsets(
          top: 2,
          leading: 2,
          bottom: 2,
          trailing: 2)

        let trailingGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)),
          subitem: pairItem,
          count: 2)

        // 1
        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(4/9)),
          subitems: [mainItem, trailingGroup])
        
        let tripletItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)))

        tripletItem.contentInsets = NSDirectionalEdgeInsets(
          top: 2,
          leading: 2,
          bottom: 2,
          trailing: 2)

        let tripletGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/9)),
          subitems: [tripletItem, tripletItem, tripletItem])

        
        let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(4/9)),
        subitems: [trailingGroup, mainItem])
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(16/9)),
          subitems: [
            fullPhotoItem,
            mainWithPairGroup,
            tripletGroup,
            mainWithPairReversedGroup
          ]
        )

        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
   

}




struct MyModel : Hashable {
    var identfier = UUID()
    var color : UIColor
    init(_ color:UIColor) {
        self.color = color
        
    }
}
