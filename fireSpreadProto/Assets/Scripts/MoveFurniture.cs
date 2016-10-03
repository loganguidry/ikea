using UnityEngine;
using System.Collections;

public class MoveFurniture : MonoBehaviour {
	public bool selected = false;
	private Vector3 pos;
	private bool horizontal = true;

	// Use this for initialization
	void Start () {
		pos = transform.position;
	}
	
	// Update is called once per frame
	void Update () {

		Vector3 screenPos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
		//RaycastHit2D hit = Physics2D.Raycast(Camera.main.ScreenToWorldPoint(Input.mousePosition), Vector2.zero);
		RaycastHit hit;
		Ray ray = Camera.main.ScreenPointToRay (Input.mousePosition);


		if (Input.GetMouseButtonDown(0))
		{
			if(Physics.Raycast(ray, out hit) && hit.transform.name == gameObject.transform.name) {
				print("clicked on");
				selected = true;
			}else{
				print("clicked outside");
				selected = false;
			}
			
		}

		Move ();
	}

	void Move()
	{
		if (selected) 
		{
			if (Input.GetKeyDown (KeyCode.LeftArrow))
			{
				pos.x -= 1;
				gameObject.transform.position = pos;
			}
			if (Input.GetKeyDown (KeyCode.RightArrow))
			{
				pos.x += 1;
				gameObject.transform.position = pos;
			}
			if (Input.GetKeyDown (KeyCode.UpArrow))
			{
				pos.z += 1;
				gameObject.transform.position = pos;
			}
			if (Input.GetKeyDown (KeyCode.DownArrow))
			{
				pos.z -= 1;
				gameObject.transform.position = pos;
			}

			if (Input.GetKeyDown (KeyCode.R))
			{
				gameObject.transform.Rotate(Vector3.up, 90);
				if (horizontal)
				{
					pos.x += 0.5f;
					pos.z += 0.5f;
					horizontal = !horizontal;
					gameObject.transform.position = pos;
				}
				else {
					pos.x -= 0.5f;
					pos.z -= 0.5f;
					horizontal = !horizontal;
					gameObject.transform.position = pos;
				}
				print ("Rotate called");
			}
		}
	}
}
