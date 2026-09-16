Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535B4D957E;
	Wed, 16 Sep 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580507; cv=none; b=VWlT0CqKM8dWl32YE2ymk65cLyhEUj/S3CPnHDEXDPc4XZoqK1XIjPk/lw/uvzwpGfrfQpAzfFhyOwm+gFGCD9AVB6sTAnTh7BvNWkoPwMug9G9EFrZz4mF4QbnBBlOiJreKzWarNBZvCGufupS/AjS9Q9fox0PgwKt2kNmWLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580507; c=relaxed/simple;
	bh=nEZScjsdudW8G7BwAH++bkryBsvgnsHuy1SUvnKB7vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GB/JQCqMsRmh29BsdiY08UGLn1x9bl45SQB9pjZC+6pZlQdYVfyWXGAc47j8FfISpNYDYoWnlzxwkp6pk+zhZEpkmlhzNoYyCFVJ5StJSislJESX2PHGSSO0LIZzJTqKLClAUrvbgAYYtw0uMCA4xXe/RzHo++krOt7Dj4+R1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A6FE32028FE;
	Wed, 16 Sep 2026 19:41:29 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6tdR-001Gol-1q;
	Wed, 16 Sep 2026 19:41:29 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 16 Sep 2026 19:41:21 +0200
Subject: [PATCH v2 3/8] spi: spidev_test: allow disabling rx or tx buffers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-spi-sun4i-spidev_test-v2-3-e7d25bf96e4e@pengutronix.de>
References: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
In-Reply-To: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5060; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=B7Bob2z1fLivMiEbkpNc/kLd83K0wg1xz/m/FnhpTws=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadeXYysUhb6L6j2s/ydikNO1/ofUMSeHOo+F8vDtZ+
 7I67gSt7ihlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAExE8wYjQ39eZcDtBq30jltJ
 s62lD83cc/yhy/EHETvLbxkmril5x8PwvzavYUVm1KR7T2fcdX2ewSd1M6nm7OS8xRYrZktmBMW
 E8gIA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Allow not providing rx or tx buffers. This is useful to check if drivers
that don't use SPI_CONTROLLER_MUST_RX (or -TX respectively) handle their
operations correctly without a buffer.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 66 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 6ff103bdea5c..b4f9c40a246a 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -47,6 +47,8 @@ static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
+static int do_tx = 1, do_rx = 1;
+static int input_choices = 0;
 
 static uint8_t default_tx[] = {
 	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
@@ -153,7 +155,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 	if (ret < 1)
 		pabort("can't send spi message");
 
-	if (verbose)
+	if (verbose && tx)
 		hex_dump(tx, len, 32, "TX");
 
 	if (output_file) {
@@ -168,13 +170,13 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 		close(out_fd);
 	}
 
-	if (verbose)
+	if (verbose && rx)
 		hex_dump(rx, len, 32, "RX");
 }
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbcdilopsvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvw]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -182,6 +184,8 @@ static void print_usage(const char *prog)
 		 "  -w --word-delay     word delay (usec)\n"
 		 "  -l --loop           loopback\n"
 		 "  -c --compare        compare RX'ed and TX'ed data\n"
+		 "  -t --no-tx          don't send data\n"
+		 "  -r --no-rx          don't receive data\n"
 		 "spi mode:\n"
 		 "  -H --cpha           clock phase\n"
 		 "  -O --cpol           clock polarity\n"
@@ -220,6 +224,8 @@ static void parse_opts(int argc, char *argv[])
 			{ "word-delay",    1, 0, 'w' },
 			{ "loop",          0, 0, 'l' },
 			{ "compare",       0, 0, 'c' },
+			{ "no-tx",         0, 0, 't' },
+			{ "no-rx",         0, 0, 'r' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
 			{ "rx-cpha-flip",  0, 0, 'F' },
@@ -243,7 +249,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lcHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -267,6 +273,7 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'i':
 			input_file = optarg;
+			input_choices++;
 			break;
 		case 'o':
 			output_file = optarg;
@@ -278,6 +285,13 @@ static void parse_opts(int argc, char *argv[])
 		case 'c':
 			compare = 1;
 			break;
+		case 't':
+			do_tx = 0;
+			input_choices++;
+			break;
+		case 'r':
+			do_rx = 0;
+			break;
 		case 'H':
 			mode |= SPI_CPHA;
 			break;
@@ -313,6 +327,7 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'p':
 			input_tx = optarg;
+			input_choices++;
 			break;
 		case '2':
 			mode |= SPI_TX_DUAL;
@@ -415,26 +430,31 @@ static void show_transfer_rate(void)
 
 static void transfer_buf(int fd, int len)
 {
-	uint8_t *tx;
-	uint8_t *rx;
+	uint8_t *tx = NULL;
+	uint8_t *rx = NULL;
 	int i;
 
-	tx = malloc(len);
-	if (!tx)
-		pabort("can't allocate tx buffer");
-	for (i = 0; i < len; i++)
-		tx[i] = random();
+	if (do_tx) {
+		tx = malloc(len);
+		if (!tx)
+			pabort("can't allocate tx buffer");
+		for (i = 0; i < len; i++)
+			tx[i] = random();
+	}
 
-	rx = malloc(len);
-	if (!rx)
-		pabort("can't allocate rx buffer");
+	if (do_rx) {
+		rx = malloc(len);
+		if (!rx)
+			pabort("can't allocate rx buffer");
+	}
 
 	transfer(fd, tx, rx, len);
+	if (do_tx)
+		_write_count += len;
+	if (do_rx)
+		_read_count += len;
 
-	_write_count += len;
-	_read_count += len;
-
-	if (compare) {
+	if (tx && rx && compare) {
 		if (memcmp(tx, rx, len)) {
 			fprintf(stderr, "transfer error !\n");
 			hex_dump(tx, len, 32, "TX");
@@ -455,8 +475,14 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (input_tx && input_file)
-		pabort("only one of -p and --input may be selected");
+	if (input_choices > 1)
+		pabort("only one of -p, -i (--input), -t (--no-tx) may be selected");
+
+	if (compare && (!do_tx || !do_rx))
+		pabort("-l/-c (--loop/--compare) conflict with -t (--no-tx) or -r (--no-rx)");
+
+	if (!do_rx && output_file)
+		pabort("-t (--no-rx) conflicts with -o (--output)");
 
 	if (compare & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
 		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");

-- 
2.56.0.rc0.108.gf0ef1b96a0

