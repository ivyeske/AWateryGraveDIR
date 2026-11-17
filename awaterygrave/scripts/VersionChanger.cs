using Godot;
using System;

public partial class VersionChanger : Label
{
    public override void _Ready()
    {
        Text = String.Concat("Ver. ",ProjectSettings.GetSetting("application/config/version", "N/A"));
    }
}
