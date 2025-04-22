using UnityEngine;

namespace Oculus.Interaction.MoveFast
{
    public class ScoreIncrementer : MonoBehaviour
    {
        private static ScoreKeeper _score;

        [SerializeField, Optional]
        private ReferenceActiveState _condition;

        [SerializeField]
        private HandHitDetector _hitDetector;

        [SerializeField]
        private bool _includeVelocity = true;

        [SerializeField]
        private float _metersPerSecondMultiplierThreshold = 8f;

        [SerializeField]
        private Spawner _scoreSpawner, _failSpawner;

        public int LastScore { get; private set; }   // ��ʾ�ã����ӳɣ�
        public int RawScore { get; private set; }    // �����ж� Perfect / Good

        private void Awake()
        {
            _hitDetector.WhenHitResolved += RegisterScore;
        }

        private void RegisterScore()
        {
            if (_condition.HasReference && !_condition) return;
            if (_score == null && (_score = FindObjectOfType<ScoreKeeper>()) == null) return;

            if (_hitDetector.PoseWasCorrect)
            {
                CalculateScore();
                _scoreSpawner.Spawn();
            }
            else
            {
                _score.BreakCombo();
                _failSpawner.Spawn();
            }
        }

        private void CalculateScore()
        {
            float speed = 0f;

            if (_includeVelocity && _hitDetector.LastHand.TryGetAspect<RawHandVelocity>(out var velocityCalculator))
            {
                speed = velocityCalculator.CalculateThrowVelocity(transform).LinearVelocity.magnitude;
                _score.AddSpeed(speed);
            }

            // ͨ���ٶ����� RawScore������ UI �ж�����ÿ m/s = 10 ��
            RawScore = Mathf.RoundToInt(Mathf.Clamp(speed * 10f, 0, 100));

            // �����ӳɱ�����������ʾ�÷֣�
            int speedMultiplier = Mathf.Max(1, Mathf.FloorToInt(speed / _metersPerSecondMultiplierThreshold));
            int finalScore = RawScore * speedMultiplier;

            LastScore = _score.AddScore(finalScore);
        }
    }
}
