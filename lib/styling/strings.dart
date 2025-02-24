class Strings {
  Strings._();

//* for splash screen
  static const skipText = "Skip";
  static const continueText = "Continue";

//* prompts
  static String promptMedicine(String plant) {
    return "Provide 4 medicinal uses of ${plant} as a list of maps, where each map has two keys: 'title' (the name of a disease or health condition) and 'content' (Describe in 1-2 lines how ${plant} can help treat or prevent that condition in 10-20 words). Respond with only the list, without any additional words or lines.";
  }

  static String promptStatus(String plant) {
    return "Generate a JSON array containing exactly four strings, each addressing a specific aspect of ${plant} in India. The four aspects are: (1) Conservation Status – its IUCN status or national classification, (2) Major Threats – key challenges affecting its survival, (3) Conservation Efforts – measures taken for its protection, and (4) Ecological Significance – its role in the ecosystem. Each string must be concise and 20-30 words. The output should be strictly a JSON array with four strings, without any extra formatting, explanations, or additional text.";
  }
}
