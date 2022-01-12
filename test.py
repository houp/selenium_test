from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains


def parse():
    driver = webdriver.Chrome('./chromedriver.exe')
    driver.get("https://nofluffjobs.com/pl/job/remote-devops-engineer-shiji-poland-lo2gjfh8")
    button = driver.find_element(By.CLASS_NAME, "btn-accept-cookie")
    webdriver.ActionChains(driver).click(button).perform()
    driver.maximize_window()
    job_description = driver.find_element(By.TAG_NAME, "common-posting-description")
    print(job_description.text)
    driver.close()




