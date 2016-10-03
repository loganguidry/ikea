using UnityEngine;
using System.Collections;

public class SelectFurniture : MonoBehaviour
{
    public static string currentSelection = "";
	public GameObject[] furniture;
	private Vector3 pos;

	void Start ()
    {
	    
	}

    public void SelectFurnitureType(string name)
    {
        if (name != currentSelection)
        {
            print("Selected " + name);
            currentSelection = name;

			foreach (GameObject furn in furniture)
			{
				if (furn.name == name)
				{
					if (furn.name == "Couch")
					{
						pos = new Vector3(6.5f,0.625f,6f);
					}
					else {
						pos = new Vector3(6.0f,0.625f,6f);
					}
					GameObject copy = (GameObject)(Instantiate(furn, pos, Quaternion.identity));
					MoveFurniture copyCode = copy.GetComponent<MoveFurniture>();
					copyCode.selected = true;
				}
				else
				{
					GameObject copy = furn;
					MoveFurniture copyCode = copy.GetComponent<MoveFurniture>();
					copyCode.selected = false;
				}
			}
        }
        else
        {
            print("Deselected all furniture");
            currentSelection = "";
        }
    }
}
