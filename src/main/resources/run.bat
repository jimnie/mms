@echo off
for /L %%a in (
15,-1,0
) do (
echo 15秒后将运行chrome.exe
echo 还剩余 %%a 秒
ping -n 2 localhost 1>nul 2>nul
cls
)
start chrome.exe --kiosk https://www.baidu.com