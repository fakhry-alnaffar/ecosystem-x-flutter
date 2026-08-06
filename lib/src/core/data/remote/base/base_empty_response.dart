/// Utility class for parsing API endpoints that return an empty body.
///
/// Pass [BaseEmptyResponse.fromJson] as the [OnParse] callback when calling
/// [RequestProcessor.processRequest] for fire-and-forget endpoints.
class BaseEmptyResponse {
  //ignore: prefer_constructors_over_static_methods
  static BaseEmptyResponse fromJson(_) => BaseEmptyResponse();
}
