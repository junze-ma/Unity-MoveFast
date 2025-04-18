using System.Collections;
using System.Collections.Generic;
using UnityEngine;
public class RebindHandMesh : MonoBehaviour
{
    public Mesh sourceMesh;                 // 拖入 hand_low（网格图标）
    public Material[] materials;           // 拖入 M_bandaged 材质
    public Transform rootBone;             // 比如 b_l_wrist
    public Transform[] bones;              // 按顺序拖 16 个骨骼：b_l_index1 ~ b_l_thumb3

    void Start()
    {
        // 创建新的 GameObject
        GameObject go = new GameObject("BandagedHand_Rebound");
        go.transform.SetParent(rootBone);
        go.transform.localPosition = Vector3.zero;
        go.transform.localRotation = Quaternion.identity;
        go.transform.localScale = Vector3.one;

        // 添加 SkinnedMeshRenderer
        var smr = go.AddComponent<SkinnedMeshRenderer>();
        smr.sharedMesh = sourceMesh;
        smr.rootBone = rootBone;
        smr.bones = bones;
        smr.sharedMaterials = materials;

        Debug.Log("✅ 重绑定完成！Mesh 已替换！");
    }
}
