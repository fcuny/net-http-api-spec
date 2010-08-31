# Net::HTTP::API::Spec

## SYNOPSIS

## DESCRIPTION

## Spec

### API information

  * api_base_url   : URL of the API base
  * api_format     : format of the API
  * api_format_mode: how the format information is sent to the API:
    * append      : the format will be added to the path (eg: /search.json)
    * content-type: the format will be set in the headers of the request (eg: Content-Type)

### API method declaration

  * path:           (required) path of the API method (start after the API base url, start with a /)
  * method:         (required) which HTTP method to use (GET/POST/PUT/DELETE)
  * description:    (optional) a description of what the method do
  * strict:         (optional) should the control of the arguments be strict (yes by default)
  * authentication: (optional) does this method require authentication ? (no by default)
  * expected:       (optional) list of possible HTTP code accepted for this request (eg: [200, 201])
  * params:         (optional) list of parameters that will be used for the request
  * params_in_url:  (optional) should the parameters of the request be sent in the URL instead of body (for POST and PUT request)
  * required:       (optional) list of required parameters
  * documetation:   (optional) documentation for this method

### example: GitHub

    {
      "declare" : {
        "api_base_url" : "http://github.com/api/v2/",
        "api_format_mode" : "content-type",
        "api_format" : "json"
      },
      "methods" : {
        "user_information" : {
           "params" : [
              "username",
              "format"
           ],
           "required" : [
              "username",
              "format"
           ],
           "path" : "/:format/user/show/:username",
           "method" : "GET"
        },
        "user_following" : {
           "params" : [
              "user"
           ],
           "required" : [
              "user"
           ],
           "path" : "/user/show/:user/followers",
           "method" : "GET"
        }
      }
    }

