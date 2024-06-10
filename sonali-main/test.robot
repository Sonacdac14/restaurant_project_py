*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     OperatingSystem
Library     String
Library     Collections

*** Variables ***
${header}           //div[contains(@class,'menu-product-header')]
${price}            //div[contains(@class,'menu-product-price')]
${image}            //div[@class='menu-product-image']/img
${url}              https://online.kfc.co.in/menu
${download_path}    ./images
${csv_file}         ./menu_items.csv

*** Test Cases ***
Restaurant_menu
    # Ensure the download directory exists
    Create Directory    ${download_path}

    # Create CSV file and write header row
    Create File    ${csv_file}    Item,Price,Image\n

    Open Browser    ${url}  chrome
    Maximize Browser Window
    Sleep    10
    ${total_length}    Get Element Count    ${header}
    Log To Console    ${total_length}

    FOR    ${i}    IN RANGE    1    ${total_length}+1
        Log To Console    ${i}
        ${header_text}    Get Text    (//div[@class='menu-card-content']/div[contains(@class,'menu-product-header')])[${i}]
        Log To Console    ${header_text}
        ${price_text}    Get Text    (${price})[${i}]
        Log To Console    ${price_text}

        ${image_element}    Get WebElement    (//img[contains(@src,'https://orderserv-kfc-assets.yum.com/')])[${i}]
        ${image_url}       Get Element Attribute    ${image_element}    src
        Log To Console     ${image_url}

        # Sanitize the header text to create a valid filename
        ${sanitized_header}    Evaluate    ''.join(e if e.isalnum() or e == '_' else '_' for e in '''${header_text}''')
        Log To Console    ${sanitized_header}
        ${image_file}          Set Variable    ${download_path}/${sanitized_header}.jpg

        # Download and save the image
        Download Image         ${image_url}    ${image_file}

        # Append item details to CSV
        Append To CSV          ${csv_file}    ${header_text}    ${price_text}    ${image_file}

    END
    Close Browser

*** Keywords ***
Download Image
    [Arguments]    ${url}    ${file_path}
    # Extract the base URL for session creation
    ${base_url}    Evaluate    '/'.join('''${url}'''.split('/')[:3])
    Create Session    my_session    ${base_url}    verify=False
    ${response}    GET On Session    my_session    ${url}
    Log To Console    Status Code: ${response.status_code}
    Should Be Equal As Numbers    ${response.status_code}    200
    Create Binary File    ${file_path}    ${response.content}

Append To CSV
    [Arguments]    ${file}    ${header_text}    ${price_text}    ${image_file}
    ${row}    Evaluate    '''${header_text}''','''${price_text}''','''${image_file}'''
    Append To File    ${file}    ${row}\n


