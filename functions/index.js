const functions = require("firebase-functions");
const admin = require("firebase-admin");
const tf = require("@tensorflow/tfjs-node"); // TensorFlow.js Node.js için
const fs = require("fs");
const path = require("path");

admin.initializeApp();

const modelPath = path.join(__dirname, "face_model.tflite"); // Modelin yolu
let model;

(async () => {
  const modelBuffer = fs.readFileSync(modelPath);
  model = await tf.node.loadSavedModel(modelBuffer);
})();

exports.classifyImage = functions.https.onRequest(async (req, res) => {
  try {
    const imageBuffer = Buffer.from(req.body.image, "base64"); // Base64 formatında görüntü
    const tensor = tf.node.decodeImage(imageBuffer).expandDims(0); // Görüntüyü tensöre çevir
    const predictions = model.predict(tensor); // Tahmin yap
    const label = predictions.argMax(-1).dataSync()[0]; // Sınıf tahmini

    let result;
    switch (label) {
      case 0:
        result = "heart";
        break;
      case 1:
        result = "oblong"; 
        break;
      case 2:
        result = "oval";
        break;
      case 3:
        result = "round";
        break;
      case 4:
        result = "square";
        break;
      default:
        result = "Bilinmeyen";
    }
    res.status(200).send({ prediction: result });
  } catch (error) {
    console.error("Error during classification:", error);
    res.status(500).send({ error: "Classification failed" });
  }
});
