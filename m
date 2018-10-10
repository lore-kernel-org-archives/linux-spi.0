From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 09/11] dt-bindings: spi/spi-pxa2xx: Add ready GPIO signal
Date: Wed, 10 Oct 2018 19:09:34 +0200
Message-ID: <20181010170936.316862-10-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This this is used to let the SPI master know that our FIFO is filled and
we're ready to service a transfer. Only useful in slave mode.

A signal like this is used by an embedded controller on a OLPC XO 1.75
machine, that happens to be a SPI master.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Docum=
entation/devicetree/bindings/spi/spi-pxa2xx.txt
index 89b2832283e3..681a82b40e6f 100644
--- a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
@@ -12,6 +12,8 @@ Optional properties:
 - cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
   Documentation/devicetree/bindings/spi/spi-bus.txt
 - spi-slave: Empty property indicating the SPI controller is used in sla=
ve mode.
+- ready-gpio: GPIO used to signal a SPI master that the FIFO is filled
+  and we're ready to service a transfer. Only useful in slave mode.
=20
 Child nodes represent devices on the SPI bus
   See ../spi/spi-bus.txt
--=20
2.19.0
