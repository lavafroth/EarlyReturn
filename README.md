# EarlyReturn
PoC for an AMSI Bypass I discovered while analyzing amsi.dll 
A large part of the code is stolen from RastaMouse's ASBBypass.ps1
This script targets AmsiInitialize and overwrites the method to pop the stack and return early.
