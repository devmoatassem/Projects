import firebase_admin
from firebase_admin import credentials, storage
from firebase_admin import messaging
import os
import cv2
import time
import pyttsx3

# Initialize Firebase SDK
cred = credentials.Certificate('cheating-detector-2e34d-firebase-adminsdk-m32u4-b45b1f4ed3.json')
firebase_admin.initialize_app(cred, {
    'storageBucket': 'cheating-detector-2e34d.appspot.com'
})

# engine = pyttsx3.init()
# engine.setProperty('rate', 150)   # Set the speaking rate (words per minute)
# engine.setProperty('volume', 1)

#initialize bucket

bucket = storage.bucket()


#Function to save images

# capC=cv2.VideoCapture(0)
# for i in range(2):
#     time.sleep(1)
#     ret,img=capC.read()
#     path='images/Cheating'+str(i)+'.jpg'
#     cv2.imwrite('images/Cheating'+str(i)+'.jpg',img)
# capC.release()

#Upload files

folder_path = "images"

files = os.listdir(folder_path)

for file in files:
    if file.endswith(".jpg") or file.endswith(".png"): # upload only image files
        file_path = os.path.join(folder_path, file)
        blob = bucket.blob(file)
        blob.upload_from_filename(file_path)
        print(files)
        print(file_path)
        print('File {} uploaded to {}.'.format(file_path,file))



# engine.say("Surrounding Images Uploaded Successfully")
# engine.runAndWait()




# Define notification payload
notification = messaging.Notification(
    title='Cheating Detected',
    body='Click on the notification to see the cheater',
    image="https://static.vecteezy.com/system/resources/thumbnails/007/637/364/small_2x/no-smartphone-black-silhouette-ban-icon-telephone-cellphone-forbidden-pictogram-no-use-mobile-phone-red-stop-symbol-not-allowed-smart-phone-sign-cellphone-prohibited-isolated-illustration-vector.jpg"
)

# Define message payload
message = messaging.Message(
    notification=notification,
    topic='cheating',
)

# Send message
response = messaging.send(message)

# Print message ID
print('Successfully sent cheating notification to teacher:', response)
# engine.say("Successfully sent notification")
# engine.runAndWait()