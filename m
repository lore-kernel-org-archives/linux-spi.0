From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 01/10] spi: atmel-quadspi: cache MR value to avoid a write
 access
Date: Thu, 31 Jan 2019 16:15:28 +0000
Message-ID: <20190131161515.21605-2-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Cache MR value to avoid write access when setting the controller
in Serial Memory Mode (SMM). SMM is set in exec_op() and not at
probe time, to let room for future regular SPI support.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: cache MR value instead of moving the write access at probe

 drivers/spi/atmel-quadspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ddc712410812..fe05aee5d845 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -155,6 +155,7 @@ struct atmel_qspi {
 	struct clk		*clk;
 	struct platform_device	*pdev;
 	u32			pending;
+	u32			mr;
 	struct completion	cmd_completion;
 };
=20
@@ -238,7 +239,9 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
 	icr =3D QSPI_ICR_INST(op->cmd.opcode);
 	ifr =3D QSPI_IFR_INSTEN;
=20
-	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+	/* Set the QSPI controller in Serial Memory Mode */
+	if (!(aq->mr & QSPI_MR_SMM))
+		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
=20
 	mode =3D find_mode(op);
 	if (mode < 0)
--=20
2.9.5
