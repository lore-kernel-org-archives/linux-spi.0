From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V3 4/4] doc: lpspi: Document DT bindings for LPSPI slave mode
Date: Fri, 7 Dec 2018 02:50:41 +0000
Message-ID: <20181207024924.6315-5-xiaoning.wang@nxp.com>
References: <20181207024924.6315-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207024924.6315-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add introductions of interrupt-parent and spi-slave.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Change log:
V2:
 - No change.
V3:
 - Keep the description of "fsl,imx8qxp-spi" in spi-fsl-lpspi.txt.
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Docu=
mentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 8d178a4503cf..6cc3c6fe25a3 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -5,8 +5,11 @@ Required properties:
   - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX=
7ULP soc
   - "fsl,imx8qxp-spi" for LPSPI compatible with the one integrated on i.MX=
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
@@ -16,4 +19,5 @@ lpspi2: lpspi@40290000 {
 	interrupt-parent =3D <&intc>;
 	interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 	clocks =3D <&clks IMX7ULP_CLK_LPSPI2>;
+	spi-slave;
 };
--=20
2.17.1
