using UnityEngine;
using System.Collections;

public class CheckOnFire : MonoBehaviour {
	public bool onFire = false;

	// Use this for initialization
	void Start () {

	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnParticleCollision(GameObject other) {
		print ("hit by fire");
	}
}
