using UnityEngine;

namespace Oculus.Interaction.MoveFast
{
    public class ForceShowResultsUI : MonoBehaviour
    {
        [SerializeField]
        private GameObject resultsUIPanel; // 你的结算 UI 物体
        [SerializeField]
        private UICanvas uiCanvas; // 如果你想用 UICanvas 的 Show 动画

        public void ShowResults()
        {
            if (resultsUIPanel != null) resultsUIPanel.SetActive(true);
            if (uiCanvas != null) uiCanvas.Show(true);
        }
    }
}
