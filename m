Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1547A86D;
	Mon, 14 Sep 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397477; cv=none; b=K9d5K9VSKSa1bbm9xubXRYpAYj1EkYPwGbFjgxIH30kaH+yuAZZfOHGg0gUxJupL03n7V2y+X/IfkqUTb1p5+9cEleZ7lvMbdooXDLW2Vb3yfvcwxKDPW2fRRH3DObR2azw9In9eV1U6sukImgHvB/GGbeOELEMipNUmJnCB2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397477; c=relaxed/simple;
	bh=l3avz/FqlB79E9kXobJeIMzG6Fvuv1Qeruk6A75D/Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaw1Duam1DK6tdWKCBnMEKc2sGvCWD5Ytt98gECsIQY+pPrHFlWAGlLccN0l1NoezIuBn4dSA4zn3pAAPyJgcH9nHLNCvWpI2jQakLh+cQCQKvDbNorSVxySTD+7gBxDCq/Ki5IxGqzS4PL4ssdR+PBk0/x0cx5SHSEoXB9pHlc=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4AFAE202898;
	Mon, 14 Sep 2026 16:50:55 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x681H-000v8b-0h;
	Mon, 14 Sep 2026 16:50:55 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 14 Sep 2026 16:50:45 +0200
Subject: [PATCH 6/7] spi: spidev_test: add option to split message into
 multiple transfers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-spi-sun4i-spidev_test-v1-6-72d6a3b38cee@pengutronix.de>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5458; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=cNqtmNrTU9HVG2vg2OJLDqD4ZJlwmlN4/O2gig/M2pA=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshawXl2J98j812BL+PNgtcZPnSLPLo+769/wR+9jQsyH
 b/Nay7V7ShlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAExEcC0jQ4urjdBOZ77dd9nl
 hObOXaTnvUfBMthxsXHrwZXff7zsnMHwv+yzeL1GyV8X8zlyNbOWnnT+yyjhu3Bn8b77kic3hbL
 z8gEA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

SPI_IOC_MESSAGE() submits a single SPI message containing one or more
transfers. Introduce an option to allow splitting the message into
multiple transfers.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 92 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 31 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 4d35ac0d9a48..a07c05f2d8b8 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 #include <linux/spi/spidev.h>
 #include <linux/kernel.h>
+#include <linux/align.h>
 
 static void pabort(const char *s)
 {
@@ -44,6 +45,7 @@ static uint16_t delay;
 static uint16_t word_delay;
 static int verbose;
 static int transfer_size;
+static int transfers = 1;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
@@ -119,40 +121,60 @@ static int unescape(char *_dst, char *_src, size_t len)
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
+	struct spi_ioc_transfer tr[effective_transfers];
+	size_t len_per_transfer = ALIGN(DIV_ROUND_UP(len, effective_transfers), bytes_per_word);
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
 	if (ret < 1)
 		pabort("can't send spi message");
 
@@ -177,7 +199,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbdilctropsvwzP]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbdilctropsvwTzP]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -212,6 +234,7 @@ static void print_usage(const char *prog)
 		 "  -N --no-cs          no chip select\n"
 		 "  -R --ready          slave pulls low to pause\n"
 		 "  -M --mosi-idle-low  leave mosi line low when idle\n"
+		 "  -T --transfers      number of transfers\n"
 		 "misc:\n"
 		 "  -v --verbose        Verbose (show tx buffer)\n");
 	exit(1);
@@ -249,12 +272,13 @@ static void parse_opts(int argc, char *argv[])
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
@@ -319,6 +343,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'M':
 			mode |= SPI_MOSI_IDLE_LOW;
 			break;
+		case 'T':
+			transfers = atoi(optarg);
+			break;
 		case 'N':
 			mode |= SPI_NO_CS;
 			break;
@@ -496,6 +523,9 @@ int main(int argc, char *argv[])
 	if (compare && (!do_tx || !do_rx))
 		pabort("-l/-c conflict with -t or -r");
 
+	if (transfers < 1)
+		pabort("-T (--transfers) must be 1 or above");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");

-- 
2.55.0.806.gb8242b093d

