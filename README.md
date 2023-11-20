# What is this?

This is a simple web service with one endpoint:

`POST /image`

which accepts raw image data associated with the key `image` in multiple forms (as a multipart form data request, as a JSON object with a Base64-encoded value, etc) and returns a JPEG image directly on success.

This is based on an original implementation baked into the iOS app written in 2016 or so that hasn't been meaningfully updated since. There's plenty of opportunity to improve this!

# How to run

Open the project in XCode.

# Sample Results

Sources images are in the `other/test` folder. Use the included Postman collection for convenience:

<img src="other/test/postman.png" width="50%" />

| # | Original | Extracted |
| -- | -- | -- |
| 1537 | <img src="other/test/IMG_1537.jpg" width="200" /> | <img src="other/test/IMG_1537_response.jpeg" width="200" /> |
| 1538 | <img src="other/test/IMG_1538.jpg" width="200" /> | <img src="other/test/IMG_1538_response.jpeg" width="200" /> |
| 1539 | <img src="other/test/IMG_1539.jpg" width="200" /> | <img src="other/test/IMG_1539_response.jpeg" width="200" /> |
| 1540 | <img src="other/test/IMG_1540.jpg" width="200" /> | <img src="other/test/IMG_1540_response.jpeg" width="200" /> |
| 1541 | <img src="other/test/IMG_1541.jpg" width="200" /> | `fail` |
| 1543 | <img src="other/test/IMG_1543.jpg" width="200" /> | <img src="other/test/IMG_1543_response.jpeg" width="200" /> |
| 1544 | <img src="other/test/IMG_1544.jpg" width="200" /> | <img src="other/test/IMG_1544_response.jpeg" width="200" /> |

