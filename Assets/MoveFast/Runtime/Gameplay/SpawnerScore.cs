using System.Collections;
using TMPro;
using UnityEngine;

namespace Oculus.Interaction.MoveFast
{
    public class SpawnerScore : MonoBehaviour, ISpawnerModifier
    {
        private ScoreIncrementer _scoreIncrementer;

        // 阈值（你可以在 Inspector 中调整）
        [SerializeField]
        private float perfectSpeedThreshold = 5f;

        public void Awake()
        {
            _scoreIncrementer = GetComponentInParent<ScoreIncrementer>();
        }

        public void Modify(GameObject instance)
        {
            var text = instance.GetComponentInChildren<TextMeshProUGUI>();
            if (text != null)
            {
                text.text = _scoreIncrementer.LastScore.ToString(); // 分数字体仍然使用 LastScore 显示
            }

            Transform good = instance.transform.Find("Good");
            Transform perfect = instance.transform.Find("Perfect");
            Transform miss = instance.transform.Find("Miss");

            if (good) good.gameObject.SetActive(false);
            if (perfect) perfect.gameObject.SetActive(false);
            if (miss) miss.gameObject.SetActive(false);

            GameObject iconToShow = null;

            var hitDetector = _scoreIncrementer.GetComponent<HandHitDetector>();
            var hand = hitDetector.LastHand;

            if (hand != null && hand.TryGetAspect<RawHandVelocity>(out var velocityCalculator))
            {
                float speed = velocityCalculator.CalculateThrowVelocity(instance.transform).LinearVelocity.magnitude;

                Debug.Log($"[SpawnerScore] Punch Speed = {speed:F2} m/s");

                if (hitDetector.PoseWasCorrect)
                {
                    if (speed >= perfectSpeedThreshold && perfect)
                    {
                        iconToShow = perfect.gameObject;
                    }
                    else if (speed < perfectSpeedThreshold && good)
                    {
                        iconToShow = good.gameObject;
                    }
                }
                else if (miss)
                {
                    iconToShow = miss.gameObject;
                }
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
            if (go != null)
            {
                go.SetActive(false);
            }
        }
    }
}
