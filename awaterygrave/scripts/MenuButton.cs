using Godot;
using System;

public partial class MenuButton : Button
{
	[Export] public double AnimationTime = 0.6d;
	[Export] public float YOffset = 0f;

	private TextureRect _left;
	private TextureRect _right;

	//Not gonna make this an export because I doubt we'll need to change it like ever
	private static double FRAMES = 7;

	private double _frameTime = 0;

	public override void _Ready()
	{
		_left = GetNode<TextureRect>("Left");
		_right = GetNode<TextureRect>("Right");

		var oldLeftTexture = _left.Texture;
		var oldRightTexture = _right.Texture;

		_left.Texture = new AtlasTexture();
		_right.Texture = new AtlasTexture();
		_left.Texture.CopyFromResource(oldLeftTexture);
		_right.Texture.CopyFromResource(oldRightTexture);

		_left.Position = new Vector2(_left.Position.X, 40 + YOffset);
		_right.Position = new Vector2(_right.Position.X, 40 + YOffset);
	}

	public override void _Process(double delta)
	{
		if (IsHovered())
		{
			_frameTime += delta;
		}
		else
		{
			_frameTime -= delta;
		}

		_frameTime = Math.Clamp(_frameTime, 0, AnimationTime);

		var y = (FRAMES - Math.Round(clampedMap(_frameTime, 0, AnimationTime, 0, FRAMES))) * 48d;

		var leftAtlas = (AtlasTexture)_left.Texture;
		var rightAtlas = (AtlasTexture)_right.Texture;

		leftAtlas.Region = new Rect2(new Vector2(0, (float) y),  new Vector2(144, 48));
		rightAtlas.Region = new Rect2(new Vector2(144, (float) y),  new Vector2(13, 48));

		GD.Print(String.Concat(Text, ": ", y));
	}

	private static double clampedMap(double value, double originalMin, double originalMax, double min, double max)
	{
		return Math.Clamp(min + (value - originalMin) / (originalMax - originalMin) * (max - min), min, max);
	}
}
