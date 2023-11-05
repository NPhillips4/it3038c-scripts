import json 
import requests 

print('Please enter your zip code')
zip = input()

r = requests.get('http://api.openweathermap.org/data/2.5/weather?zip=%s,us&appid=c1b73a23d3dcca4643b775d589b1325b' % zip)
data=r.json()
print(data['weather'][0]['description'])