xml.Response {
  xml.Gather(:action => "/main-twilio") {
    xml.Say "Welcome to Phone Interviewer. Please press 1 for a general question."
  }
}