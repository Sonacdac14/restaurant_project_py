*** Settings ***
Library     SeleniumLibrary
*** Variables ***

${header}    //div[contains(@class,'menu-product-header')]
${price}    //div[contains(@class,'menu-product-price')]
${image}    //img[contains(@class,'menu-product-image')]
${url}    https://online.kfc.co.in/menu
*** Test Cases ***
Restaurant_menu
    Open Browser    ${url}  chrome
    Maximize Browser Window
    Sleep    10
    ${total length}    Get Length    ${header}
    Log To Console    ${total length}
    
    FOR    ${i}    IN RANGE    1    ${total length}+1
        Log To Console    ${i}
        ${header_text}    Get Text    (//div[@class='menu-card-content']/div[contains(@class,'menu-product-header')])[${i}]
        Scroll Element Into View       ${header_text}
        #Wait Until Element Is Visible    ${header_text}
        Log To Console    ${header_text}
        ${price_text}    Get Text    (${price})[${i}]
        Log To Console    ${price_text}

    END







