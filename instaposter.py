import pandas as pd
from os import listdir
import config
from InstagramAPI import InstagramAPI

algo_output_dir = './algooutputimg/'

algo_style_dir = './algostyleimg/'

styles_info_dir = './styles/styles_info.csv'

total_file_list = listdir(algo_output_dir)

algo_style_list = listdir(algo_style_dir)

if len(total_file_list) > 0:
        print("Attempting to post: ",total_file_list[0])
       
        artist_name = "Unknown"
        art_title = "Unknown"

        style_img_name = "unknown"

        if len(algo_style_list) > 0:
            print("Finding artist for image: {}".format(algo_style_list[0]))
            style_img_name = algo_style_list[0]
            df = pd.read_csv(styles_info_dir)
            searched_df = df[df['file_name'] == algo_style_list[0]]
            if not searched_df.empty:
                artist_name = searched_df['artist'].values[0]
                art_title = searched_df['title'].values[0]
                print("Found artist: {} and title: {}".format(artist_name,art_title))

        # Post output to insta
        InstagramAPI = InstagramAPI(config.insta_username, config.insta_password)
        InstagramAPI.login()  # login

        photo_path = './algooutputimg/' + total_file_list[0]
        original_photo_path = './subjectimg/' + total_file_list[0]

        album_content = [ { 'type' : 'photo', 'file' : photo_path } ]
        album_content.append( { 'type' : 'photo', 'file' : original_photo_path } )

        if not style_img_name == "unknown":
            style_photo_path = './algostyleimg/' + style_img_name
            album_content.append( { 'type' : 'photo', 'file' : style_photo_path } )

        caption = "Original photo by: @eleanor3069 , this image was created using the artistic style of " + artist_name + " in their work: " + art_title
        InstagramAPI.uploadAlbum(album_content, caption=caption)

        # Finish
else:
    print("Error: While posting instagram photo - algooutputimg directory is empty")
