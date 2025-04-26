using UnityEngine;

namespace Oculus.Interaction.MoveFast
{
    public class ForceShowResultsUI : MonoBehaviour
    {
        [SerializeField]
        private GameObject resultsUIPanel; // ��Ľ��� UI ����
        [SerializeField]
        private UICanvas uiCanvas; // ��������� UICanvas �� Show ����

        public void ShowResults()
        {
            if (resultsUIPanel != null) resultsUIPanel.SetActive(true);
            if (uiCanvas != null) uiCanvas.Show(true);
        }
    }
}
