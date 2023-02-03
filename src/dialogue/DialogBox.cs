using Godot;
using System;

using GodotArray = Godot.Collections.Array;

public class DialogBox : ColorRect
{
    [Signal]
    public delegate void ChoiceClick(int choiceIndex);
    [Signal]
    public delegate void EmitText(string text);
    private InkPlayer player;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        player = null;
    }

    //  // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(float delta)
    {
        if (Input.IsActionJustPressed("ui_accept") && player != null)
        {
            GD.Print("Continue");
            if (player.CanContinue)
            {
                string text = player.Continue().Trim();
                GD.Print(text);
            }
            else if (player.HasChoices)
            {
                // Add a button for each choice
                for (int i = 0; i < player.CurrentChoices.Length; ++i)
                    GD.Print(i, player.CurrentChoices[i]);
            } else {
                GD.Print("Something else");
            }
        }
    }

    public void BeginDialog(System.Object inkPlayer)
    {
        if (!(inkPlayer is InkPlayer)) return;
        player = (InkPlayer)inkPlayer;
    }
}
