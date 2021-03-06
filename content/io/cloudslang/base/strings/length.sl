#   (c) Copyright 2015-2016 Hewlett-Packard Enterprise Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
########################################################################################################################
#!!
#! @description: Appends text to string.
#!
#! @input origin_string: Optional - string - Example: "good"
#!
#! @output length: length of string
#!
#! @result SUCCESS: always
#!!#
########################################################################################################################

namespace: io.cloudslang.base.strings

operation:
  name: length

  inputs:
    - origin_string

  python_action:
    script: |
      length = len(origin_string)

  outputs:
    - length: ${ str(length) }

  results:
    - SUCCESS
