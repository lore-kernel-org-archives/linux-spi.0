From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev_test: Fix buffer overflow in unescape()" to the spi tree
Date: Wed, 14 Sep 2016 18:16:58 +0100
Message-ID: <E1bkDnu-00021Q-9B@debutante>
References: <1473404571-27302-1-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, <stable@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Adrian Remonda <adrianremonda@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473404571-27302-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spidev_test: Fix buffer overflow in unescape()

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

>From 0278b34bf15f8d8a609595b15909cd8622dd64ca Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 9 Sep 2016 09:02:51 +0200
Subject: [PATCH] spi: spidev_test: Fix buffer overflow in unescape()

Sometimes spidev_test crashes with:

    *** Error in `spidev_test': munmap_chunk(): invalid pointer: 0x00022020 ***
    Aborted

or just

    Segmentation fault

This is due to transfer_escaped_string() miscalculating the required
size of the buffer by one byte, causing a buffer overflow in unescape().

Drop the bogus "+ 1" in the strlen() parameter to fix this.

Note that unescape() never copies the zero-terminator of the source
string, so it writes at most as many bytes as the length of the source
string.

Fixes: 30061915be6e3a2c (spi: spidev_test: Added input buffer from the terminal)
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # v4.5+
---
 tools/spi/spidev_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 8a73d8185316..f3825b676e38 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -284,7 +284,7 @@ static void parse_opts(int argc, char *argv[])
 
 static void transfer_escaped_string(int fd, char *str)
 {
-	size_t size = strlen(str + 1);
+	size_t size = strlen(str);
 	uint8_t *tx;
 	uint8_t *rx;
 
-- 
2.8.1
