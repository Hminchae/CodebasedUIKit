//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/7/24.
//

import Foundation

struct Tamagotchi {
    let face: String
    let name: String
    let description: String?
    let serialNum: Int?
}

struct TamagotchiSet {
    static let tamagotchiSet: [Tamagotchi] = [
        Tamagotchi(face: "1-6", name: "따끔따끔 다마고치", description: "저는 따끔따끔 다마고치입니당 키는 50mm, 몸무게는 비밀이에요. 성격은 까칠한 estj입니다. 그냥 냅둬도 잘 자라는 편입니다!", serialNum: 1),
        Tamagotchi(face: "2-6", name: "방실방실 다마고치", description: "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니다~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!", serialNum: 2),
        Tamagotchi(face: "3-6", name: "반짝반짝 다마고치", description: "저는 반짝반짝 다마고치입니당✨ 반짝이는걸 조아해요✨ 성격은 반짝반짝한 편이고 관심을 많이 받아야 잘 자란답니당", serialNum: 3),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
        Tamagotchi(face: "noImage", name: "준비중이에요", description: nil, serialNum: nil),
    ]
}

struct TamagotchiSay {
    var userName: String?
    
    var sentence: [String] {
        return [
            "코드 리뷰 좀 해주세요, \(userName ?? "대장")님!",
            "\(userName ?? "대장")님, 버그 좀 잡아주세요!",
            "그 커피는 제가 마실게요, \(userName ?? "대장")님!",
            "\(userName ?? "대장")님, 저랑 코딩 좀 해요~",
            "API가 또 말썽이에요, \(userName ?? "대장")님!",
            "제 컴파일 좀 도와주세요, \(userName ?? "대장")님!",
            "저도 그 스프린트 회의 참석하고 싶어요, \(userName ?? "대장")님!",
            "재택 근무하면 저랑 더 놀 수 있어요, \(userName ?? "대장")님!",
            "테스트 케이스 추가 좀 해주세요, \(userName ?? "대장")님!",
            "다음 프로젝트 아이디어 생각해봤어요, \(userName ?? "대장")님!",
            "코드가 너무 깔끔해요, \(userName ?? "대장")님!",
            "배포 전에 저도 체크해보고 싶어요, \(userName ?? "대장")님!",
            "버전 관리 좀 해주세요, \(userName ?? "대장")님!",
            "리팩토링은 언제 하나요, \(userName ?? "대장")님?",
            "스택 오버플로에서 해답 찾으셨나요, \(userName ?? "대장")님?",
            "이 기능에 버그가 있어요, \(userName ?? "대장")님!",
            "커밋 메시지 좀 더 자세히 적어주세요, \(userName ?? "대장")님!",
            "제 알고리즘 좀 최적화 해주세요, \(userName ?? "대장")님!",
            "유닛 테스트가 실패했어요, \(userName ?? "대장")님!",
            "데드라인이 얼마 안 남았어요, \(userName ?? "대장")님!"
        ]
    }
}
