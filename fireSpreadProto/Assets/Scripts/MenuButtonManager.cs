using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class MenuButtonManager : MonoBehaviour {
	public Canvas menu;
	public Canvas game;
	public int numOfPlayers = 0;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void NumOfPlayers(int num)
	{
		numOfPlayers = num;
		menu.enabled = false;
		game.enabled = true;

	}
}
