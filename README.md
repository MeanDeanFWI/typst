THWS Typst Templates

Ein einheitliches Template-Set für Lehr- und Lernunterlagen an der Technischen Hochschule Würzburg-Schweinfurt (THWS).
Die Templates sind auf Typst abgestimmt und folgen der THWS-Corporate Identity mit der Hausfarbe THWS-Orange (#ff6a00).

Alle Vorlagen sind lokal installierbar und gewährleisten ein konsistentes Layout über alle Dokumenttypen hinweg — von Handouts bis zu vollständigen Skripten.

⸻

📦 Installation & Nutzung

Die Templates können nicht direkt über GitHub-Raw-Links importiert werden,
da Typst derzeit keine Online-Templates unterstützt.

Stattdessen müssen sie lokal installiert oder in dein Projekt kopiert werden.

🔧 Lokale Installation
	1.	Klone oder lade dieses Repository herunter:

git clone https://github.com/<dein-user>/thws-typst-templates


	2.	Kopiere den Ordner mit den Templates (z. B. thws-handout.typ, thws-tutorial.typ, thws-script.typ)
in dein Typst-Projektverzeichnis, z. B. ./templates/.
	3.	Importiere das gewünschte Template in deiner Typst-Datei:

#import "templates/thws-handout.typ": handout



⸻

🧾 Verfügbare Templates

1. 🟠 THWS-Handout (handout.typ)

Verwendung:
Für Handouts, Workshop-Material, kompakte Reader oder Begleitunterlagen.
Bietet ein Deckblatt-ähnliches Titel-Layout, Inhaltsübersicht (optional) und optionale Bibliographie.

Aufrufbeispiel:
```
#show: handout.with(
  title: [KI-gestützte Lehrentwicklung],
  intro: [Dieser Reader zeigt einen Workflow zur Entwicklung digitaler Lerneinheiten.],
  authors: (
    (name: "Prof. Dr. Max Muster", role: "THWS · Fakultät Wirtschaftsingenieurwesen"),
  ),
  subject: "Digital Teaching",
  lang: "de",
)
```

⸻

2. 🟣 THWS-Tutorial (tutorial.typ)

Verwendung:
Für Übungen, Übungsblätter und Tutorien.
Ohne Outline oder Bibliographie, kompakter Kopfbereich mit Kursangabe.
Logo oben links im Header, keine Boxen oder Rahmen – reiner Fließtext.

Aufrufbeispiel:
```
#show: tutorial.with(
  sheet_title: [Übungsblatt 3 – Regelbasierte KI],
  course: [KI in der Lehre (WS 25/26)],
  info: [Fakultät Wirtschaftsingenieurwesen · THWS · Prof. Dr. Muster],
  subject: "KI-Tutorium",
  lang: "de",
)
```

⸻

3. 🔵 THWS-Script (cript.typ)

Verwendung:
Für vollständige Reader, Skripte oder umfangreiche Lehrtexte.
Mit automatischem Deckblatt, Inhaltsverzeichnis und optionalem Literaturverzeichnis.
Deckblatt enthält das große THWS-Logo (50 % Breite) zentriert unter dem Titel,
ab Seite 2 erscheint das kleinere Logo (20 %) oben links im Header.

Aufrufbeispiel:
```
#show: script.with(
  script_title: [IFRS Financial Instruments],
  subtitle: [Reader for International Accounting],
  authors: (
    (name: "Prof. Dr. Max Muster", role: "Lecturer", organization: "THWS"),
  ),
  course: [International Accounting],
  semester: [Winter Semester 2025/26],
  faculty: [Faculty of Business & Engineering],
  university: [Technische Hochschule Würzburg-Schweinfurt],
  version: [Version 1.0],
  date: [October 2025],
  lang: "en",
)
```

⸻

🎨 Designmerkmale
	•	Einheitliche Typografie mit Inter (11 pt)
	•	THWS-Hausfarbe #ff6a00 für Überschriften und Tabellenlinien
	•	Automatische Seitenzahlen in Orange, zentriert in der Fußzeile
	•	Tabellen mit orangefarbenen Linien und farblich hervorgehobener Kopfzeile
	•	Zitate kursiv, Blocksatz mit sanfter Absatzabtrennung
	•	Outline-Titel und Bibliographie sind sprachabhängig (de / en)

⸻

🧩 Lizenz und Anpassung

Die Templates sind für den internen Einsatz an der THWS gedacht.
Sie können lokal angepasst oder erweitert werden, nicht jedoch ohne Kennzeichnung oder Versionsänderung weitergegeben werden.



⸻

© Technische Hochschule Würzburg-Schweinfurt
Design & Code: Prof. Dr. Christian Kraus#
