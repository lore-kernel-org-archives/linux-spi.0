From: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Subject: [PATCH 00/28] DT: Improve validation for Marvell SoCs
Date: Tue, 17 Mar 2020 10:38:54 +0100
Message-ID: <20200317093922.20785-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
        Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
        Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>,
        Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>,
        Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        devicetree-u79uwXL29TZNg+MwTxZMZA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello World,

chained to this message is a set of patches that improve coverage of Device
Tree validation for devices typically found on Marvell SoCs. It converts most
of the peripheral binding documentation to YAML and fixes up validation issues
in the SoC device trees.

It starts with fixing the issues:

  [PATCH 01/28] ARM: dts: kirkwood: Fix interrupt controller node name
  [PATCH 02/28] ARM: dts: dove: Fix interrupt controller node name
  [PATCH 03/28] ARM: dts: pxa168: Add missing address/size cells to i2c
  [PATCH 04/28] ARM: dts: pxa168: Fix the gpio interrupt cell number
  [PATCH 05/28] ARM: dts: pxa3xx: Fix up encoding of the /gpio
  [PATCH 06/28] ARM: dts: pxa910: Fix the gpio interrupt cell number
  [PATCH 07/28] ARM: dts: pxa*: Fix up encoding of the /rtc interrupts
  [PATCH 08/28] ARM: dts: mmp*: Fix up encoding of the /rtc interrupts
  [PATCH 09/28] ARM: dts: mmp3: fix L2 cache controller node name
  [PATCH 10/28] ARM: dts: mmp3: fix USB & USB PHY node names
  [PATCH 11/28] ARM: dts: berlin*: Fix up the SDHCI node names

Then the binding fixes follow.

When converting .txt binding files that were not written by myself,
I didn't include the SPDX license tag and set the maintaners: to the
devicetree@ list. The reason is that the original binding files don't
contain the information and I didn't want to speak for anyone else and
make it up.

If this is not the correct thing to do, or the respective binding
contributors want to clarify the licensing or be listed as maintainers,
please respond and I'll send an updated patch set. I'm also happy to
maintain any of these bindings.

  [PATCH 12/28] spi: dt-bindings: spi-controller: Slaves have no
  [PATCH 13/28] dt-bindings: serial: move Marvell compatible string to
  [PATCH 14/28] dt-bindings: arm: l2x0: Tauros 3 is PL310 compatible
  [PATCH 15/28] dt-bindings: arm: mrvl: Add missing compatible strings
  [PATCH 16/28] dt-bindings: Add "mrvl", a legacy vendor prefix for
  [PATCH 17/28] dt-bindings: mmc: Fix up clk-phase-sd-hs in an example
  [PATCH 18/28] dt-bindings: mmc: Fix node name in an example
  [PATCH 19/28] dt-bindings: mmc: Convert sdhci-pxa to json-schema
  [PATCH 20/28] dt-bindings: phy: Convert phy-mmp3-usb to json-schema
  [PATCH 21/28] dt-bindings: gpio: Convert mrvl-gpio to json-schema
  [PATCH 22/28] dt-bindings: i2c: Convert i2c-pxa to json-schema
  [PATCH 23/28] dt-bindings: interrupt-controller: Convert mrvl,intc to
  [PATCH 24/28] dt-bindings: media: Convert marvell,mmp2-ccic to
  [PATCH 25/28] dt-bindings: rtc: Convert sa1100-rtc to json-schema
  [PATCH 26/28] dt-bindings: spi: Convert spi-pxa2xx to json-schema
  [PATCH 27/28] dt-bindings: timer: Convert mrvl,mmp-timer to
  [PATCH 28/28] dt-bindings: usb: Convert ehci-mv to json-schema

None of the patches depends on any other and they can be applied in any
order.

Love,
Lubo
