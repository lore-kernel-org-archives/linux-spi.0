From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 1/4] spi: spidev_test: Remove break after exit statement
Date: Thu, 13 Feb 2020 12:16:05 +0800
Message-ID: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When call print_usage() in parse_opts(), it will exit directly.
Since break is not useful after exit statement, remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/spi/spidev_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 3559e76..113b1e1 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -283,7 +283,6 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		default:
 			print_usage(argv[0]);
-			break;
 		}
 	}
 	if (mode & SPI_LOOP) {
-- 
1.8.3.1
