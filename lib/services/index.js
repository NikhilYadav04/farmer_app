import express from "express";
import multer from "multer";
import cors from "cors";
import { Client } from "@gradio/client";
import fs from "fs";

const app = express();
const port = 5000;

app.use(cors());
app.use(express.json());

app.get("/", async (req, res) => {
  res.send(
    "Welcome To Plant detections server. It is deployed on render, so sometimes it can take more than 50 seconds to start"
  );
});

// Multer setup for file uploads
const upload = multer({ dest: "uploads/" });

const gradioClient = await Client.connect(
  "rudra-16/leaf-classification-gradio"
);

const class_names = [
  "Aloevera",
  "Amla",
  "Amruthaballi",
  "Arali",
  "Astma_weed",
  "Badipala",
  "Balloon_Vine",
  "Bamboo",
  "Beans",
  "Betel",
  "Bhrami",
  "Bringaraja",
  "Caricature",
  "Castor",
  "Catharanthus",
  "Chakte",
  "Chilly",
  "Citron lime (herelikai)",
  "Coffee",
  "Common rue(naagdalli)",
  "Coriender",
  "Curry",
  "Doddpathre",
  "Drumstick",
  "Ekka",
  "Eucalyptus",
  "Ganigale",
  "Ganike",
  "Gasagase",
  "Ginger",
  "Globe Amarnath",
  "Guava",
  "Henna",
  "Hibiscus",
  "Honge",
  "Insulin",
  "Jackfruit",
  "Jasmine",
  "Kambajala",
  "Kasambruga",
  "Kohlrabi",
  "Lantana",
  "Lemon",
  "Lemongrass",
  "Malabar_Nut",
  "Malabar_Spinach",
  "Mango",
  "Marigold",
  "Mint",
  "Neem",
  "Nelavembu",
  "Nerale",
  "Nooni",
  "Onion",
  "Padri",
  "Palak(Spinach)",
  "Papaya",
  "Parijatha",
  "Pea",
  "Pepper",
  "Pomoegranate",
  "Pumpkin",
  "Raddish",
  "Rose",
  "Sampige",
  "Sapota",
  "Seethaashoka",
  "Seethapala",
  "Spinach1",
  "Tamarind",
  "Taro",
  "Tecoma",
  "Thumbe",
  "Tomato",
  "Tulsi",
  "Turmeric",
  "ashoka",
  "camphor",
  "kamakasturi",
  "kepala",
];

app.post("/predict", upload.single("file"), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: "No file uploaded" });
    }

    console.log(req.file);

    const filePath = req.file.path;
    const fileBlob = fs.readFileSync(filePath);

    //* call api
    const result = await gradioClient.predict("/predict", { file: fileBlob });

    const predictionArray = await result.data[0]["prediction"][0];

    //* array with value and index
    const withIndices = predictionArray.map((value, index) => ({
      value,
      index,
    }));

    //* sort in descending order
    const sorted = withIndices.sort((a, b) => b.value - a.value);

    //* Get top 5 indices and values
    const top5 = sorted.slice(0, 5).map((item) => ({
      index: item.index,
      value: item.value,
    }));

    const plant_array = top5.map((value) => class_names[value.index]);

    fs.unlinkSync(filePath);

    res.status(200).send({
      plant_name: plant_array[0],
    });
  } catch (error) {
    console.error("Detailed error:", error);
    res
      .status(500)
      .json({ error: "Error processing file", details: error.message });
  }
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
