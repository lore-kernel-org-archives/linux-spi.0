From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH 1/9] spi: atmel-quadspi: optimize qspi init
Date: Wed, 30 Jan 2019 15:08:29 +0000
Message-ID: <20190130150818.24902-2-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Set the QSPI controller in Serial Memory Mode at init and not
at each exec_op() call.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ddc712410812..f79b17792a11 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -238,8 +238,6 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
 	icr =3D QSPI_ICR_INST(op->cmd.opcode);
 	ifr =3D QSPI_IFR_INSTEN;
=20
-	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
-
 	mode =3D find_mode(op);
 	if (mode < 0)
 		return -ENOTSUPP;
@@ -381,6 +379,9 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 	/* Reset the QSPI controller */
 	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
=20
+	/* Set the QSPI controller in Serial Memory Mode */
+	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+
 	/* Enable the QSPI controller */
 	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
=20
--=20
2.9.5
