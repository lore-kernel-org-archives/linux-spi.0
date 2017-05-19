From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: fix issue when tx_buf or rx_buf is NULL" to the spi tree
Date: Fri, 19 May 2017 18:04:54 +0100
Message-ID: <E1dBlKg-0003rX-TX@debutante>
References: <1495101672-3384-1-git-send-email-jiada_wang@mentor.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        leonard.crestez@nxp.com, linux-spi@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495101672-3384-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: fix issue when tx_buf or rx_buf is NULL

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 179547e143e773f9f866ad3536275ab627711f3a Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Thu, 18 May 2017 03:01:12 -0700
Subject: [PATCH] spi: imx: fix issue when tx_buf or rx_buf is NULL

In case either transfer->tx_buf or transfer->rx_buf is NULL,
manipulation of buffer in spi_imx_u32_swap_u[8|16]() will cause
NULL pointer dereference crash.

Add buffer check at very beginning of spi_imx_u32_swap_u[8|16](),
to avoid such crash.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 782045f0d79e..19b30cf7d2b7 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -288,6 +288,9 @@ static void spi_imx_u32_swap_u8(struct spi_transfer *transfer, u32 *buf)
 {
 	int i;
 
+	if (!buf)
+		return;
+
 	for (i = 0; i < transfer->len / 4; i++)
 		*(buf + i) = cpu_to_be32(*(buf + i));
 }
@@ -296,6 +299,9 @@ static void spi_imx_u32_swap_u16(struct spi_transfer *transfer, u32 *buf)
 {
 	int i;
 
+	if (!buf)
+		return;
+
 	for (i = 0; i < transfer->len / 4; i++) {
 		u16 *temp = (u16 *)buf;
 
-- 
2.11.0
