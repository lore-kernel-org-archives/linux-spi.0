From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 1/6] spi: pxa2xx: dt-bindings: Add spi-slave property
Date: Tue, 13 Nov 2018 11:22:23 +0100
Message-ID: <20181113102228.820214-2-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
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
In-Reply-To: <20181113102228.820214-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is used to indicate that the chip attached to this controller is a S=
PI
master.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- Updated the subject line to conform with subsystem customs

 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Docum=
entation/devicetree/bindings/spi/spi-pxa2xx.txt
index 0335a9bd2e8a..89b2832283e3 100644
--- a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
@@ -11,6 +11,7 @@ Required properties:
 Optional properties:
 - cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
   Documentation/devicetree/bindings/spi/spi-bus.txt
+- spi-slave: Empty property indicating the SPI controller is used in sla=
ve mode.
=20
 Child nodes represent devices on the SPI bus
   See ../spi/spi-bus.txt
--=20
2.19.1
