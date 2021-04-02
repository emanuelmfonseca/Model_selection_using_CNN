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

classifier.add(Conv2D(1, (3,1), input_shape = (11639, 18, 1), activation = 'relu'))
classifier.add(MaxPooling2D(pool_size = (3, 1)))
classifier.add(Conv2D(1, (3, 1), activation = 'relu'))
classifier.add(MaxPooling2D(pool_size = (3, 1)))
classifier.add(Flatten())
classifier.add(Dense(units = 100, activation = 'relu'))
classifier.add(Dense(units = 25, activation = 'relu'))
classifier.add(Dense(units = 3, activation = 'softmax'))

# Compiling the CNN
classifier.compile(optimizer = 'adam', loss = 'categorical_crossentropy', metrics = ['accuracy'])

# Fitting the CNN to the images

from keras.preprocessing.image import ImageDataGenerator

train_datagen = ImageDataGenerator(rescale = 1./255)

test_datagen = ImageDataGenerator(rescale = 1./255)

training_set = train_datagen.flow_from_directory('~/Desktop/CNN_part_I/Norops_planiceps/Datasets/training_dataset',
                                                 target_size = (11639, 18),
                                                 batch_size = 100,
                                                 class_mode = 'categorical',
                                                 color_mode='grayscale',
                                                 shuffle=True)

test_set = test_datagen.flow_from_directory('~/Desktop/CNN_part_I/Norops_planiceps/Datasets/test_set',
                                            target_size = (11639, 18),
                                            batch_size = 100,
                                            class_mode = 'categorical',
                                            color_mode='grayscale',
                                            shuffle=False)

classifier.fit(training_set,
                        steps_per_epoch = int(24000/100),
                         epochs = 10,
                         validation_data = test_set,
                         validation_steps = int(6000/100))

import numpy as np
from keras.preprocessing import image
import tensorflow as tf
import os
import glob

import sklearn.metrics as metrics
from sklearn.metrics import confusion_matrix as cm

batch_size = 100

test_set2 = test_set

test_set2.reset()
Y_pred = classifier.predict_generator(test_set2, steps = 6000 // batch_size)
y_pred = np.argmax(Y_pred, axis=-1)

matrix = cm(test_set2.classes, y_pred)

data = pd.DataFrame({'Bottleneck': matrix[:, 0], 'Constant': matrix[:, 1], 'Expansion': matrix[:, 2]})
data.index = ['Bottleneck', 'Constant', 'Expansion']
data.to_csv('~/Desktop/CNN_part_I/Norops_planiceps/Confusion_matrix.csv')


folder_path = '~/Desktop/CNN_part_I/Norops_planiceps/Observed'
os.chdir(folder_path)
files = glob.glob('*png')

for img in files:
	test_image = tf.keras.preprocessing.image.load_img(img, target_size = (11639, 18),color_mode='grayscale')
	test_image = image.img_to_array(test_image)
	test_image = np.expand_dims(test_image, axis = 0)
	test_image = np.vstack([test_image])
	result = classifier.predict(test_image)
	result2 = classifier.predict_proba(test_image)
	if result[0][0] == 1:
		prediction = 'Bottleneck'
	elif result[0][1] == 1:
		prediction = 'Constant'
	else:
		prediction = 'Expansion'
	
	print(prediction)
	print(result2)
