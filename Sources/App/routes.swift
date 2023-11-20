import Vapor
import CoreImage

struct ImageRequest: Content {
    var image: Data
}

func routes(_ app: Application) throws {
    app.on(.POST, "image", body: .collect(maxSize: "100mb"), use: { request in
        let imageRequest = try request.content.decode(ImageRequest.self)
        let ciImage = try nonnull(CIImage(data: imageRequest.image))

        let context = CIContext()

        let newImage = try nonnull(ImageService().getCardShapedImage(orientation: .portrait, ciImage: ciImage))
        let cgImage = try nonnull(context.createCGImage(newImage, from: newImage.extent))

        let imageData = try nonnull(CFDataCreateMutable(nil, 0))
        let destination = try nonnull(CGImageDestinationCreateWithData(imageData as CFMutableData, kUTTypeJPEG, 1, nil))
        CGImageDestinationAddImage(destination, cgImage, nil)
        CGImageDestinationFinalize(destination)

        let response = Response()
        response.headers.contentType = .jpeg
        response.body = .init(buffer: ByteBuffer(data: imageData as Data))
        return response
    })
}
