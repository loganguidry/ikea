using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Fire : MonoBehaviour
{
    public GameObject firePrefab;
    public Transform fireHolder;
    static public List<GameObject> fires = new List<GameObject>();
    
	void Start ()
    {
        int xPos = Random.Range(0, 12);
        int yPos = Random.Range(0, 12);

        GameObject clone = Instantiate(firePrefab, new Vector3(xPos, 0.25f, yPos), Quaternion.identity) as GameObject;
        clone.transform.SetParent(fireHolder);
        fires.Add(clone);

        // Loop through tile objects looking for the tile that matches the fire position:
        foreach(Transform tile in GameObject.Find("TileObjects").GetComponentsInChildren(typeof(Transform)))
        {
            if (tile.position.x == clone.transform.position.x && tile.position.z == clone.transform.position.z)
            {
                clone.GetComponent<FireProperties>().onTile = tile.gameObject;
                tile.GetComponent<TileProperties>().onFire = true;
            }
        }
	}
	
	void Update ()
    {
	    if(Input.GetKeyDown("space")) //simulate "next turn"
        {
            foreach(GameObject fire in fires)
            {
                foreach (Transform tile in GameObject.Find("TileObjects").GetComponentsInChildren(typeof(Transform)))
                {
                    bool catchFire = false;
                    if (tile.position.x == fire.transform.position.x - 1 || tile.position.x == fire.transform.position.x + 1)
                    {
                        if (tile.position.z == fire.transform.position.z)
                        {
                            catchFire = true;
                        }
                    }
                    else if (tile.position.x == fire.transform.position.x)
                    {
                        if (tile.position.z == fire.transform.position.z - 1 || tile.position.z == fire.transform.position.z + 1)
                        {
                            catchFire = true;
                        }
                    }

                    if (catchFire)
                    {
                        GameObject clone = Instantiate(firePrefab, new Vector3(tile.position.x, 0.25f, tile.position.z), Quaternion.identity) as GameObject;
                        clone.transform.SetParent(fireHolder);
                        fires.Add(clone);
                        clone.GetComponent<FireProperties>().onTile = tile.gameObject;
                        tile.GetComponent<TileProperties>().onFire = true;
                    }
                }
            }
        }
	}
}
