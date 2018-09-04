From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev_test: Improve decoded text part of hex dump" to the spi tree
Date: Tue,  4 Sep 2018 17:22:49 +0100 (BST)
Message-ID: <20180904162249.7424B11227D8@debutante.sirena.org.uk>
References: <20180903173323.7436-1-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903173323.7436-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spidev_test: Improve decoded text part of hex dump

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

>From 35386dfd13b746daf36a393bdf066dbe9b9b7aed Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 3 Sep 2018 19:33:23 +0200
Subject: [PATCH] spi: spidev_test: Improve decoded text part of hex dump

- Print spaces as spaces,
  - Do not print characters > 126, as they will be shown as garbage
    in the modern UTF-8 era,
  - Use a normal period instead of its hexadecimal ASCII value,
  - Delimit the text part with pipe symbols on both sides (was left side
    only), without any spaces, to make it clear where the decoded text
    starts and ends,
  - Drop a useless comment.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/spi/spidev_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 8c590cd1171a..4c12e6aea5d5 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -73,12 +73,12 @@ static void hex_dump(const void *src, size_t length, size_t line_size,
 				while (i++ % line_size)
 					printf("__ ");
 			}
-			printf(" | ");  /* right close */
+			printf(" |");
 			while (line < address) {
 				c = *line++;
-				printf("%c", (c < 33 || c == 255) ? 0x2E : c);
+				printf("%c", (c < 32 || c > 126) ? '.' : c);
 			}
-			printf("\n");
+			printf("|\n");
 			if (length > 0)
 				printf("%s | ", prefix);
 		}
-- 
2.19.0.rc1
