// Copyright (c) Meta Platforms, Inc. and affiliates.

using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

namespace Oculus.Interaction.MoveFast
{
    /// <summary>
    /// Controls the tutorial's behaviour
    /// </summary>
    public class Tutorial : MonoBehaviour
    {
        private PlayableDirector _director;
        private List<TimeRange> _timeRanges;
        private ScoreKeeper _scoreKeeper = null;
        private int _index = -1;

        [SerializeField]
        ReferenceActiveState _isBlocking;
        [SerializeField]
        ReferenceActiveState _isTutorial;
        [SerializeField]
        int _blockIndex = 5;

        float _lastNext = -1;

        private void Start()
        {
            _scoreKeeper = FindObjectOfType<ScoreKeeper>();
            _director = GetComponent<PlayableDirector>();
            _timeRanges = MarkerTrack.GetTimeRanges(_director);

            Log($"[Tutorial Init] Found {_timeRanges.Count} marker ranges.");
            foreach (var range in _timeRanges)
            {
                Log($"[Marker Detected] {range.TimelineName} from {range.Start:F2}s to {range.End:F2}s");
            }

            _director.RebuildGraph();
            _director.played += StartTutorial;
            _director.stopped += EndTutorial;
        }

        private void StartTutorial(PlayableDirector obj)
        {
            Log("[Tutorial] StartTutorial triggered");
            _index = -1;

            HandHitDetector.TutorialMode = true;

            _scoreKeeper.WhenChanged -= Next;
            _scoreKeeper.WhenChanged += Next;

            Next(true);
        }

        private void EndTutorial(PlayableDirector obj)
        {
            Log("[Tutorial] EndTutorial triggered");

            HandHitDetector.TutorialMode = false;
            _scoreKeeper.WhenChanged -= Next;
            _index = -1;
        }

        private void Update()
        {
            if (_isTutorial)
            {
                HandHitDetector.TutorialMode = true;
            }
            else
            {
                HandHitDetector.TutorialMode = false;
            }

            if (DetectBlock())
            {
                Log("[Tutorial] Blocking condition met — calling Next()");
                Next();
            }
        }

        private bool DetectBlock()
        {
            if (_index < _blockIndex)
            {
                Log($"[DetectBlock] Index {_index} < blockIndex {_blockIndex} — skip block check.");
                return false;
            }

            if (!_director.playableGraph.IsValid())
            {
                Log("[DetectBlock] PlayableGraph is not valid.");
                return false;
            }

            bool directorIsAtEnd = _director.time >= _director.playableGraph.GetRootPlayable(0).GetDuration();
            if (!directorIsAtEnd)
            {
                Log($"[DetectBlock] Director not at end: {_director.time:F2} / {_director.playableGraph.GetRootPlayable(0).GetDuration():F2}");
                return false;
            }

            bool blocking = _isBlocking == null ? false : _isBlocking.Active;
            Log($"[DetectBlock] blocking={blocking}");
            return blocking;
        }

        public void Next()
        {
            Next(false);
        }

        public void Next(bool forceIndex)
        {
            if (Time.time - _lastNext < 1f && !forceIndex)
            {
                Log("[Tutorial] Too fast, wait for cooldown.");
                return;
            }

            _lastNext = Time.time;
            _index++;

            bool end = _index >= _timeRanges.Count;
            double time = end ? _director.playableAsset.duration : _timeRanges[_index].End;

            _director.playableGraph.GetRootPlayable(0).SetDuration(time);

            Log($"[Tutorial] Next triggered — Index {_index}, jump to time: {time:F2}, end={end}");

            if (end)
            {
                Log("[Tutorial] Tutorial finished, ending...");
                EndTutorial(null);
            }
        }

        /// <summary>
        /// 用于调试输出，自动发到 DebugOverlay 和 Console
        /// </summary>
        private void Log(string msg)
        {
            Debug.Log(msg);
            if (DebugOverlay.Instance != null)
            {
                DebugOverlay.Instance.Log(msg);
            }
        }
    }
}
