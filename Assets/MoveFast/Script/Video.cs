using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;

public class ForceVideoPlay : MonoBehaviour
{
    public VideoPlayer player;

    void Start()
    {
        if (player != null)
        {
            Debug.Log("Forcing Video Playback");
            player.Play();
        }
    }
}
