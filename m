From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 4/4] doc: lpspi: Document DT bindings for LPSPI slave mode
Date: Fri, 30 Nov 2018 04:29:12 +0000
Message-ID: <20181130042753.28756-5-xiaoning.wang@nxp.com>
References: <20181130042753.28756-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130042753.28756-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Remove "fsl,imx8qxp-spi", it does not exist in spi-fsl-lpspi.c driver
for now.

Add introductions of interrupt-parent and spi-slave.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Docu=
mentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 8d178a4503cf..9e44d85e0a68 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -3,10 +3,12 @@
 Required properties:
 - compatible :
   - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX=
7ULP soc
-  - "fsl,imx8qxp-spi" for LPSPI compatible with the one integrated on i.MX=
8QXP soc
 - reg : address and length of the lpspi master registers
+- interrupt-parent : core interrupt controller
 - interrupts : lpspi interrupt
 - clocks : lpspi clock specifier
+- spi-slave : spi slave mode support. In slave mode, add this attribute wi=
thout
+	      value. In master mode, remove it.
=20
 Examples:
=20
@@ -16,4 +18,5 @@ lpspi2: lpspi@40290000 {
 	interrupt-parent =3D <&intc>;
 	interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 	clocks =3D <&clks IMX7ULP_CLK_LPSPI2>;
+	spi-slave;
 };
--=20
2.17.1
