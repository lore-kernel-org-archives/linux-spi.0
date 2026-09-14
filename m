Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE484749CA;
	Mon, 14 Sep 2026 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397465; cv=none; b=WdeF5PZTBZiV1njy/05GNuOeMU5eyRPUBV2lHXPNLA6Fy8nfjPbiqoiC9kTmTWGP8YUxR/U7hlC1hY5wUcTDccWgPz8zZY5f3NIWf/Jv4zIAekEQnTsW+W6XqpTjluiwfLlFyc0ZB5ynLWRx8UvsUYrHtDdFnl2V7K4IXn7fqmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397465; c=relaxed/simple;
	bh=xzOM3ZG6BBdAVvei+7OCZ7A1aQ+fKf85l8a8QbuoTAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rYIKMO1YI+MSvGw5gSgfWH5dhwpald0NxRcKznhGK0QXOfo0CcLaRKclph87CnJjrgshRpE4W0GoHLT1CZFNDiiAZgCXM1JinRh0y71itbuXgeV/BsyxhElxP53UqSIJVrMgksQSxuHgAR5kD3VGqEK+usdwgACADpFkGHwm6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: mkl@pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 25BC720288C;
	Mon, 14 Sep 2026 16:50:55 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x681H-000v8b-0E;
	Mon, 14 Sep 2026 16:50:55 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 14 Sep 2026 16:50:42 +0200
Subject: [PATCH 3/7] spi: spidev_test: allow disabling rx or tx buffers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-spi-sun4i-spidev_test-v1-3-72d6a3b38cee@pengutronix.de>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4566; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=IxSynNpkgLnYZ2HICPr4FpfrFG088jeXVjhYis3uIdY=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshawXlmDlPVS66C9nf+bn//r4naeYtnZkfAmZw1Vq2Cj
 S21CQvmd5SyMIhxMciKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACby9wojwzq35jPqb/rfL+vK
 e2G2fePd9IzpDatzGJ4cEOs2kNU+94WR4U9r990TvulPqqPidsyt87/A9DzM4MjhuJxF5fKhUzh
 vcgMA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Allow not providing rx or tx buffers. This is useful to check if drivers
that don't use SPI_CONTROLLER_MUST_RX (or -TX respectively) handle their
operations correctly without a buffer.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 61 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 05c585ea71b2..6b0e839e6c33 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -47,6 +47,7 @@ static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
+static int do_tx = 1, do_rx = 1;
 
 static uint8_t default_tx[] = {
 	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
@@ -153,10 +154,10 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 	if (ret < 1)
 		pabort("can't send spi message");
 
-	if (verbose)
+	if (verbose && tx)
 		hex_dump(tx, len, 32, "TX");
 
-	if (output_file) {
+	if (rx && output_file) {
 		out_fd = open(output_file, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 		if (out_fd < 0)
 			pabort("could not open output file");
@@ -168,13 +169,13 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 		close(out_fd);
 	}
 
-	if (verbose)
+	if (verbose && rx)
 		hex_dump(rx, len, 32, "RX");
 }
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbdilcopsvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbdilctropsvw]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -182,6 +183,8 @@ static void print_usage(const char *prog)
 		 "  -w --word-delay     word delay (usec)\n"
 		 "  -l --loop           loopback\n"
 		 "  -c --compare        compare RX'ed and TX'ed data\n"
+		 "  -t --no-tx          don't send data\n"
+		 "  -r --no-rx          don't receive data\n"
 		 "spi mode:\n"
 		 "  -H --cpha           clock phase\n"
 		 "  -O --cpol           clock polarity\n"
@@ -220,6 +223,8 @@ static void parse_opts(int argc, char *argv[])
 			{ "word-delay",    1, 0, 'w' },
 			{ "loop",          0, 0, 'l' },
 			{ "compare",       0, 0, 'c' },
+			{ "no-tx",         0, 0, 't' },
+			{ "no-rx",         0, 0, 'r' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
 			{ "rx-cpha-flip",  0, 0, 'F' },
@@ -243,7 +248,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lcHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -278,6 +283,12 @@ static void parse_opts(int argc, char *argv[])
 		case 'c':
 			compare = 1;
 			break;
+		case 't':
+			do_tx = 0;
+			break;
+		case 'r':
+			do_rx = 0;
+			break;
 		case 'H':
 			mode |= SPI_CPHA;
 			break;
@@ -415,26 +426,31 @@ static void show_transfer_rate(void)
 
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
@@ -455,8 +471,11 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (input_tx && input_file)
-		pabort("only one of -p and --input may be selected");
+	if (!!input_tx + !!input_file + !do_tx > 0)
+		pabort("only one of -p, -i (--input), -t (--no-tx) may be selected");
+
+	if (compare && (!do_tx || !do_rx))
+		pabort("-l/-c conflict with -t or -r");
 
 	fd = open(device, O_RDWR);
 	if (fd < 0)

-- 
2.55.0.806.gb8242b093d

