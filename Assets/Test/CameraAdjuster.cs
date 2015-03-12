using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class CameraAdjuster : MonoBehaviour
{
    int screenHeight;

    void Update()
    {
        if (screenHeight != Screen.height)
        {
            screenHeight = Screen.height;
            GetComponent<Camera>().orthographicSize = (float)screenHeight / 512;
        }
    }
}
