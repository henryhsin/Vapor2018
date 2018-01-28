import App
/// We have isolated all of our App's logic into
/// the App module because it makes our app
/// more testable.
///
/// In general, the executable portion of our App
/// shouldn't include much more code than is presented
/// here.
///
/// We simply initialize our Droplet, optionally
/// passing in values if necessary
/// Then, we pass it to our App's setup function
/// this should setup all the routes and special
/// features of our app
///
/// .run() runs the Droplet's commands, 
/// if no command is given, it will default to "serve"
let config = try Config()
try config.setup()

let drop = try Droplet(config)
try drop.setup()
drop.get("helloWorld"){_ in
    var json = JSON()
    try json.set("message", [
        "whoPost" : "Hsin",
        "gender" : "Male",
        "text" : "Hello World"
        ])
    return json
}

drop.get("hello", "there") { _ in
    var json = JSON()
    try json.set("message", [
        "whoPost" : "Hsin",
        "gender" : "Male",
        "text" : "Hello World"
        ])
    return json
}


//下面這兩種自帶參數到url的方式
//效果都會相同
drop.get("hello", Int.parameter) { req in
    var json = JSON()
    let num = try req.parameters.next(Int.self)
    try json.set("message", [
        "whoPost" : "Hsin",
        "gender" : "Male",
        "text" : "Hello World",
        "num" : num
        ])
    return json
}

drop.get("hello", ":num") { req in
    
    guard let num = req.parameters["num"]?.int else {
        throw Abort.badRequest
    }
    var json = JSON()
    try json.set("message", [
        "whoPost" : "Hsin",
        "gender" : "Male",
        "text" : "Hello World",
        "num" : num
        ])
    return json
}

//////////////////////////////////////

drop.post("whoPost") { request in
    
    
    let name: String = request.data["name"]?.string ?? "GG"
    var json = JSON()
    try json.set("message", [
        "whoPost" : name,
        "gender" : "Male",
        "text" : "Hello World",
        "num" : 0
        ])
    return json
}




try drop.run()



