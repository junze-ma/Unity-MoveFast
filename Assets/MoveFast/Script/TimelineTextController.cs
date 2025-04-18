using System.Collections;
using UnityEngine;
using TMPro;
using Febucci.UI.Core;

#if UNITY_EDITOR
using UnityEditor;
#endif

public class TimelineTextController : MonoBehaviour
{
    [Header("Typing Settings")]
    [SerializeField] private TypewriterCore typewriter;
    [SerializeField] private TextMeshProUGUI previewText;
    [SerializeField, TextArea(2, 5)] private string[] dialogueLines;
    [SerializeField] private float intervalAfterTyping = 2f;
    [SerializeField] private GameObject continueIcon;

    private Coroutine typingCoroutine;
    private bool isTypingFinished = false;

    private bool CurrentLineShown
    {
        set { if (continueIcon) continueIcon.SetActive(value); }
    }

    void Awake()
    {
        if (typewriter != null)
        {
            typewriter.onTextShowed.AddListener(() =>
            {
                isTypingFinished = true;
                CurrentLineShown = true;
            });
        }

        if (previewText != null)
        {
            previewText.text = ""; // ✅ 启动时清空文字
        }
    }

    void Start()
    {
        // 可选：二次保险，确保其他组件未覆盖文字内容
        if (previewText != null)
        {
            previewText.text = "";
        }
    }

    /// <summary>
    /// Called from Timeline Signal to display a specific line.
    /// </summary>
    public void ShowLine(int index)
    {
        if (index < 0 || index >= dialogueLines.Length) return;

        if (typingCoroutine != null)
        {
            StopCoroutine(typingCoroutine);
        }

        isTypingFinished = false;
        CurrentLineShown = false;
        typewriter.ShowText(dialogueLines[index]);
        typingCoroutine = StartCoroutine(WaitAfterLine());
        Debug.Log($"[Signal Triggered] ShowLine({index})");
    }

    private IEnumerator WaitAfterLine()
    {
        yield return new WaitUntil(() => isTypingFinished);
        yield return new WaitForSeconds(intervalAfterTyping);
        CurrentLineShown = false;
    }

    /// <summary>
    /// Hide the entire text box.
    /// </summary>
    public void HideText()
    {
        gameObject.SetActive(false);
    }

    /// <summary>
    /// Show the text box if it was hidden before.
    /// </summary>
    public void ShowTextBox()
    {
        gameObject.SetActive(true);
    }

#if UNITY_EDITOR
    public void PreviewLine(int index)
    {
        if (!Application.isPlaying && previewText != null)
        {
            if (index >= 0 && index < dialogueLines.Length)
            {
                previewText.text = dialogueLines[index];
                Debug.Log($"[Preview] Showing line {index}: {dialogueLines[index]}");
            }
        }
    }
#endif
}
