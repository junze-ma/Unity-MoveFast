using UnityEngine;

public class InstructorVisibilityBinder : MonoBehaviour
{
    public GameObject target;
    public GameObject playInertia;

    private void Update()
    {
        if (!playInertia) return;
        if (!target) return;

        bool isActive = playInertia.activeInHierarchy;
        target.SetActive(isActive);
    }
}
