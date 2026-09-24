Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8BB47F79B;
	Thu, 24 Sep 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252859; cv=pass; b=Z0+x0/xSBqujn4l4Cm5lieMdJMnzjGPGgkKn/dryWmuvc9IBmcAZQCJRNE5Di4hnCdYmW2tvarCQiPR7KfHSx5a8qrb/jeQ5PDkcx9QpFQjZ7LtODxUDSDcNSeGyKcIiqbxzN61hHeePPW0D31WPBCrmNdCgVIvJN5e2OJQ1bY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252859; c=relaxed/simple;
	bh=aqVGk9OpS8uUQgto78A3ACT1OZ9SROyE5Z9w7UT3VXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o84xYGvDI3AWCk9slwZS1eOjTVnjDHCtR8LAMwphtBMB13PSGeaoCm2eZIX3RtaiTEa+1n5SjftYn78fIpJAGIi9ED9BgPhi847BBvjI0TgeteqgFZ5Cugtkzl+CKF8D/EJp71hDkxoJ4KAYoZthiJUk7kIbtIpUv9lsLRRqz/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Z311PwQb; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Z311PwQb"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 44A272021EE;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNwNg/+S1sShNHDkOdQSMZsAO3pL+lIL7XqGHCcT/sc=;
	b=Z311PwQbQ3MH0IV7wcrXsS4rMl60xxevPIeBjsa63HXMmOMpvqbvyrzgESuViVDhmr/KWJ
	fulVtkm3Ee88S/gg8svU5NSk7tsiMu0AN68MXRgd769GeHAShBJXPFfBspsAWFW43/AFMJ
	7wwcVNLWQwGdAGSSqpPqlr81pQoCruxaKeu6Hab+0NdPwaKFBwVjiHlaiPXT45eEHwQm9X
	ZH03Bc6MLlQwSS9kx32dQtAKvxMqz7GBkjrw9TKbtFx0M0M/htaUPb5qXIkBeIfGOfPhMC
	7/1LldNUtXsMwSOsfqbSVtYROgh5M6puHPYQWLQ6kU+Zczy6vNprKcbAh23CMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNwNg/+S1sShNHDkOdQSMZsAO3pL+lIL7XqGHCcT/sc=;
	b=gspkS9plc/h8I72xECSWkEWDO4EG9Bw6ZeLzZHjsbiu/o8Ps+fBAmBYmikHB8rrhtO9v8K
	IOJ+K0cuAey6T6G8hhH6W9LC1O/dNZj++EXrAa6khn9XcgXoUHulzfzNPx1hWhCDzlfQnK
	dwrRMmgms0QY8wj2/ozDqlMd4JlhQHR/WLxRzYMfGv03UL29+Os9nXVbNdWJssxH8UD/dR
	gUBUk7znOEBrGXdKA/B5x46uGb6kDqPa2OB+i/A4kOlfabwsq8daXB0/sL5PXQpgcNQi/N
	PBk+6x8Qso3eu58OfoX4jy2fW4xSTsl39LY5Oo4JwABxnfbLytbmJLf9lu7WUQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=JgQX7NJA8/TEPTTML04zx35hAoNnoGzFSx7wpko4MbUXZmswOERD/kv73tJVhmZT8TpHZc
	VlRR98MRxrHIV4kGc1nXRGpOB/QP4k2NUxUfbyWlHAGYLPtIEWeDkWRbO/Shj6HLTLFTPk
	xfH3hUNIw/YtP2p70BiooMWdNVTd8SDS+7b2JRdRjr2We/MpzCk4amZpM40rY6g0E8Jay8
	8paOjT+7xofkHclF2DyRWtyu2r/5dpTmY3Qft32AWEWVTnYToQraNm3XsR+Lr+xqU0HeJu
	Mpy1tYsW+V/m4a4KciEQNdNKGVm7C0zkljxOuTeWNxZgnHPggGVxnMQgLN2+Pg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id EE700380EAE;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:27 +0200
Subject: [PATCH v6 11/13] spi: spidev_test: add option to split message
 into multiple transfers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-11-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5775; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=XbixemO4gy3R9vYbpVlKyuANLgClhCyDjCmpgWWrRWs=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKq7/7LF7xJ7Qc61qTbxyf+IeuOjJ8hRsavx/8ddS5
 yPehsKVHaUsDGJcDLJiiiyxanIKQsb+180q7WJh5rAygQxh4OIUgInECDL8M52x3Yup43nlLuW7
 iyrusyhFZSmvuXvravq0BL6EEJ6L3xgZrr8M5olf/ERrO4d66O8d0b/uzUtJWr7xPN/jsrmGedt
 W8gAA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

SPI_IOC_MESSAGE() submits a single SPI message containing one or more
transfers. Introduce an option to allow splitting the message into
multiple transfers.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 110 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 31 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 0917fd97d448..cce6669d3789 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -42,6 +42,7 @@ static uint16_t delay;
 static uint16_t word_delay;
 static int verbose;
 static int transfer_size = -1;
+static int transfers = 1;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
@@ -123,40 +124,76 @@ static int unescape(char *_dst, char *_src, size_t len)
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
+	int effective_transfers;
+	struct spi_ioc_transfer *tr;
+	size_t len_per_transfer;
+	const uint8_t *tx_buf = tx;
+	const uint8_t *rx_buf = rx;
+	size_t rem;
+
+	if (len) {
+		effective_transfers = min_t(size_t, transfers, DIV_ROUND_UP(len, bytes_per_word));
+		len_per_transfer = roundup(DIV_ROUND_UP(len, effective_transfers), bytes_per_word);
+	} else {
+		/* zero-length transfers may be handled by the driver, deliver as ordered */
+		effective_transfers = transfers;
+		len_per_transfer = 0;
 	}
 
-	ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
+	tr = calloc(effective_transfers, sizeof(*tr));
+	if (!tr)
+		pabort("can't allocate transfer array");
+
+	rem = len;
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
+	}
+
+	ret = ioctl(fd, SPI_IOC_MESSAGE(effective_transfers), tr);
+	free(tr);
 	if (ret < 0)
 		pabort("can't send spi message");
 
@@ -190,7 +227,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNOPRSZbcdiloprstvwz]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNOPRSTZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -225,6 +262,7 @@ static void print_usage(const char *prog)
 		 "  -N --no-cs          no chip select\n"
 		 "  -R --ready          slave pulls low to pause\n"
 		 "  -M --mosi-idle-low  leave mosi line low when idle\n"
+		 "  -T --transfers      number of transfers\n"
 		 "misc:\n"
 		 "  -v --verbose        Verbose (show tx buffer)\n");
 	exit(1);
@@ -262,12 +300,13 @@ static void parse_opts(int argc, char *argv[])
 			{ "ready",         0, 0, 'R' },
 			{ "mosi-idle-low", 0, 0, 'M' },
 			{ "predictable",   1, 0, 'P' },
+			{ "transfers",     1, 0, 'T' },
 			{ "verbose",       0, 0, 'v' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:P:vS:zI:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:P:T:vS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -332,6 +371,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'M':
 			mode |= SPI_MOSI_IDLE_LOW;
 			break;
+		case 'T':
+			transfers = atoi(optarg);
+			break;
 		case 'N':
 			mode |= SPI_NO_CS;
 			break;
@@ -533,6 +575,12 @@ int main(int argc, char *argv[])
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

