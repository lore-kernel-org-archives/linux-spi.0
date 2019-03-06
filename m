From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 2/8] doc: lpspi: Document DT bindings for LPSPI clocks
Date: Wed, 6 Mar 2019 06:30:36 +0000
Message-ID: <20190306063020.793-3-xiaoning.wang@nxp.com>
References: <20190306063020.793-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306063020.793-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add introductions of clocks and clock-names strings.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2:
 - Add this DT-bindings string in this version.
---
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt          | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Docu=
mentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 6cc3c6fe25a3..e71b81a41ac0 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -7,7 +7,11 @@ Required properties:
 - reg : address and length of the lpspi master registers
 - interrupt-parent : core interrupt controller
 - interrupts : lpspi interrupt
-- clocks : lpspi clock specifier
+- clocks : lpspi clock specifier. Its number and order need to correspond =
to the
+	   value in clock-names.
+- clock-names : Corresponding to per clock and ipg clock in "clocks"
+		respectively. In i.MX7ULP, it only has per clk, so use CLK_DUMMY
+		to fill the "ipg" blank.
 - spi-slave : spi slave mode support. In slave mode, add this attribute wi=
thout
 	      value. In master mode, remove it.
=20
@@ -18,6 +22,8 @@ lpspi2: lpspi@40290000 {
 	reg =3D <0x40290000 0x10000>;
 	interrupt-parent =3D <&intc>;
 	interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-	clocks =3D <&clks IMX7ULP_CLK_LPSPI2>;
+	clocks =3D <&clks IMX7ULP_CLK_LPSPI2>,
+		 <&clks IMX7ULP_CLK_DUMMY>;
+	clock-names =3D "per", "ipg";
 	spi-slave;
 };
--=20
2.17.1
