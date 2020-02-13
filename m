From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 2/4] spi: spidev_test: Check input_tx and input_file first after parse options
Date: Thu, 13 Feb 2020 12:16:06 +0800
Message-ID: <1581567368-8055-2-git-send-email-yangtiezhu@loongson.cn>
References: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

It is better to check input_tx and input_file first after parse options.
Otherwise, it will do some useless operations when both -p and --input
are selected.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/spi/spidev_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 113b1e1..5866178 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -404,6 +404,9 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
+	if (input_tx && input_file)
+		pabort("only one of -p and --input may be selected");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");
@@ -445,9 +448,6 @@ int main(int argc, char *argv[])
 	printf("bits per word: %d\n", bits);
 	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
 
-	if (input_tx && input_file)
-		pabort("only one of -p and --input may be selected");
-
 	if (input_tx)
 		transfer_escaped_string(fd, input_tx);
 	else if (input_file)
-- 
1.8.3.1
