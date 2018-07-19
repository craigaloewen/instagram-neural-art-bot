
from instalooter.looters import ProfileLooter
from os import listdir
import pandas as pd

photorecord_dir = './instabotimagerecords/'

photorecord_csv_dir = photorecord_dir + 'procdimagelist.csv'

total_photo_list = listdir(photorecord_dir)

csvdf = pd.read_csv(photorecord_csv_dir)

non_matching_file_list = [file_name for file_name in total_photo_list if not any(file_name in proc_name for proc_name in csvdf['name'])]

print("Non matching files: ")
print(non_matching_file_list)

if len(non_matching_file_list) == 1:
    print("Identified new post: {} and now cleaning up".format(non_matching_file_list[0]))
    with open(photorecord_csv_dir, "a") as myfile:
        myfile.write(non_matching_file_list[0] + "\n")
