# ST378 — Pis Nutzerdokumentation stimmt mit dem, was das Paket tut, überein

**Priority:** 🟰 Medium · **State:** In analysis

**What a user gains.** Wer Pi in Porelo installiert, anmeldet und einen Task startet, kann sich auf README und doc/index.md verlassen: Befehle, Provider, Modelle, erreichbare Hosts, Paketgröße und Fehlermeldungen stimmen mit dem Verhalten überein.

**The test.** Eine Person folgt doc/index.md Schritt für Schritt (Install, vault put/authorize, task start --agent pi, porelo agents --verbose) und findet keine Angabe, die vom Ergebnis oder von pi.yaml/Code abweicht.

**Issues:**

- [porelo-pi#PI74](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi74) (In analysis)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST378",
  "title": "Pis Nutzerdokumentation stimmt mit dem, was das Paket tut, überein",
  "gain": "Wer Pi in Porelo installiert, anmeldet und einen Task startet, kann sich auf README und doc/index.md verlassen: Befehle, Provider, Modelle, erreichbare Hosts, Paketgröße und Fehlermeldungen stimmen mit dem Verhalten überein.",
  "test": "Eine Person folgt doc/index.md Schritt für Schritt (Install, vault put/authorize, task start --agent pi, porelo agents --verbose) und findet keine Angabe, die vom Ergebnis oder von pi.yaml/Code abweicht.",
  "priority": "Medium",
  "issues": ["porelo-pi#PI74"],
  "tested": null
}
```
