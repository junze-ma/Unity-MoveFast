using System.Collections;
using TMPro;
using UnityEngine;

namespace Oculus.Interaction.MoveFast
{
    public class SpawnerScore : MonoBehaviour, ISpawnerModifier
    {
        private ScoreIncrementer _hitDetector;

        public void Awake()
        {
            _hitDetector = GetComponentInParent<ScoreIncrementer>();
        }

        public void Modify(GameObject instance)
        {
            int score = _hitDetector.LastScore;

            // 设置分数文本
            var text = instance.GetComponentInChildren<TextMeshProUGUI>();
            if (text != null)
            {
                text.text = score.ToString();
            }

            // 获取图标
            Transform good = instance.transform.Find("Good");
            Transform perfect = instance.transform.Find("Perfect");
            Transform miss = instance.transform.Find("Miss");

            if (good) good.gameObject.SetActive(false);
            if (perfect) perfect.gameObject.SetActive(false);
            if (miss) miss.gameObject.SetActive(false);

            GameObject iconToShow = null;

            if (score < 50 && good)
            {
                iconToShow = good.gameObject;
            }
            else if (score >= 50 && perfect)
            {
                iconToShow = perfect.gameObject;
            }
            else if (miss)
            {
                iconToShow = miss.gameObject;
            }

            if (iconToShow != null)
            {
                iconToShow.SetActive(true);
                instance.GetComponent<MonoBehaviour>().StartCoroutine(HideAfterDelay(iconToShow));
            }
        }

        private IEnumerator HideAfterDelay(GameObject go)
        {
            yield return new WaitForSeconds(0.8f);
            if (go != null) go.SetActive(false);
        }
    }
}
