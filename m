Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F2303C97;
	Thu, 24 Sep 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257461; cv=pass; b=X01hWUBVaPVajhf5x/5xKl5zbH1BETZiCdCdmsSJapwcs488YbnYiC5VvPPRfcYCZ2gWrHVzD8ICc94Ay7rawdTUUNgUgvBLi4QvX1IxgAtUMkwzYgHsiyMxo3jEHAEG/Xt6z/A8PxbI2jNIKcqKbpmK/+bB4ouJNJZ3CA+uuJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257461; c=relaxed/simple;
	bh=ZsjZJ6lMvUjOLR+nKm6DDIwihQ/uyqhR247aCy9WRoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5Ub3ixgNJ6s1pC4K0h6Cw6/K7/CGgW+iZmClejEojPHMUknMB/4PSksIzh7XBciEvvQ97PJqjZHO7p1d/Ueoih4YPaidcGtjZBNmHvjhLkhskYOD44I/xmlNugcknSQVuvlnEmE9tkzZTXIgI2+l+JTREYXJgbCpwXk5Iy286k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Y1UizkPA; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Y1UizkPA"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E00112021EE;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kat2nDtgk8dA3NEE1N7KXHvGS38MPnJF+qOPyTrWRxw=;
	b=Y1UizkPAvEP1QreSMD7ZIVyDtCuvgWQu5z89IY2Wx/7r+0NdmGqHfv15vPrUPL1UuduogT
	JLuhVGLI4uxiIgfUbhzQk1PsH6MLYYRm65eexT9jZF5UM9S4IlDWMx71gfFyHWK4OiRNYu
	aUld1Kqjdv6Hy+oIb3/CgxhrsjLw+hR52dyX5eK6OoFyt6SFYkiL3fIv3UxSBdYtNtLT8f
	T0UuySgi963wnvxvcZ+YJEESTtd5mJwqvmoD7fiCFTAsjCm4Irm/PmMCLk8GLPT1dVFCo8
	IW3BWdclyFzQxJGdEKDO/6kYNbQA37u2L+HV9PNqJz2DSNqV2GmrFYX84v+32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kat2nDtgk8dA3NEE1N7KXHvGS38MPnJF+qOPyTrWRxw=;
	b=IPT6u3pD/md978jefB6sdWIiZ7ui8VAQj0fMQ2oR9Ll5Zw9EUdZ+4oGRKMZjKyxi95qcGw
	lrI4x03sFv7b/afYfqFlZfFhGtZ6Mx2sM8IbdgZZIxv6lHOqO3Db3ZPz0OwJ1HgIpQbR5O
	oa7a0IkuO/UAKpHjfFA6TUI7Pj3w8zqVPzcP5QkPcLtnoqLOsDVGP9HX3Dc1RV7Y802ejA
	nwl20l+P7xyb+IDdetJNpV55IQIkDI2tlKL0aH1qIsWpBS2H37nS3l/5VQrmDUQPNvV7hx
	2bB6MbY1mpMMNMu6YLZTgD23e0JsFt2r75z/RAQ38CmzqwN577P2N01mJYk7Cw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=gyw/Xn6GeRaUPAt9qa03nkM6E2aM258zckABIBK0b4pz7mdpo5vkWuUbzPKTuN9r6LN5nb
	rMDTwN37YYNqT7C6VoNcRy2i8Qppd1VPd26ZMs0ESLS6cK7HLCxu1ILXZrfeIYBdzjhNKK
	4XMFcmQZIHAQiu5JAv1W8MqYheSGU+S+w5AXd8bPNuvkyMmzDsJA1KUEPw4w+37lTdf3kZ
	A3s8ORM8rSYEnHNObeW4OvU25jBU9nGbihb0217dUlIrhSpU081/dfulOVOv9kTCKHRaN/
	Ojw/n1vsfMQdPzdpbn04ZVGB19hoCT7IQwDmEPRVgRtNFY8PPmeKJJdSYPOlLA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 96A88389211;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:44:01 +0200
Subject: [PATCH v7 11/13] spi: spidev_test: add option to split message
 into multiple transfers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-11-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5895; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=JNonMynwZhh5t5YN+ZnGdWvqKzm2ohhNRij3+5UreZ8=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqql2LaXkruX6aeIf6yYL7k1e+d/75ITeTdkpn1fcv
 9CvLcCQ1VHKwiDGxSArpsgSqyanIGTsf92s0i4WZg4rE8gQBi5OAZiIUyAjw31D38eil9+v3Lws
 ffmRHzm5vcw/Pk2NiRaZdmr5lLUJZx0ZGe48e5rfkbHoq2iyvNQC177Fvpudg3/teiR2xvJz+xW
 DEjYA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

SPI_IOC_MESSAGE() submits a single SPI message containing one or more
transfers. Introduce an option to allow splitting the message into
multiple transfers.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 113 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 31 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index a58680b6288a..ac24d051835f 100644
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
@@ -123,40 +124,79 @@ static int unescape(char *_dst, char *_src, size_t len)
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
+	if (SPI_MSGSIZE(effective_transfers) == 0)
+		pabort("too many transfers, SPI_IOC_MESSAGE size limit exceeded");
+
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
 
@@ -190,7 +230,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNOPRSZbcdiloprstvwz]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNOPRSTZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -225,6 +265,7 @@ static void print_usage(const char *prog)
 		 "  -N --no-cs          no chip select\n"
 		 "  -R --ready          slave pulls low to pause\n"
 		 "  -M --mosi-idle-low  leave mosi line low when idle\n"
+		 "  -T --transfers      number of transfers\n"
 		 "misc:\n"
 		 "  -v --verbose        Verbose (show tx buffer)\n");
 	exit(1);
@@ -262,12 +303,13 @@ static void parse_opts(int argc, char *argv[])
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
@@ -332,6 +374,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'M':
 			mode |= SPI_MOSI_IDLE_LOW;
 			break;
+		case 'T':
+			transfers = atoi(optarg);
+			break;
 		case 'N':
 			mode |= SPI_NO_CS;
 			break;
@@ -533,6 +578,12 @@ int main(int argc, char *argv[])
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

