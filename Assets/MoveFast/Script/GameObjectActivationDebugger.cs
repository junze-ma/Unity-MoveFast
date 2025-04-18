using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActivationLogger : MonoBehaviour
{
    private void OnEnable()
    {
        Debug.LogWarning($"[激活日志] {gameObject.name} 被激活了！调用堆栈：\n{System.Environment.StackTrace}");
    }
}
