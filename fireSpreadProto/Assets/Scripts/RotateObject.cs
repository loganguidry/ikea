using UnityEngine;
using System.Collections;

public class RotateObject : MonoBehaviour
{
    public Vector3 rotateSpeed;

	void Update ()
    {
        transform.Rotate(rotateSpeed);
	}
}
