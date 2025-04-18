using System.Collections;
using UnityEngine;

namespace Oculus.Interaction.MoveFast
{
    public class SpawnerMissUI : MonoBehaviour, ISpawnerModifier
    {
        [SerializeField] private string missIconName = "Miss";

        public void Modify(GameObject instance)
        {
            var miss = instance.transform.Find(missIconName);
            if (miss != null)
            {
                miss.gameObject.SetActive(true);
                instance.GetComponent<MonoBehaviour>().StartCoroutine(HideAfterDelay(miss.gameObject));
            }
        }

        private IEnumerator HideAfterDelay(GameObject go)
        {
            yield return new WaitForSeconds(0.8f);
            if (go != null)
            {
                go.SetActive(false);
            }
        }
    }
}
