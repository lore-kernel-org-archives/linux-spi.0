From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 0/36] dt-bindings: display: convert remaning panel bindings to DT Schema
Date: Sun, 15 Mar 2020 14:43:40 +0100
Message-ID: <20200315134416.16527-1-sam@ravnborg.org>
Mime-Version: 1.0
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
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Convert remaining(*) panel bindings to DT Schema.

To prepare for the migration a few preparations
patches was required:

- te-gpios is now added to panel-common - as this
  property is used by a few bindings.

- The slave part of spi-controller.yaml was migrated to a
  new file spi-slave.yaml.
  This was done so spi slaves in panel/ could include
  this file rather than duplicate property names.
  => Please review this carefully!


The original author of the panel bindings are listed as maintainer
in the DT Schema. In the few cases the panel binding was also
listed in MAINTAINERS I checked that there was a match.
It was done manually so I may have missed someone.

All bindings pass dt_binding_check with no warnings.

- "dt-bindings: display: convert ilitek,ili9322 to DT"
  The .txt file listed some constrains that I did not manage
  to capture in the DT Schema.
  And some properties looks like that could be dropped.
  => Please take a closer look.

- "dt-bindings: display: convert sharp,lq101r1sx01 to DT Schema"  
  The .txt file describes some constrains, as some properties
  are mandatory for the main challen, but not allowed
  for the secondary channel.
  These constraints are not matched in the DT Schema.
  => Any hints how to do this would be appreciated.


Patches made on top of drm-misc-next as of today with no other patches.

(*) Two .txt files reamins:
- display-timing.txt, points to display-timings.yaml
- panel-dsi-cm.txt, conversion is included in another patch-set

	Sam

Sam Ravnborg (36):
      dt-bindings: display: add te-gpios to panel-common
      dt-bindings: spi: support non-spi bindings as SPI slaves
      dt-bindings: display: convert samsung,s6e63m0 to DT Schema
      dt-bindings: display: convert arm,versatile-tft-panel to DT Schema
      dt-bindings: display: convert boe,himax8279d to DT Schema
      dt-bindings: display: convert ilitek,ili9322 to DT Schema
      dt-bindings: display: convert ilitek,ili9881c to DT Schema
      dt-bindings: display: convert feiyang,fy07024di26a30d to DT Schema
      dt-bindings: display: convert innolux,p079zca to DT Schema
      dt-bindings: display: convert innolux,p097pfg to DT Schema
      dt-bindings: display: convert innolux,p120zdg-bf1 to DT Schema
      dt-bindings: display: convert jdi,lt070me05000 to DT Schema
      dt-bindings: display: convert kingdisplay,kd035g6-54nt to DT Schema
      dt-bindings: display: convert kingdisplay,kd097d04 to DT Schema
      dt-bindings: display: convert simple lg panels to DT Schema
      dt-bindings: display: convert lg,lg4573 to DT Schema
      dt-bindings: display: convert osddisplays,osd101t2587-53ts to DT Schema
      dt-bindings: display: convert raydium,rm67191 to DT Schema
      dt-bindings: display: convert rocktech,jh057n00900 to DT Schema
      dt-bindings: display: convert samsung AMOLED to DT Schema
      dt-bindings: display: convert samsung,s6d16d0 to DT Schema
      dt-bindings: display: convert samsung,ld9040 to DT Schema
      dt-bindings: display: convert samsung,s6e8aa0 to DT Schema
      dt-bindings: display: convert toppoly panels to DT Schema
      dt-bindings: display: convert startek,startek-kd050c to DT Schema
      dt-bindings: display: convert sony,acx565akm to DT Schema
      dt-bindings: display: convert sitronix,st7701 to DT Schema
      dt-bindings: display: convert sitronix,st7789v to DT Schema
      dt-bindings: display: drop unused simple-panel.txt
      dt-bindings: display: convert sharp,ls043t1le01 to DT Schema
      dt-bindings: display: convert sharp,lq101r1sx01 to DT Schema
      dt-bindings: display: convert sharp,ls037v7dw01 to DT Schema
      dt-bindings: display: convert sharp,lq150x1lg11 to DT Schema
      dt-bindings: display: convert seiko,43wvf1g to DT Schema
      dt-bindings: display: convert lgphilips,lb035q02 to DT Schema
      dt-bindings: display: convert olimex,lcd-olinuxino to DT Schema

 .../display/panel/arm,versatile-tft-panel.txt      |  31 -------
 .../display/panel/arm,versatile-tft-panel.yaml     |  51 +++++++++++
 .../bindings/display/panel/boe,himax8279d.txt      |  24 -----
 .../bindings/display/panel/boe,himax8279d.yaml     |  59 ++++++++++++
 .../display/panel/feiyang,fy07024di26a30d.txt      |  20 -----
 .../display/panel/feiyang,fy07024di26a30d.yaml     |  56 ++++++++++++
 .../bindings/display/panel/ilitek,ili9322.txt      |  49 ----------
 .../bindings/display/panel/ilitek,ili9322.yaml     |  90 +++++++++++++++++++
 .../bindings/display/panel/ilitek,ili9881c.txt     |  20 -----
 .../bindings/display/panel/ilitek,ili9881c.yaml    |  50 +++++++++++
 .../bindings/display/panel/innolux,p079zca.txt     |  22 -----
 .../bindings/display/panel/innolux,p097pfg.txt     |  24 -----
 .../bindings/display/panel/innolux,p097pfg.yaml    |  56 ++++++++++++
 .../bindings/display/panel/innolux,p120zdg-bf1.txt |  22 -----
 .../display/panel/innolux,p120zdg-bf1.yaml         |  43 +++++++++
 .../bindings/display/panel/jdi,lt070me05000.txt    |  31 -------
 .../bindings/display/panel/jdi,lt070me05000.yaml   |  69 ++++++++++++++
 .../display/panel/kingdisplay,kd035g6-54nt.txt     |  42 ---------
 .../display/panel/kingdisplay,kd035g6-54nt.yaml    |  60 +++++++++++++
 .../display/panel/kingdisplay,kd097d04.txt         |  22 -----
 .../bindings/display/panel/lg,acx467akm-7.txt      |   7 --
 .../bindings/display/panel/lg,ld070wx3-sl01.txt    |   7 --
 .../bindings/display/panel/lg,lg4573.txt           |  19 ----
 .../bindings/display/panel/lg,lg4573.yaml          |  41 +++++++++
 .../bindings/display/panel/lg,lh500wx1-sd03.txt    |   7 --
 .../bindings/display/panel/lgphilips,lb035q02.txt  |  33 -------
 .../bindings/display/panel/lgphilips,lb035q02.yaml |  54 +++++++++++
 .../display/panel/olimex,lcd-olinuxino.txt         |  42 ---------
 .../display/panel/olimex,lcd-olinuxino.yaml        |  70 +++++++++++++++
 .../display/panel/osddisplays,osd101t2587-53ts.txt |  14 ---
 .../bindings/display/panel/panel-common.yaml       |   7 ++
 .../bindings/display/panel/panel-simple-dsi.yaml   |   2 +
 .../bindings/display/panel/panel-simple.yaml       |  10 +++
 .../bindings/display/panel/raydium,rm67191.txt     |  41 ---------
 .../bindings/display/panel/raydium,rm67191.yaml    |  75 ++++++++++++++++
 .../display/panel/rocktech,jh057n00900.txt         |  23 -----
 .../display/panel/rocktech,jh057n00900.yaml        |  57 ++++++++++++
 .../display/panel/samsung,amoled-mipi-dsi.yaml     |  65 ++++++++++++++
 .../bindings/display/panel/samsung,ld9040.txt      |  66 --------------
 .../bindings/display/panel/samsung,ld9040.yaml     | 100 +++++++++++++++++++++
 .../bindings/display/panel/samsung,s6d16d0.txt     |  30 -------
 .../bindings/display/panel/samsung,s6d16d0.yaml    |  56 ++++++++++++
 .../bindings/display/panel/samsung,s6e3ha2.txt     |  31 -------
 .../bindings/display/panel/samsung,s6e63j0x03.txt  |  24 -----
 .../bindings/display/panel/samsung,s6e63m0.txt     |  33 -------
 .../bindings/display/panel/samsung,s6e63m0.yaml    |  58 ++++++++++++
 .../bindings/display/panel/samsung,s6e8aa0.txt     |  56 ------------
 .../bindings/display/panel/samsung,s6e8aa0.yaml    |  96 ++++++++++++++++++++
 .../bindings/display/panel/seiko,43wvf1g.txt       |  23 -----
 .../bindings/display/panel/seiko,43wvf1g.yaml      |  49 ++++++++++
 .../bindings/display/panel/sharp,lq101r1sx01.txt   |  49 ----------
 .../bindings/display/panel/sharp,lq101r1sx01.yaml  |  78 ++++++++++++++++
 .../bindings/display/panel/sharp,lq150x1lg11.txt   |  36 --------
 .../bindings/display/panel/sharp,lq150x1lg11.yaml  |  58 ++++++++++++
 .../bindings/display/panel/sharp,ls037v7dw01.txt   |  43 ---------
 .../bindings/display/panel/sharp,ls037v7dw01.yaml  |  66 ++++++++++++++
 .../bindings/display/panel/sharp,ls043t1le01.txt   |  22 -----
 .../bindings/display/panel/sharp,ls043t1le01.yaml  |  51 +++++++++++
 .../bindings/display/panel/simple-panel.txt        |   1 -
 .../bindings/display/panel/sitronix,st7701.txt     |  30 -------
 .../bindings/display/panel/sitronix,st7701.yaml    |  68 ++++++++++++++
 .../bindings/display/panel/sitronix,st7789v.txt    |  37 --------
 .../bindings/display/panel/sitronix,st7789v.yaml   |  58 ++++++++++++
 .../bindings/display/panel/sony,acx565akm.txt      |  30 -------
 .../bindings/display/panel/sony,acx565akm.yaml     |  53 +++++++++++
 .../display/panel/startek,startek-kd050c.txt       |   4 -
 .../display/panel/startek,startek-kd050c.yaml      |  33 +++++++
 .../devicetree/bindings/display/panel/tpo,td.yaml  |  60 +++++++++++++
 .../bindings/display/panel/tpo,td028ttec1.txt      |  32 -------
 .../bindings/display/panel/tpo,td043mtea1.txt      |  33 -------
 .../devicetree/bindings/spi/spi-controller.yaml    |  63 +------------
 .../devicetree/bindings/spi/spi-slave.yaml         |  83 +++++++++++++++++
 72 files changed, 1885 insertions(+), 1140 deletions(-)
