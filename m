From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a write
 access
Date: Sat, 2 Feb 2019 04:07:13 +0000
Message-ID: <20190202040653.1217-2-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Tudor.Ambarus@microchip.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Cache Serial Memory Mode (SMM) value to avoid write access when
setting the controller in serial memory mode. SMM is set in
exec_op() and not at probe time, to let room for future regular
SPI support.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: update smm value when different. rename mr/smm
v2: cache MR value instead of moving the write access at probe

 drivers/spi/atmel-quadspi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ddc712410812..645284c6ec9a 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -155,6 +155,7 @@ struct atmel_qspi {
 	struct clk		*clk;
 	struct platform_device	*pdev;
 	u32			pending;
+	u32			smm;
 	struct completion	cmd_completion;
 };
 
@@ -238,7 +239,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	icr = QSPI_ICR_INST(op->cmd.opcode);
 	ifr = QSPI_IFR_INSTEN;
 
-	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+	/* Set the QSPI controller in Serial Memory Mode */
+	if (aq->smm != QSPI_MR_SMM) {
+		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+		aq->smm = QSPI_MR_SMM;
+	}
 
 	mode = find_mode(op);
 	if (mode < 0)
-- 
2.9.5
