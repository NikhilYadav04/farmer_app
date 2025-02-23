class Strings {
  Strings._();

//* for splash screen
  static const skipText = "Skip";
  static const continueText = "Continue";

//* prompts
  static String promptMedicine(String plant) {
    return "Provide 4 medicinal uses of ${plant} as a list of maps, where each map has two keys: 'title' (the name of a disease or health condition) and 'content' (a brief description of how ${plant} can be used to help treat or prevent that condition). Respond with only the list, without any additional words or lines.";
  }

  static String promptStatus(String plant) {
    return "Generate a list of four strings, each containing a detailed response of at least 50 words on ${plant} in India. Address the following aspects: (1) conservation status, (2) major threats, (3) conservation efforts, and (4) ecological significance. Each response should be comprehensive, well-structured, and concise. Ensure the output consists only of the list of strings, without any additional words, formatting, or explanations.";
  }
}
