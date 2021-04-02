# Importing libraries
from keras.models import Sequential
from keras.layers import Conv2D
from keras.layers import MaxPooling2D
from keras.layers import Flatten
from keras.layers import Dense

import keras
import tensorflow as tf

# Building the CNN
classifier = Sequential()
classifier.add(Conv2D(1, (3,1), input_shape = (4009, 122, 1), activation = 'tanh'))
classifier.add(MaxPooling2D(pool_size = (3, 1)))
classifier.add(Conv2D(1, (3, 1), strides=(3, 1), activation = 'tanh'))
classifier.add(MaxPooling2D(pool_size = (3, 1)))
classifier.add(Flatten())
classifier.add(Dense(units = 100, activation = 'tanh',kernel_initializer='he_uniform'))
classifier.add(Dense(units = 26, activation = 'softmax'))

# Compiling the CNN
classifier.compile(optimizer = "adam", loss = 'categorical_crossentropy', metrics = ['accuracy'])


# Fitting the CNN to the images

from keras.preprocessing.image import ImageDataGenerator

train_datagen = ImageDataGenerator(rescale = 1./255)

test_datagen = ImageDataGenerator(rescale = 1./255)

training_set = train_datagen.flow_from_directory('~/Desktop/CNN_part_II/Datasets/training_set',
                                                 target_size = (4009, 122),
                                                 batch_size = 50,
                                                 class_mode = 'categorical',
                                                #class_mode = 'binary',
                                                 color_mode='grayscale',
                                                 shuffle=True)

test_set = test_datagen.flow_from_directory('~/Desktop/CNN_part_II/Datasets/test_set',
                                            target_size = (4009, 122),
                                            batch_size = 50,
                                            class_mode = 'categorical',
                                            #class_mode = 'binary',
                                            color_mode='grayscale',
                                            shuffle=False)

classifier.fit(training_set,
               steps_per_epoch = int(208000/50),
               epochs = 10,
               validation_data = test_set,
               validation_steps = int(52000/50))

import pandas as pd
import seaborn as sn
import matplotlib.pyplot as plt
import numpy as np

import sklearn.metrics as metrics
from sklearn.metrics import confusion_matrix as cm

batch_size = 50

test_set2=test_set

test_set2.reset()
Y_pred = classifier.predict_generator(test_set2, steps = 52000 // batch_size)
y_pred = np.argmax(Y_pred, axis=-1)

matrix = cm(test_set2.classes, y_pred)
print(matrix)

data = pd.DataFrame({'Model1': matrix[:, 0],'Model10': matrix[:, 1],'Model11': matrix[:, 2],'Model12': matrix[:, 3],'Model13': matrix[:, 4],'Model14': matrix[:, 5],'Model15': matrix[:, 6],'Model16': matrix[:, 7],'Model17': matrix[:, 8],'Model18': matrix[:, 9],'Model19': matrix[:, 10],'Model2': matrix[:, 11],'Model20': matrix[:, 12],'Model21': matrix[:, 13],'Model22': matrix[:, 14],'Model23': matrix[:, 15],'Model24': matrix[:, 16],'Model25': matrix[:, 17],'Model26': matrix[:, 18],'Model3': matrix[:, 19],'Model4': matrix[:, 20],'Model5': matrix[:, 21],'Model6': matrix[:, 22],'Model7': matrix[:, 23],'Model8': matrix[:, 24],'Model9': matrix[:, 25]})
data.index = ['Model1','Model10','Model11','Model12','Model13','Model14','Model15','Model16','Model17','Model18','Model19','Model2','Model20','Model21','Model22','Model23','Model24','Model25','Model26','Model3','Model4','Model5','Model6','Model7','Model8','Model9']
data.to_csv('~/Desktop/CNN_part_II/Confusion_matrix.csv')

folder_path = '~/Desktop/CNN_part_II/Observed'
os.chdir(folder_path)
files = glob.glob('*png')

for img in files:
	test_image = tf.keras.preprocessing.image.load_img(img, target_size = (4009, 122),color_mode='grayscale')
	test_image = image.img_to_array(test_image)
	test_image = np.expand_dims(test_image, axis = 0)
	test_image = np.vstack([test_image])
	result = classifier.predict(test_image)
	result2 = classifier.predict_proba(test_image)
	if result[0][0] == 1:
		prediction = 'Model1'
	elif result[0][1] == 1:
		prediction = 'Model10'
	elif result[0][2] == 1:
		prediction = 'Model11'
	elif result[0][3] == 1:
		prediction = 'Model12'
	elif result[0][4] == 1:
		prediction = 'Model13'
	elif result[0][5] == 1:
		prediction = 'Model14'
	elif result[0][6] == 1:
		prediction = 'Model15'
	elif result[0][7] == 1:
		prediction = 'Model16'
	elif result[0][8] == 1:
		prediction = 'Model17'
	elif result[0][9] == 1:
		prediction = 'Model18'
	elif result[0][10] == 1:
		prediction = 'Model19'
	elif result[0][11] == 1:
		prediction = 'Model2'
	elif result[0][12] == 1:
		prediction = 'Model20'
	elif result[0][13] == 1:
		prediction = 'Model21'
	elif result[0][14] == 1:
		prediction = 'Model22'
	elif result[0][15] == 1:
		prediction = 'Model23'
	elif result[0][16] == 1:
		prediction = 'Model24'
	elif result[0][17] == 1:
		prediction = 'Model25'
	elif result[0][18] == 1:
		prediction = 'Model26'
	elif result[0][19] == 1:
		prediction = 'Model3'
	elif result[0][20] == 1:
		prediction = 'Model4'
	elif result[0][21] == 1:
		prediction = 'Model5'
	elif result[0][22] == 1:
		prediction = 'Model6'
	elif result[0][23] == 1:
		prediction = 'Model7'
	elif result[0][24] == 1:
		prediction = 'Model8'
	elif result[0][25] == 1:
		prediction = 'Model9'
	
	print(prediction)
	print(result2)