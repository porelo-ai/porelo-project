# ST364 — An agent's own sign-in made on the host

**Priority:** 🔼 High · **State:** Idea

**What a user gains.** A person whose agent signs in through a provider's login (not an API key) signs that agent in on the host itself, so the host and the person's own machine each keep their own sign-in and neither signs the other out; API keys are still carried as before.

**The test.** On a rented host, carry the agents: an agent signed in by API key is carried and starts. For an agent signed in by its provider's login, Porelo does not copy the sign-in but offers a sign-in on the host; the person confirms the login link or code, and the agent starts on the host. A day later both the host's agent and the same agent on the person's machine still work without signing in again.

**Issues:**

- [porelo-claude-code#CC75](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc75) (Idea)
- [porelo-codex#CX28](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx28) (Idea)
- [porelo-agy#AG30](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag30) (Idea)
- [porelo-pi#PI67](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi67) (Idea)
- [porelo-omp#OM65](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om65) (Idea)
- [porelo#B785](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b785) (Idea)
- [porelo#B786](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b786) (Idea)
- [porelo#B787](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b787) (Idea)
- [porelo-frontend#F584](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f584) (Idea)
- [porelo-frontend#F585](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f585) (Idea)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST364",
  "title": "An agent's own sign-in made on the host",
  "gain": "A person whose agent signs in through a provider's login (not an API key) signs that agent in on the host itself, so the host and the person's own machine each keep their own sign-in and neither signs the other out; API keys are still carried as before.",
  "test": "On a rented host, carry the agents: an agent signed in by API key is carried and starts. For an agent signed in by its provider's login, Porelo does not copy the sign-in but offers a sign-in on the host; the person confirms the login link or code, and the agent starts on the host. A day later both the host's agent and the same agent on the person's machine still work without signing in again.",
  "tested": null,
  "priority": "High",
  "state": "Idea",
  "issues": [
    "porelo-claude-code#CC75",
    "porelo-codex#CX28",
    "porelo-agy#AG30",
    "porelo-pi#PI67",
    "porelo-omp#OM65",
    "porelo#B785",
    "porelo#B786",
    "porelo#B787",
    "porelo-frontend#F584",
    "porelo-frontend#F585"
  ]
}
```
