From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Prevent unexpected SPI time out due to arithmetic overflow" to the spi tree
Date: Sat, 03 Sep 2016 12:08:49 +0100
Message-ID: <E1bg8ob-0003kb-Vi@finisterre>
References: <1472772269-44752-1-git-send-email-sien.wu@ni.com>
Cc: Brad Keryan <brad.keryan@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Brad Mouring <brad.mouring@ni.com>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sien Wu <sien.wu@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472772269-44752-1-git-send-email-sien.wu@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Prevent unexpected SPI time out due to arithmetic overflow

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

>From d0716dde375eb6bff332763bb2137302120d263d Mon Sep 17 00:00:00 2001
From: Sien Wu <sien.wu@ni.com>
Date: Thu, 1 Sep 2016 18:24:29 -0500
Subject: [PATCH] spi: Prevent unexpected SPI time out due to arithmetic
 overflow

When reading SPI flash as MTD device, the transfer length is
directly passed to the spi driver. If the requested data size
exceeds 512KB, it will cause the time out calculation to
overflow since transfer length is 32-bit unsigned integer.
This issue is resolved by using 64-bit unsigned integer
to perform the arithmetic.

Signed-off-by: Sien Wu <sien.wu@ni.com>
Acked-by: Brad Keryan <brad.keryan@ni.com>
Acked-by: Gratian Crisan <gratian.crisan@ni.com>
Acked-by: Brad Mouring <brad.mouring@ni.com>

Natinst-ReviewBoard-ID 150232
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51ad42fad567..ac889df9b1f3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -960,7 +960,7 @@ static int spi_transfer_one_message(struct spi_master *master,
 	struct spi_transfer *xfer;
 	bool keep_cs = false;
 	int ret = 0;
-	unsigned long ms = 1;
+	unsigned long long ms = 1;
 	struct spi_statistics *statm = &master->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
 
@@ -991,9 +991,13 @@ static int spi_transfer_one_message(struct spi_master *master,
 
 			if (ret > 0) {
 				ret = 0;
-				ms = xfer->len * 8 * 1000 / xfer->speed_hz;
+				ms = 8LL * 1000LL * xfer->len;
+				do_div(ms, xfer->speed_hz);
 				ms += ms + 100; /* some tolerance */
 
+				if (ms > UINT_MAX)
+					ms = UINT_MAX;
+
 				ms = wait_for_completion_timeout(&master->xfer_completion,
 								 msecs_to_jiffies(ms));
 			}
-- 
2.9.3
