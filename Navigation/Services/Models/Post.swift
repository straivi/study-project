//
//  Post.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

struct Post {
    let author: String
    let description: String
    let likes: Int
    let views: Int
    let imageName: String
}

var postsList = [
    Post(author: "TJ",
         description: "Распознавание лиц на службе у силовиков — новая реальность для москвичей: теперь технологию применяют не только для поиска преступников, но и для преследования протестующих.",
         likes: 7,
         views: 2400,
         imageName: "first_post"),
    Post(author: "Хабр",
         description: "Как мы просто сократили объём входящего в дата-центр трафика на 70%",
         likes: 88,
         views: 16600,
         imageName: "second_post"),
    Post(author: "Академия яндекса",
         description: "Мы открыли приём заявок на летнюю стажировку в Яндексе ✨ Особый формат стажировки — Deep Dive в Яндекс.Маркете. Эта программа проходит в формате буткемпа: отличная возможность попробовать себя сразу в двух командах, чтобы понять, что вам ближе и интереснее.",
         likes: 30,
         views: 4000,
         imageName: "third_post"),
    Post(author: "Игромания",
         description: "Bethesda сообщила о смерти Роберта Альтмана, основателя и бессменного генерального компании ZeniMax Media. Ему было 74 года.",
         likes: 76,
         views: 10000,
         imageName: "fourth_post")
]
