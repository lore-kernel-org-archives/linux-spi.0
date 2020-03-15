From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 15/36] dt-bindings: display: convert simple lg panels to DT Schema
Date: Sun, 15 Mar 2020 14:43:55 +0100
Message-ID: <20200315134416.16527-16-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Brian Masney <masneyb-1iNe0GrtECGEi8DpZVb4nw@public.gmane.org>,
        Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Guido Gunther <agx-wGvLLbajjwFAfugRpC6u6w@public.gmane.org>, Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>,
        Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>,
        Hoegeun Kwon <hoegeun.kwon-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>,
        Jerry Han <hanxu5-dyavHbARFqWrZjcNGxgArdPArS5jOdiE2SarAXORi/o@public.gmane.org>,
        Jonathan Bakker <xc-racer2-kt+e9JA1QaI@public.gmane.org>,
        Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
        Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marco Franchi <marco.franchi-3arQi8VN3Tc@public.gmane.org>,
        Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Ripard <maxime.ripard@bootl
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200315134416.16527-1-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add the lg panels that matches the panel-simple binding to
panel-simple.yaml

Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Brian Masney <masneyb-1iNe0GrtECGEi8DpZVb4nw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../devicetree/bindings/display/panel/lg,acx467akm-7.txt   | 7 -------
 .../devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt | 7 -------
 .../devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt | 7 -------
 .../devicetree/bindings/display/panel/panel-simple.yaml    | 6 ++++++
 4 files changed, 6 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt

diff --git a/Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt b/Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt
deleted file mode 100644
index fc1e1b325e49..000000000000
--- a/Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-LG ACX467AKM-7 4.95" 1080×1920 LCD Panel
-
-Required properties:
-- compatible: must be "lg,acx467akm-7"
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt
deleted file mode 100644
index 5e649cb9aa1a..000000000000
--- a/Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-LG Corporation 7" WXGA TFT LCD panel
-
-Required properties:
-- compatible: should be "lg,ld070wx3-sl01"
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt b/Documentation/devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt
deleted file mode 100644
index a04fd2b2e73d..000000000000
--- a/Documentation/devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-LG Corporation 5" HD TFT LCD panel
-
-Required properties:
-- compatible: should be "lg,lh500wx1-sd03"
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5088fe81d025..b1b8d0edadef 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -155,8 +155,14 @@ properties:
       - kyo,tcg121xglp
         # LeMaker BL035-RGB-002 3.5" QVGA TFT LCD panel
       - lemaker,bl035-rgb-002
+        # LG ACX467AKM-7 4.95" 1080×1920 LCD Panel
+      - lg,acx467akm-7
         # LG 7" (800x480 pixels) TFT LCD panel
       - lg,lb070wv8
+        # LG Corporation 7" WXGA TFT LCD panel
+      - lg,ld070wx3-sl01
+        # LG Corporation 5" HD TFT LCD panel
+      - lg,lh500wx1-sd03
         # LG LP079QX1-SP0V 7.9" (1536x2048 pixels) TFT LCD panel
       - lg,lp079qx1-sp0v
         # LG 9.7" (2048x1536 pixels) TFT LCD panel
-- 
2.20.1
