USING:
----------------------------------------------------------------------------------------------------------------------------------
# Nếu bạn đã biết Mac Address:

Command:
sh -c "$(wget -qO- https://raw.githubusercontent.com/lvthu93/xiaozhi_voicebot_code/main/xiaozhi.sh)" -- $MAC

Example:
sh -c "$(wget -qO- https://raw.githubusercontent.com/lvthu93/xiaozhi_voicebot_code/main/xiaozhi.sh)" -- 98:bb:99:3f:XX:XX
----------------------------------------------------------------------------------------------------------------------------------
# Nếu chưa biết Mac Address:

IP Default: 192.168.43.1:5555 (dùng khi giữ nút Loa 10s)

Command:
sh -c "$(wget -qO- https://raw.githubusercontent.com/lvthu93/xiaozhi_voicebot_code/main/auto.sh)" -- $IP:PORT

Example: 
sh -c "$(wget -qO- https://raw.githubusercontent.com/lvthu93/xiaozhi_voicebot_code/main/auto.sh)" -- 192.168.43.1:5555
----------------------------------------------------------------------------------------------------------------------------------
# NOTE
- Có thể sử dụng trong môi trường linux (WSL, iSH Shell, Termux, MacOS, Ubuntu...) hoặc nếu dùng python thì cần cài thêm pip
- auto.sh sẽ tự lấy IP default nếu không thêm IP cuối hàm
- ABD trên iSH Shell thường hay disconnect. Có thể phải lấy mac thủ công

#ADB connection
adb connect 192.168.43.1:5555

#Get Mac Address
adb shell cat /sys/class/net/wlan0/address
