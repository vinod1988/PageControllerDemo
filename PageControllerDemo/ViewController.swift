//
//  ViewController.swift
//  PageControllerDemo
//
//  Created by Vinod VIshwakarma on 24/12/2019.
//  Copyright © 2019 Aigen Tech http://www.aigen.tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate  {
    
    
    @IBOutlet var pageControl:UIPageControl!
    
    private var pageViewController: UIPageViewController!
    
    private lazy var viewControllers: [UIViewController] = {
        
        var viewControllers = [UIViewController]()
        
        let firstIntroViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier:"page1")
        
        let secondIntroViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier:"page2")
        
        let thirdIntroViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier:"page3")
        
        viewControllers.append(firstIntroViewController)
        viewControllers.append(secondIntroViewController)
        viewControllers.append(thirdIntroViewController)
        return viewControllers
    }()
    
    
    var currentIndex: Int?
    private var pendingIndex: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageControl.numberOfPages = viewControllers.count
        self.pageControl.currentPage = 0
        currentIndex = 0
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UIPageViewController {
            pageViewController = vc
            pageViewController.dataSource = self
            pageViewController.delegate = self
            pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        }
        
    }
  
    
    @IBAction func onPreviousAction(sender:UIButton) {
           
           if currentIndex! != 0  {
               let vc:[UIViewController] = [viewControllers[currentIndex!-1]]
                          pageViewController.setViewControllers(vc,
                                                                direction: .reverse,
                                                                animated: true,
                                                                completion: nil)
               currentIndex! -= 1
               pageControl.currentPage = currentIndex!
           } else {
              print("first page")
           }
       }
    
    
    
    @IBAction func onNextAction(sender:UIButton) {
        
        if  currentIndex! < (viewControllers.count - 1) {
            let vc:[UIViewController] = [viewControllers[currentIndex!+1]]
                       pageViewController.setViewControllers(vc,
                                                             direction: .forward,
                                                             animated: true,
                                                             completion: nil)
            currentIndex! += 1
            pageControl.currentPage = currentIndex!
        } else {
           print("last page")
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
        let currentIndex = viewControllers.firstIndex(of: viewController)!
              if currentIndex == 0 {
                  return nil
              }
              let previousIndex = abs((currentIndex - 1) % viewControllers.count)
              return viewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
         let currentIndex = viewControllers.firstIndex(of: viewController)!
               if currentIndex == viewControllers.count-1 {
                   return nil
               }
               let nextIndex = abs((currentIndex + 1) % viewControllers.count)
               return viewControllers[nextIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = viewControllers.firstIndex(of: pendingViewControllers.first!)
       }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
           if completed {
               currentIndex = pendingIndex
               if let index = currentIndex {
                   pageControl.currentPage = index
               }
           }
       }
    
    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//          return viewControllers.count
//      }
//
//      func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//
//        print()
//          return 0
//      }
//
    
    
}


