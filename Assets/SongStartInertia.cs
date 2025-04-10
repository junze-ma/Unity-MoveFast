using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Oculus.Interaction.MoveFast;


public class SongPlayTrigger : MonoBehaviour
{
    public StringPropertyBehaviour AppState;

    public void Play()
    {
        AppState.Value = "playing";
    }
}
