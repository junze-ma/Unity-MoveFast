using TMPro;
using UnityEngine;

namespace Oculus.Interaction.MoveFast
{
    public class ScoreCardUI : MonoBehaviour
    {
        [Header("Components")]
        [SerializeField] private TextMeshProUGUI[] _totalScoreTexts;
        [SerializeField] private TextMeshProUGUI[] _comboScoreTexts;
        [SerializeField] private TextMeshProUGUI[] _multiplierTexts;
        [SerializeField] private TextMeshProUGUI[] _multiplierWordTexts;

        [Header("References")]
        [SerializeField] private ScoreKeeper _scoreKeeper;

        private void Awake()
        {
            _scoreKeeper.WhenChanged += UpdateScoreCardUI;
            UpdateScoreCardUI();
        }

        private void UpdateScoreCardUI()
        {
            foreach (var txt in _totalScoreTexts)
                txt.SetText(_scoreKeeper.Score.ToString());

            foreach (var txt in _comboScoreTexts)
                txt.SetText(_scoreKeeper.HitsInARow.ToString());

            foreach (var txt in _multiplierTexts)
                txt.SetText($"x{_scoreKeeper.Combo}");

            foreach (var txt in _multiplierWordTexts)
                txt.SetText(GetMultiplierWord());
        }

        private string GetMultiplierWord()
        {
            if (_scoreKeeper.Combo >= 20) return "Amazing!";
            if (_scoreKeeper.Combo >= 15) return "Keep Going";
            if (_scoreKeeper.Combo >= 10) return "Awesome!";
            return "";
        }
    }
}
