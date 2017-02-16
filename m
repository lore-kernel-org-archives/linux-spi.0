From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: Fixes bogus received byte in qspi_transfer_in()" to the spi tree
Date: Thu, 16 Feb 2017 19:05:14 +0000
Message-ID: <E1ceRMg-0007wK-V0@debutante>
References: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        geert+renesas@glider.be, linux-spi@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
        ryusuke.sakato.bx@renesas.com, linux-renesas-soc@vger.kernel.org,
        nv-dung@jinso.co.jp, h-inayoshi@jinso.co.jp, cm-hiep@jinso.co.jp,
        linux-spi@vger.kernel.org
To: DongCV <cv-dong@jinso.co.jp>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rspi: Fixes bogus received byte in qspi_transfer_in()

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

>From 7264abc7000d601726aefb05189ea524ee3995ba Mon Sep 17 00:00:00 2001
From: DongCV <cv-dong@jinso.co.jp>
Date: Wed, 15 Feb 2017 19:50:51 +0900
Subject: [PATCH] spi: rspi: Fixes bogus received byte in qspi_transfer_in()

In qspi_transfer_in(), when receiving the last n (or len) bytes of data,
one bogus byte was written in the receive buffer.
This code leads to a buffer overflow.

"jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found
at 0x03b40000: 0x1900 instead
jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found
at 0x03b40004: 0x000c instead"

The error message above happens when trying to mount, unmount,
and remount a jffs2-formatted device.
This patch removed the bogus write to fixes: 3be09bec42a800d4
"spi: rspi: supports 32bytes buffer for DUAL and QUAD"

And here is Geert's comment:

"spi: rspi: Fix bogus received byte in qspi_transfer_in()
When there are less than QSPI_BUFFER_SIZE remaining bytes to be received,
qspi_transfer_in() writes one bogus byte in the receive buffer, possibly
leading to a buffer overflow.
This can be reproduced by mounting, unmounting, and remounting a
jffs2-formatted device, causing lots of warnings like:

"jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found
at 0x03b40000: 0x1900 instead"

Remove the bogus write to fix this. "

Signed-off-by: DongCV <cv-dong@jinso.co.jp>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 9daf50031737..2ee130138066 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -848,7 +848,6 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 			ret = rspi_pio_transfer(rspi, NULL, rx, n);
 			if (ret < 0)
 				return ret;
-			*rx++ = ret;
 		}
 		n -= len;
 	}
-- 
2.11.0
