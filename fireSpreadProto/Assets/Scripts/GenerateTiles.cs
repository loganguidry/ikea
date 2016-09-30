using UnityEngine;
using System.Collections;

public class GenerateTiles : MonoBehaviour
{
    public GameObject tile;
    public int gridSize;

	void Start ()
    {
	    for (int i = 0; i < gridSize; i++)
        {
            for (int j = 0; j < gridSize; j++)
            {
                GameObject clone = Instantiate(tile, new Vector3(i, 0, j), Quaternion.identity) as GameObject;
                int[] pos = new int[2];
                pos[0] = i;
                pos[1] = j;
                clone.GetComponent<TileProperties>().position = pos;
            }
        }
	}
}
