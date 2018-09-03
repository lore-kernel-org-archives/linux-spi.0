From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: spidev_test: Improve decoded text part of hex dump
Date: Mon,  3 Sep 2018 19:33:23 +0200
Message-ID: <20180903173323.7436-1-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

  - Print spaces as spaces,
  - Do not print characters > 126, as they will be shown as garbage
    in the modern UTF-8 era,
  - Use a normal period instead of its hexadecimal ASCII value,
  - Delimit the text part with pipe symbols on both sides (was left side
    only), without any spaces, to make it clear where the decoded text
    starts and ends,
  - Drop a useless comment.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/spi/spidev_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 8c590cd1171a99c2..4c12e6aea5d5d0d1 100644
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
2.17.1
