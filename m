Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08C5803B0;
	Wed, 23 Sep 2026 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194529; cv=pass; b=Uc88Tq2gneE6A13VSKXdOkXNwzz/YBl5yZeDxZLqIqmUvE6pnKu7l1HpDGB9ct+NAOeUFxjz2+PTKLpVLFi6p05T/aDYsI/q2pV2uMa5VcD35gF0bfqsRRSxaitwuYYwB032z0HwCC0ms5aAV84Dx4/RbWolA+z0wzuI/q2IwWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194529; c=relaxed/simple;
	bh=DMEk6BRbCbu4EmCnp8M4jwBx7batC5eui4GJ6CvrH+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D72iS3QkT/IRSuHV68qU3ZSWzfvYZS/WqXVdMoNtMwBrObejl7vGyAP3JZ3ISvqUTvnpJtGuTXHf70JYeVGwvtI9JBICCqeN6gtEz5xzm4mQY9kFcXD569p5RMVKFsiNZfLOBKq8FCrKRPibIm+YrLCmfq3kSND8TdYcmwLba3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gT/0Pvnc; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gT/0Pvnc"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7ED40201F09;
	Wed, 23 Sep 2026 22:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHLpWqJtmLO8cul5CrjSjjMmlqlo8BFpbdW/hCraO4A=;
	b=gT/0Pvnc/hGEj0CRIgIhbK7HYbDcBBxlzGTAYPCHEv3YduVEyWvCPKMugMDa31X2L0vrTb
	JjcUaIvPT+LL3WMO9rCxGlkXUOG0f/ecuVTQZ9H1GZv9lZ8gjA4Qj6cOaRkZ5YCBJ6XqZ2
	n/ML1KZtbpjqkTg9f5t7rKFz3/JZAudqiYRksuIYakPJxDrk1+hR3l9am/KTWPtTp5zawf
	DiMLAupKd5/Uv88BRoXSX5EqiercMqmUDUtiqeNpbzFcGbMEPe016mziSv3exzNEqms4Or
	+PbEYt+MWAsQiRMnJqUAqYSFSUJ0U/Kb3qlujokNbsXvzlXLso7wdieyNMu/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHLpWqJtmLO8cul5CrjSjjMmlqlo8BFpbdW/hCraO4A=;
	b=LHDPoitnTz7TWfKkEvH9vXbmsfrrrCRFGfpsbAWyAqj0Ry0QM3tNahYYS7geELYHug/wPG
	t5n7C3aX1Vi5xrpUh37k6byiRH/nov6TJUMveH2iKZ0y8/cN09wKRHoXzlhyb8GxCZFGAC
	/p6TVRHDrf3x4m4N+T+tJaBIcQ//IbiT5l1viuVEcfoP4kze/p6MA0g04kcwEKrcEhFD/X
	qhvARE3lwERpbPraL735RBYUTyAyXpuMqXPgRtEHjrdaLDItZMNq3kWsle9R0D1aTmamyT
	ND9wp1O/dPNxw8kPREjJ1IEVFbTBjz+8bP5WX4QwAWeFDa44sY1o2RiX4AgcUg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194515; a=rsa-sha256;
	cv=none;
	b=AZ+ym1cj/whsGYJc/BYwfRCZK+01DJjoE2jLcKjeknN08uNKM/7wue0fyXX3BvXXAivMSi
	YouDALcdAjgmnF+MBZDuMo8X7YmzNGX1xgIudyr45o7cFrkoTtu4fKOb7BM1diOHDy332J
	zULPV9aJvYreLrDRoGpsZcQIykx9kVZeM9vdJurMkRyJKOMqpT7xL07n6JnOZNrIdKT2ar
	3luawQiZjU85XICbx1tAMrM4uguVB01IuQO4sNvKzmJIXU5klSS/lz+vqdwyuZ31miShsK
	75NUVNpNQEh4bh85jjylUe4HP13q40kBvcjTuiXLbu8OvCxO8dJM/BzY4YKbXw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-2h;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:10:06 +0200
Subject: [PATCH v5 11/13] spi: spidev_test: add option to split message
 into multiple transfers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-11-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5583; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=VhVsqRoqcwa+9sYPLHowj9bNcUGNtXwWXlCq6M0EJyE=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiT7+sGBg4VLD7gdTc17tePe31s8i66ekVVc13ZlA
 XfN0ltP+zpKWRjEuBhkxRRZYtXkFISM/a+bVdrFwsxhZQIZwsDFKQATuRTP8L/s+qIJ177fFOtd
 tOLw9eDlMzjM5k25EJpyZcObFjHx1qQmhv8uDF42v6Se2Vwpvjlf9qnrw1N/7aufze2J+f1Prk1
 cdT8fAA==
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

SPI_IOC_MESSAGE() submits a single SPI message containing one or more
transfers. Introduce an option to allow splitting the message into
multiple transfers.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 96 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 30 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 56b71b842fb5..32dc7daac21e 100644
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
@@ -119,43 +120,67 @@ static int unescape(char *_dst, char *_src, size_t len)
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
+	size_t bytes_per_word = DIV_ROUND_UP(bits, 8);
+	int effective_transfers = min_t(int, transfers, DIV_ROUND_UP(len, bytes_per_word));
+	struct spi_ioc_transfer *tr = calloc(effective_transfers, sizeof(*tr));
+	size_t len_per_transfer = roundup(DIV_ROUND_UP(len, effective_transfers), bytes_per_word);
+	const uint8_t *tx_buf = tx;
+	const uint8_t *rx_buf = rx;
+	size_t rem = len;
 
 	if (!len)
 		pabort("can't transfer an empty buffer");
 
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
+	if (!tr)
+		pabort("can't allocate transfer array");
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
+	ret = ioctl(fd, SPI_IOC_MESSAGE(effective_transfers), tr);
+	free(tr);
 	if (ret < 1)
 		pabort("can't send spi message");
 
@@ -189,7 +214,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNOPRSZbcdiloprstvwz]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNOPRSTZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -224,6 +249,7 @@ static void print_usage(const char *prog)
 		 "  -N --no-cs          no chip select\n"
 		 "  -R --ready          slave pulls low to pause\n"
 		 "  -M --mosi-idle-low  leave mosi line low when idle\n"
+		 "  -T --transfers      number of transfers\n"
 		 "misc:\n"
 		 "  -v --verbose        Verbose (show tx buffer)\n");
 	exit(1);
@@ -261,12 +287,13 @@ static void parse_opts(int argc, char *argv[])
 			{ "ready",         0, 0, 'R' },
 			{ "mosi-idle-low", 0, 0, 'M' },
 			{ "predictable",   0, 0, 'P' },
+			{ "transfers",     1, 0, 'T' },
 			{ "verbose",       0, 0, 'v' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:P:vS:zI:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:P:T:vS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -331,6 +358,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'M':
 			mode |= SPI_MOSI_IDLE_LOW;
 			break;
+		case 'T':
+			transfers = atoi(optarg);
+			break;
 		case 'N':
 			mode |= SPI_NO_CS;
 			break;
@@ -531,6 +561,12 @@ int main(int argc, char *argv[])
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

