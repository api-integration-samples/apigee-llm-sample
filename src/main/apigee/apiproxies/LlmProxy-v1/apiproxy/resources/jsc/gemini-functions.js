var questionResponse = convertResponse(JSON.parse(response.content));

context.setVariable("response.content", JSON.stringify({
  "answer": questionResponse.text,
  "requestTokenLength": questionResponse.requestTokenLength,
  "responseTokenLength": questionResponse.responseTokenLength
}));

context.setVariable("llm.requestTokenLength", questionResponse.requestTokenLength);
context.setVariable("llm.responseTokenLength", questionResponse.responseTokenLength);

function convertResponse(dataResponseObject) {
  var result = {text: "", requestTokenLength: 0, responseTokenLength: 0};

  for (i = 0; i < dataResponseObject.length; i++) {
    if (dataResponseObject[i]["candidates"][0]["content"] && dataResponseObject[i]["candidates"][0]["content"]["parts"] && dataResponseObject[i]["candidates"][0]["content"]["parts"].length > 0)
      result.text += dataResponseObject[i]["candidates"][0]["content"]["parts"][0]["text"];

    if (dataResponseObject[i]["usageMetadata"]) {
      result.requestTokenLength = dataResponseObject[i]["usageMetadata"]["promptTokenCount"];
      result.responseTokenLength = dataResponseObject[i]["usageMetadata"]["candidatesTokenCount"];
    }
  }

  return result;
}