using TMPro;
using UnityEngine;

public class DebugOverlay : MonoBehaviour
{
    public TextMeshProUGUI debugText;
    public int maxLines = 15;

    private static DebugOverlay _instance;
    public static DebugOverlay Instance => _instance;

    private void Awake()
    {
        if (_instance == null) _instance = this;
        else Destroy(gameObject);
    }

    public void Log(string message)
    {
        if (debugText == null) return;

        debugText.text = $"[{Time.time:F2}s] {message}\n" + debugText.text;

        // 保持最多行数
        var lines = debugText.text.Split('\n');
        if (lines.Length > maxLines)
        {
            debugText.text = string.Join("\n", lines, 0, maxLines);
        }
    }
}
