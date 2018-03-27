source plexcreds.config

# Refresh TV and Music and Movies Libraries in my Plex Library...

curl http://ndo2.iamnico.xyz:32400/library/sections/6/refresh?X-Plex-Token=$tokenndo
curl http://ndo2.iamnico.xyz:32400/library/sections/5/refresh?X-Plex-Token=$tokenndo
curl http://ndo2.iamnico.xyz:32400/library/sections/7/refresh?X-Plex-Token=$tokenndo
