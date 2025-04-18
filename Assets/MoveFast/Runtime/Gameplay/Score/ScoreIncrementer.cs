﻿// Copyright (c) Meta Platforms, Inc. and affiliates.

using UnityEngine;

namespace Oculus.Interaction.MoveFast
{
    /// <summary>
    /// Increments the player's score and multiplies by velocity.
    /// </summary>
    public class ScoreIncrementer : MonoBehaviour
    {
        private static ScoreKeeper _score;

        [Tooltip("When assigned, score will only be counted when the ActiveState is true")]
        [SerializeField, Optional]
        private ReferenceActiveState _condition;

        [SerializeField]
        private HandHitDetector _hitDetector;

        [SerializeField]
        private bool _includeVelocity = true;

        [SerializeField]
        private float _metersPerSecondMultiplierThreshold = 8f;

        [SerializeField]
        private Spawner _scoreSpawner;

        [SerializeField]
        private Spawner _failSpawner;

        public int LastScore { get; private set; }

        private void Awake()
        {
            _hitDetector.WhenHitResolved += RegisterScore;
        }

        /// <summary>
        /// Increments the score, optionally using velocity.
        /// </summary>
        private void RegisterScore()
        {
            if (_condition.HasReference && !_condition)
                return;

            if (_score == null && (_score = FindObjectOfType<ScoreKeeper>()) == null)
                return;

            if (_hitDetector.PoseWasCorrect)
            {
                LastScore = AddScore();
                _scoreSpawner.Spawn();
            }
            else
            {
                _score.BreakCombo();
                _failSpawner.Spawn();
            }
        }

        private int AddScore()
        {
            if (_includeVelocity && _hitDetector.LastHand.TryGetAspect<RawHandVelocity>(out var velocityCalculator))
            {
                // Record the speed of the hit, to display on the results screen.
                var speed = velocityCalculator.CalculateThrowVelocity(transform).LinearVelocity.magnitude;
                _score.AddSpeed(speed);

                // Add bonus multiplier based on speed.
                var speedMultiplier = (int)(speed / _metersPerSecondMultiplierThreshold);
                return _score.AddScore(speedMultiplier);
            }
            else
            {
                return _score.AddScore();
            }
        }
    }
}
