using UnityEngine;
using System.Collections;

public class PlaceFurniture : MonoBehaviour
{
    public GameObject couch;
    public GameObject sideTable;

    void OnMouseDown()
    {
        if (GetComponent<TileProperties>().furnitureOnTop == null)
        {
            if (SelectFurniture.currentSelection == "Side Table")
            {
                GameObject clone = Instantiate(sideTable, transform.position, Quaternion.identity) as GameObject;
                clone.transform.Translate(new Vector3(0, 0.5f, 0));
                GetComponent<TileProperties>().furnitureOnTop = clone;
            }
        }
    }
}
