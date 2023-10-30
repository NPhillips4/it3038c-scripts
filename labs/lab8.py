import requests, re
from bs4 import BeautifulSoup

data = requests.get("https://limosineskateboards.com/products/cyrus-bennett-brain-collage").content
soup = BeautifulSoup(data, 'html.parser')
span = soup.find("h1", {"class":"product__title"})
title = span.text
span = soup.find("span", {"class":"price-item price-item--regular"})
price = span.text
print("%s has a price of %s" % (title, price))
