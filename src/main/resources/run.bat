@echo off
for /L %%a in (
15,-1,0
) do (
echo 15�������chrome.exe
echo ��ʣ�� %%a ��
ping -n 2 localhost 1>nul 2>nul
cls
)
start chrome.exe --kiosk https://www.baidu.com