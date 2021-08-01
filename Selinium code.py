# -*- coding: utf-8 -*-
"""
Created on Wed Apr  7 23:32:15 2021

@author: DELL

"""


pip install selenium
pip install webdriver_manager
import os
import selenium
from selenium import webdriver
import time
import io
import requests
from webdriver_manager.chrome import ChromeDriverManager
from selenium.common.exceptions import ElementClickInterceptedException
from selenium.webdriver.common.action_chains import ActionChains
import pandas as pd
from easygui import filesavebox
from selenium.webdriver.common.keys import Keys

driver = webdriver.Chrome('D://chromedriver.exe')
search_url="https://twitter.com/login"
driver.get(search_url)
email = driver.find_element_by_name('session[username_or_email]')
email.send_keys('tracysiamintern@gmail.com')  # enter your email id used as username
password = driver.find_element_by_name('session[password]')
password.send_keys('Unagi123#',Keys.ENTER)  #enter your twitter password

search_url="https://twitter.com/explore"
driver.get(search_url)

search = driver.find_element_by_tag_name('input')
#search.send_keys(Keys.CONTROL + "a")
#search.send_keys(Keys.DELETE)
search.send_keys('(Opentowork OR OpenToWork OR opentowork) until:2020-09-30 since:2020-09-01',Keys.ENTER)

body = driver.find_element_by_tag_name('body')
temp = pd.DataFrame()
tweets = list()
for _ in range(100): # need to optimize the number of itrations needed
    t = driver.find_elements_by_css_selector('.r-bnwqim.r-qvutc0')
    tweets.extend([i.text for i in t])
    body.send_keys(Keys.PAGE_DOWN)
    time.sleep(3) # need to optimize the time for wait for load

temp['tweets'] = tweets
data = pd.DataFrame()
data['tweets']=temp['tweets'].unique()
data.to_csv(filesavebox())

driver.quit()

