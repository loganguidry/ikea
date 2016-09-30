using UnityEngine;
using System.Collections;

public class SelectFurniture : MonoBehaviour
{
    public static string currentSelection = "";

	void Start ()
    {
	    
	}

    public void SelectFurnitureType(string name)
    {
        if (name != currentSelection)
        {
            print("Selected " + name);
            currentSelection = name;
        }
        else
        {
            print("Deselected all furniture");
            currentSelection = "";
        }
    }
}
