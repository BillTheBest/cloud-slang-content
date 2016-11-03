#   (c) Copyright 2016 Hewlett-Packard Enterprise Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
########################################################################################################################
#!!
#! @description: Performs an Amazon Web Services Elastic Compute Cloud (EC2) command to list the instances within a cloud
#!               region with advance filtering support. If value for input filter is not supplied than that filter is ignored.
#!
#! @input endpoint: optional - Endpoint to which first request will be sent - Default: 'https://ec2.amazonaws.com'
#! @input identity: Amazon Access Key ID
#! @input credential: Amazon Secret Access Key that corresponds to the Amazon Access Key ID
#! @input proxy_host: optional - proxy server used to access the provider services
#! @input proxy_port: optional - proxy server port used to access the provider services - Default: '8080'
#! @input proxy_username: optional - proxy server user name.
#!                        Default: ""
#! @input proxy_password: optional - proxy server password associated with the <proxyUsername>
#!                        input value.
#!                        Default: ""
#! @input headers: optional - string containing the headers to use for the request separated
#!                 by new line (CRLF). The header name-value pair will be separated by ":".
#!                 Format: Conforming with HTTP standard for headers (RFC 2616)
#!                 Examples: "Accept:text/plain"
#!                 Default: ""
#! @input query_params: optional - string containing query parameters that will be appended to
#!                      the URL. The names and the values must not be URL encoded because if
#!                      they are encoded then a double encoded will occur. The separator between
#!                      name-value pairs is "&" symbol. The query name will be separated from
#!                      query value by "=".
#!                      Examples: "parameterName1=parameterValue1&parameterName2=parameterValue2"
#!                      Default: ""
#! @input delimiter: optional - delimiter that will be used
#!                   Default: ','
#! @input version: Version of the web service to made the call against it.
#!                 Example: "2016-09-15"
#!                 Default: "2016-09-15"
#! @input delimiter: optional - Delimiter that will be used.
#! @input filter_names_string: optional - String that contains one or more values that represents filters for the search.
#!                             For a complete list of valid filters see: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html
#!                             Example: "instance-type,block-device-mapping.status,block-device-mapping.delete-on-termination"
#!                             Default: ""
#! @input filter_values_string: optional - String that contains one or more values that represents filters values.
#!                              For a complete list of valid filters see: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html
#!                              Example of filters values for the above <filterNamesString> input: "m1.small|m1.large,attached,true"
#!                              Note that "m1.small|m1.large" represents values for "instance-type" and are separated
#!                              by the enforced "|" symbol
#!                              Default (describes all your instances): ""
#! @input instance_ids_string: optional - String that contains one or more values that represents instance IDs.
#!                             Example: "i-12345678,i-abcdef12,i-12ab34cd"
#!                             Default: ""
#! @input max_results: optional - The maximum number of results to return in a single call. To retrieve the
#!                     remaining results, make another call with the returned NextToken value. This value can
#!                     be between 5 and 1000. You cannot specify this parameter and the instance IDs parameter
#!                     or tag filters in the same call.
#!                     Default: ""
#! @input next_token: optional - The token to use to retrieve the next page of results. This value is null when
#!                    there are no more results to return.
#!                    Default: ""
#!
#! @output return_result: contains the exception in case of failure, success message otherwise
#! @output return_code: '0' if operation was successfully executed, '-1' otherwise
#! @output exception: exception if there was an error when executing, empty otherwise
#!
#! @result SUCCESS: the list with existing servers (instances) was successfully retrieved
#! @result FAILURE: an error occurred when trying to retrieve servers (instances) list
#!!#
####################################################
namespace: io.cloudslang.amazon.aws.ec2.instances

operation:
  name: describe_instances

  inputs:
    - endpoint:
        default: 'https://ec2.amazonaws.com'
        required: false
    - identity
    - credential:
        sensitive: true
    - proxy_host:
        required: false
    - proxyHost:
        default: ${get("proxy_host", "")}
        required: false
        private: true
    - proxy_port:
        default: "8080"
        required: false
    - proxyPort:
        default: ${get("proxy_port", "")}
        private: true
        required: false
    - proxy_username:
        required: false
    - proxyUsername:
        default: ${get("proxy_username", "")}
        private: true
        required: false
    - proxy_password:
        required: false
        sensitive: true
    - proxyPassword:
        default: ${get("proxy_password", "")}
        private: true
        required: false
        sensitive: true
    - headers:
        required: false
    - query_params:
        required: false
    - queryParams:
        default: ${get("query_params", "")}
        private: true
        required: false
    - version:
        default: '2016-09-15'
        required: false
    - delimiter:
        default: ','
        required: false
    - filter_names_string:
        required: false
    - filterNamesString:
        default: ${get("filter_names_string", "")}
        private: true
        required: false
    - filter_values_string:
        required: false
    - filterValuesString:
        default: ${get("filter_values_string", "")}
        private: true
        required: false
    - instance_ids_string:
        required: false
    - instanceIdsString:
        default: ${get("instance_ids_string", "")}
        private: true
        required: false
    - max_results:
        required: false
    - maxResults:
        default: ${get("max_results", "")}
        private: true
        required: false
    - next_token:
        required: false
    - nextToken:
        default: ${get("next_token", "")}
        private: true
        required: false

  java_action:
    gav: 'io.cloudslang.content:cs-amazon:1.0.4'
    class_name: io.cloudslang.content.amazon.actions.instances.DescribeInstancesAction
    method_name: execute

  outputs:
    - return_result: ${returnResult}
    - return_code: ${returnCode}
    - exception: ${get("exception", "")}

  results:
    - SUCCESS: ${returnCode == '0'}
    - FAILURE