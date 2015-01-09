using UnityEngine;
using System.Collections;
using UnityEngine.UI;


public class LoadSprite : MonoBehaviour{

	[SerializeField]
	Texture2D texture;

	void Start () 
	{
		var image = GetComponent<Image>();
		
		Sprite sprite = Sprite.Create(texture, new Rect(0,0, texture.width , texture.height), new Vector2(0.5f, 0.5f));
		image.sprite = sprite;
	}
}
