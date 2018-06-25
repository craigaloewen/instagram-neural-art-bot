from instalooter.looters import ProfileLooter

instagram_account_name = "eleanor3069"

# Grab newest instagram posts

looter = ProfileLooter(instagram_account_name)
looter.download('./subjectimg/', media_count=5)
print("Finished downloading photos")
