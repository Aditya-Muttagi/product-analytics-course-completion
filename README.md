# Diagnosing Course Completion Failure in an Online Learning Platform  
**Product Analytics Case Study**

## Overview
Course completion rates on online learning platforms are often extremely low.  
This project investigates **where learners fail in the lifecycle**, **which early behaviors gate success**, and **what product intervention could realistically improve completion**.

The work is intentionally scoped to mirror how a Product Analyst would approach a real product problem: disciplined analysis, conservative assumptions, and experiment-ready recommendations.

---

## Core Product Question
> **Which early learner behaviors most strongly increase the likelihood of course completion, and where should the product intervene in the lifecycle?**

---

## Dataset
An anonymized online course dataset containing:
- User registration and completion indicators
- Engagement depth metrics (events, videos, chapters, forum posts)
- Course start and last activity timestamps

**Note:**  
Raw data is not included due to privacy and size constraints.  
All analysis is reproducible given access to a similar schema.

---

## Analytical Approach

### 1. Lifecycle & Funnel Diagnosis
- Modeled the learner funnel from registration → engagement → completion
- Identified the dominant failure point prior to meaningful exploration
- Established that completion failure occurs very early in the lifecycle

### 2. Retention Analysis
- Built retention curves to measure learner persistence over time
- Identified a **hard early retention threshold (~8 days)** gating success
- Validated findings across cohorts to rule out temporal artifacts

### 3. Behavioral Diagnosis
- Restricted analysis to learners who crossed the early retention threshold
- Compared engagement intensity across retained completers vs non-completers
- Normalized behaviors per active day to avoid duration bias

### 4. Experiment Design
- Translated insights into a product-ready A/B experiment
- Focused on early, controllable behavioral levers rather than vanity metrics

---

## Key Findings

- Learners active for fewer than **8 days almost never complete courses**
- Completion probability increases sharply after crossing the early retention threshold
- Among retained learners, **video consumption intensity per active day** is the strongest differentiator of completion
- Social or forum participation does **not** materially impact completion outcomes

---

## Product Recommendation
Focus on **video-first onboarding during the first 8 days**, guiding learners through a structured early video path to increase engagement intensity before behavior stabilizes.

This intervention is:
- Low engineering effort
- Behaviorally targeted
- Directly aligned with observed success patterns

---

## Experiment Design (Summary)

**Objective:**  
Increase course completion by increasing early video consumption intensity.

**Population:**  
Newly registered learners during the first 8 days after course start.

**Treatment:**  
A video-focused onboarding experience emphasizing early video progression.

**Primary Metric:**  
Course completion rate.

**Diagnostics:**  
- Videos per active day (Days 1–8)  
- % learners reaching ≥8 active days  

**Guardrails:**  
- Day-1 abandonment  
- Session fatigue indicators  

---

## Repository Structure

