//
//  Photo.swift
//  PhotoSlideshow
//
//  Created by Masanori.KANEKO on 2015/08/25.
//  Copyright (c) 2015年 Masanori.KANEKO. All rights reserved.
//

import Foundation
import CoreData

class Photo: NSManagedObject {

    @NSManaged var order: NSInteger
    @NSManaged var image: NSData
    @NSManaged var memo: String

}
