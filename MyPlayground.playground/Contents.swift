let quiz = [
    "남도산": "ナムドサン",
    "김덕영": "キムトギョン",
    "사키야마 에리": "さきやまえり",
    "abc" : "dd"
]

print(Array(quiz.keys)[2])
print(type(of: Array(quiz.keys)[2]))

var str = String(Array(quiz.keys)[2])

print(quiz.index(forKey: str)!)

