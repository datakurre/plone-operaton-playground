*** Settings ***
Library     requests


*** Variables ***
${uid}              7f0ee1dd7c5f4e23b1292bbc70714f30
${comment}


*** Test Cases ***
Publish
    VAR    ${BASE_URL}    http://localhost:8080/Plone
    VAR    &{HEADERS}     Accept=application/json    Content-Type=application/json
    VAR    @{AUTH}        admin    admin
    VAR    &{PAYLOAD}     comment=${comment}
    Log variables
    ${RESP}=  Get  ${BASE_URL}/resolveuid/${uid}  headers=${HEADERS}  auth=${{tuple(${AUTH})}}
    VAR    ${data}    ${RESP.json()}
    ${RESP}=  Post   ${data}[@id]/@workflow/publish
    ...       json=${PAYLOAD}
    ...       headers=${HEADERS}
    ...       auth=${{tuple(${AUTH})}}
    Should Be Equal As Integers    ${RESP.status_code}    200