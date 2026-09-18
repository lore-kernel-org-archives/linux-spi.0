Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8131ED68;
	Fri, 18 Sep 2026 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735525; cv=none; b=YXX8H+funiJM/qpNgN4QayIFQCE/PxCAQVjfExeaKmxaJjRGjHQUJ6Vx+HqWdbk0gS46WwpeyjLoWHx+FaU2SqG0TsVR/cI95vH9me39HR2Jro36sIOsszXCp5UGm2DOsfBUjKsPno4AWElgLly5bFXSdtREjfeRsiwm8fmQATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735525; c=relaxed/simple;
	bh=lL2jZIYpO1vPss0VZ4p9UtwigPPNIA3ViXaTdD7+kvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VITUgfsyZKzn/PCOdg/1RCkgwbinBFeUQIs5Uay+S6m0HU66TLJZ2HPQoOhnNCzPnbKbFkZUN2y4JKOiVtbEOpCFVNCz02vMPJ4snH84V9mLu8YQSKUJpEKdHNKVmJEgwr4YttpB/HUNy0G61IZEAd4B8lyLiFHaIS1QEpg1yb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 70014200F8D;
	Fri, 18 Sep 2026 14:45:12 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7Xxo-001Zaf-1A;
	Fri, 18 Sep 2026 14:45:12 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 14:45:00 +0200
Subject: [PATCH v3 6/8] spi: spidev_test: add option to split message into
 multiple transfers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v3-6-d3ca218d9f76@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5463; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=AVd0wt8oBnIsqup0WQuJyg/UhmMqYW9BJzq+5osopo8=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaaxR29e/DXSZP+tv51973cl/WMJ3B+0JLRPvyjJKfK
 bPSDt5M7yhlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAExkxiOGf7riv9uLVR0LLle8
 3pPurPXrII81y7O7wY5ThZnNZ67VcWD4K7Mpce3RxT+teaZWPpyVskSlT7bvRPDtz0570i283PM
 MmAA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

SPI_IOC_MESSAGE() submits a single SPI message containing one or more
transfers. Introduce an option to allow splitting the message into
multiple transfers.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 95 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 31 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 011ac0593736..6fb67021ae14 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -42,6 +42,7 @@ static uint16_t delay;
 static uint16_t word_delay;
 static int verbose;
 static int transfer_size;
+static int transfers = 1;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
@@ -118,40 +119,61 @@ static int unescape(char *_dst, char *_src, size_t len)
 	return ret;
 }
 
-static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
+static void transfer(int fd, uint8_t const * const tx, uint8_t const * const rx, size_t len)
 {
 	int ret;
 	int out_fd;
-	struct spi_ioc_transfer tr = {
-		.tx_buf = (unsigned long)tx,
-		.rx_buf = (unsigned long)rx,
-		.len = len,
-		.delay_usecs = delay,
-		.word_delay_usecs = word_delay,
-		.speed_hz = speed,
-		.bits_per_word = bits,
-	};
-
-	if (mode & SPI_TX_OCTAL)
-		tr.tx_nbits = 8;
-	else if (mode & SPI_TX_QUAD)
-		tr.tx_nbits = 4;
-	else if (mode & SPI_TX_DUAL)
-		tr.tx_nbits = 2;
-	if (mode & SPI_RX_OCTAL)
-		tr.rx_nbits = 8;
-	else if (mode & SPI_RX_QUAD)
-		tr.rx_nbits = 4;
-	else if (mode & SPI_RX_DUAL)
-		tr.rx_nbits = 2;
-	if (!(mode & SPI_LOOP)) {
-		if (mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
-			tr.rx_buf = 0;
-		else if (mode & (SPI_RX_OCTAL | SPI_RX_QUAD | SPI_RX_DUAL))
-			tr.tx_buf = 0;
+	size_t bytes_per_word = DIV_ROUND_UP(bits, 8);
+	int effective_transfers = min_t(int, transfers, DIV_ROUND_UP(len, bytes_per_word));
+	struct spi_ioc_transfer *tr = calloc(effective_transfers, sizeof(*tr));
+	size_t len_per_transfer = roundup(DIV_ROUND_UP(len, effective_transfers), bytes_per_word);
+	const uint8_t *tx_buf = tx;
+	const uint8_t *rx_buf = rx;
+	size_t rem = len;
+
+	for (int i = 0; i < effective_transfers; i++) {
+		size_t n = min(rem, len_per_transfer);
+
+		tr[i] = (struct spi_ioc_transfer) {
+			.tx_buf = (unsigned long)tx_buf,
+			.rx_buf = (unsigned long)rx_buf,
+			.len = n,
+			.delay_usecs = delay,
+			.word_delay_usecs = word_delay,
+			.speed_hz = speed,
+			.bits_per_word = bits,
+		};
+
+		if (tx_buf)
+			tx_buf += n;
+
+		if (rx_buf)
+			rx_buf += n;
+
+		rem -= n;
+
+		if (mode & SPI_TX_OCTAL)
+			tr[i].tx_nbits = 8;
+		else if (mode & SPI_TX_QUAD)
+			tr[i].tx_nbits = 4;
+		else if (mode & SPI_TX_DUAL)
+			tr[i].tx_nbits = 2;
+		if (mode & SPI_RX_OCTAL)
+			tr[i].rx_nbits = 8;
+		else if (mode & SPI_RX_QUAD)
+			tr[i].rx_nbits = 4;
+		else if (mode & SPI_RX_DUAL)
+			tr[i].rx_nbits = 2;
+		if (!(mode & SPI_LOOP)) {
+			if (mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
+				tr[i].rx_buf = 0;
+			else if (mode & (SPI_RX_OCTAL | SPI_RX_QUAD | SPI_RX_DUAL))
+				tr[i].tx_buf = 0;
+		}
 	}
 
-	ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
+	ret = ioctl(fd, SPI_IOC_MESSAGE(effective_transfers), &tr);
+	free(tr);
 	if (ret < 1)
 		pabort("can't send spi message");
 
@@ -176,7 +198,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNOPRSZbcdiloprstvwz]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNOPRSTZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -211,6 +233,7 @@ static void print_usage(const char *prog)
 		 "  -N --no-cs          no chip select\n"
 		 "  -R --ready          slave pulls low to pause\n"
 		 "  -M --mosi-idle-low  leave mosi line low when idle\n"
+		 "  -T --transfers      number of transfers\n"
 		 "misc:\n"
 		 "  -v --verbose        Verbose (show tx buffer)\n");
 	exit(1);
@@ -248,12 +271,13 @@ static void parse_opts(int argc, char *argv[])
 			{ "ready",         0, 0, 'R' },
 			{ "mosi-idle-low", 0, 0, 'M' },
 			{ "predictable",   0, 0, 'P' },
+			{ "transfers",     1, 0, 'T' },
 			{ "verbose",       0, 0, 'v' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:PvS:zI:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:PT:vS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -320,6 +344,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'M':
 			mode |= SPI_MOSI_IDLE_LOW;
 			break;
+		case 'T':
+			transfers = atoi(optarg);
+			break;
 		case 'N':
 			mode |= SPI_NO_CS;
 			break;
@@ -506,6 +533,12 @@ int main(int argc, char *argv[])
 	if (compare && mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
 		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");
 
+	if (transfers < 1)
+		pabort("-T (--transfers) must be 1 or above");
+
+	if (bits < 1)
+		pabort("-b (--bpw) must be 1 or above");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");

-- 
2.56.0.rc0.108.gf0ef1b96a0

