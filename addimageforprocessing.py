import pandas as pd
from os import listdir
from shutil import copyfile
import random

instagram_account_name = "eleanor3069"

algoinputimg_dir = './algoinputimg/'

style_dir = './styles/'

algostyleimg_dir = './algostyleimg/'

in_imgdir = './subjectimg/'+instagram_account_name+'/'
in_csvdir = in_imgdir+'procdimagelist.csv'

out_imgdir = './outputimg/'+instagram_account_name+'/'
out_csvdir = out_imgdir+'procdimagelist.csv'

total_file_list_in = listdir(in_imgdir)

csvdf_in = pd.read_csv(in_csvdir)

non_matching_list_in = [file_name for file_name in total_file_list_in if not any(file_name in proc_name for proc_name in csvdf_in['name'])]

print("Unprocessed file list")
print(non_matching_list_in)

algoinputimg_list = listdir(algoinputimg_dir)

style_img_list = listdir(style_dir)

if len(non_matching_list_in) > 0 and len(listdir(algoinputimg_dir)) == 0:
    print("Moving {} to algoinputimg".format(non_matching_list_in[0]))
    #move file to flightdeck
    copyfile(in_imgdir+non_matching_list_in[0],algoinputimg_dir+non_matching_list_in[0])

    if len(listdir(algostyleimg_dir)) == 0:
       random_style_img = random.choice(style_img_list)
       copyfile(style_dir + random_style_img, algostyleimg_dir + random_style_img)
       print("Copied style img {}".format(random_style_img))

    # Add file name to dataframe and save it as a csv
    with open(in_csvdir, "a") as myfile:
        myfile.write(non_matching_list_in[0] + "\n")
    # Finish
else:
    print("Error: No images to process or image is already on deck")
