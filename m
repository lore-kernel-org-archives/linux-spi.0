From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-mem: Fix typo, s/fallback/falls back" to the spi tree
Date: Mon, 17 Feb 2020 22:04:32 +0000
Message-ID: <applied-20200216214012.1106658-1-tudor.ambarus@microchip.com>
References: <20200216214012.1106658-1-tudor.ambarus@microchip.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
To: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200216214012.1106658-1-tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-mem: Fix typo, s/fallback/falls back

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 32a9d0545c5da9717395264de9b8e004e4b90893 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Date: Sun, 16 Feb 2020 21:40:17 +0000
Subject: [PATCH] spi: spi-mem: Fix typo, s/fallback/falls back

"Fallback" in one word is a noun. "Fall back" is two separate words,
a verb and an adverb. Use the latter.

Signed-off-by: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Link: https://lore.kernel.org/r/20200216214012.1106658-1-tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e5a46f0eb93b..3c46747bacb1 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -487,7 +487,7 @@ static ssize_t spi_mem_no_dirmap_write(struct spi_mem_dirmap_desc *desc,
  * This function is creating a direct mapping descriptor which can then be used
  * to access the memory using spi_mem_dirmap_read() or spi_mem_dirmap_write().
  * If the SPI controller driver does not support direct mapping, this function
- * fallback to an implementation using spi_mem_exec_op(), so that the caller
+ * falls back to an implementation using spi_mem_exec_op(), so that the caller
  * doesn't have to bother implementing a fallback on his own.
  *
  * Return: a valid pointer in case of success, and ERR_PTR() otherwise.
-- 
2.20.1
