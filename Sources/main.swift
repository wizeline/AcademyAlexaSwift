import Kitura
import SwiftyJSON
import HeliumLogger

HeliumLogger.use()
registry()

let alexa = AlexaRouter()

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8080, with: alexa.router)

// Start the Kitura runloop (this call never returns)
Kitura.run()


