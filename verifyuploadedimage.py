from instalooter.looters import ProfileLooter
from os import listdir
import pandas as pd

instagram_account_name = "iampaintingrobot"

# Grab newest instagram post data

photorecord_dir = './instabotimagerecords/'

photorecord_csv_dir = photorecord_dir + 'procdimagelist.csv'

total_photo_list = listdir(photorecord_dir)

looter = ProfileLooter(instagram_account_name, dump_only=True)
looter.download(photorecord_dir, media_count=1)
print("Finished downloading photo data")

csvdf = pd.read_csv(photorecord_csv_dir)

non_matching_file_list = [file_name for file_name in total_photo_list if not any(file_name in proc_name for proc_name in csvdf['name'])]

print("Non matching files: ")
print(non_matching_file_list)

if len(non_matching_file_list) == 1:


    # Move the file if necessary

    print("Posting was a SUCCESS")
elif len(non_matching_file_list) == 0:
    print("FAILURE: No new image detected")
else:
    print("Error state! Multiple new images detected")
