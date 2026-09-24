Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675747F771;
	Thu, 24 Sep 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252858; cv=pass; b=UZ3vRV25FmW8TJAPZC6ojV6KJJC7bbF55OgrvRDC2laoVxdahgVUhA6CDggfNY/8Tc8zG70Tom5aLMezF72Z9Sp4Lsn5laBojh9/yzi6NhBD04KMe4k64bZvw5z5Z7VfbJnUs8gT3SFoJ3SsF3ULuaF0Q4LrDgshKTPPyz3iHMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252858; c=relaxed/simple;
	bh=plqKxagnMrv3IkFcRhj4Ym4ynJkz33ScBWcUhjdUF+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FK8k0KB1nN7/WY3YXYM73/3sPaymKTPEzANoLmH9C0KNbVIi2A5tGFff2rnpThc6ZtENfLJw3r6FabNI7zxJvNIHk76CdfmjFWLk7zBklxJmcD+uhTh/D44PGndi1JsSAS7ZiYgcTvY4cB2kiW0X2p4WpbCzpPQUBOYUsbdC5s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=I0qU7K6e; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="I0qU7K6e"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 37FA8202148;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQfU6t2cwoZAVhsNKsYVTJxACGTrITolKYhiTabrCZk=;
	b=I0qU7K6e2UaqnKeHQs11+Enj4cVROVVIG0uQcjNPaRTnpCZ/wVqYb7Yl8Zns3UbnTkh0T6
	9ToCtu3YSOq1Osh5blyoxIZAZS1T5bKONkMa7SJxiWd30mUe1sAtmNn7EoxNJwdYHJkXbK
	wYROYTAgFxerK5ucdKCZumbSDqHvKekvhFuWqu731dfXrU8RmAVyv4CGBg3iJyU10w7QSy
	zQBNlB9hJW8w1jhnUg8lVZBQYTksNsU/Z5U9Adbrbx2uYt2roqbWDSGCNOsmuoeMWi+B2/
	pVgDLV39e8xgxirKYGsIOwmjhWNOzcscXqTiIMHZHZt2tDRNctQjzQomh2eJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQfU6t2cwoZAVhsNKsYVTJxACGTrITolKYhiTabrCZk=;
	b=V50MyYR8eFD4RJpDogSm62DUWYEP4tufgLIQKJ6KsK2fedIaaNQsrerllt/PPOKjCHbKvR
	mw1pb2BDtSfo3KqPTb2C7L+L9mfMjnN201G7LmFlVtzJUucs9pimQRHl5AF7c5MN7O/G1n
	BCRhRi75eKJ4urVQrNuisYOUcmLcHiHssLtzoISv76ul/jKToDydMakjIAmPNFkAh7/s6d
	8h934bYjcb3ynxp8gHOd+p+J5lIGNe6bp7FPaVNQU3dp08U+Wvd5zrOyoNPLZkbkawEAcT
	ojFL4RPoWAoNKGAbYH4UyAKJV69B4mTNa4ygZtvuDuhrRQX+84tXG/GjfOmB9g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=e2cJ/MBj02loUPunZGg8WtGtyBOvUfjTo1qdpChMzULCWmeywQ1ZX8rCMglu964ZOyrxc6
	ykDtbRJEXFP14ADBKFwzVXlZ/vZMKObxjnfyrx67rbtvjVYBim4fzE9w43Te1gcmbg+eGN
	PZosGwaoRsXdSPFvEzXTQ6ylM5Go7MmDnc21XvASqVM1Y8D1yLxXitGLKSdMCs53zOsaxk
	mCKc7AtBM9DX58/xDRgScbuYHX6snen5DOeFULqjLqKii67GKNp85Ebl+bswQt/5iOA1um
	Rcf9tqzS/7slydBIJqVbTirl0hnS1uJh9YgHCWxvCVWRnG0/5gwPLcirc1f1hg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id ED8AE3809DE;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:24 +0200
Subject: [PATCH v6 08/13] spi: spidev_test: allow disabling rx or tx
 buffers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-8-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6206; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=jIAjylr2HYi0dbgb2V7Omk7hw/hE5df68j8J5p3waDo=;
 b=kA0DAAoW1JjkDZHO24AByyZiAGq1Fy6gKZHvywouRsDKgw+TBl/9LjK08a520X9GP8H3reyjy
 Yh1BAAWCgAdFiEEXSYeIBIzT9c2eT5d1JjkDZHO24AFAmq1Fy4ACgkQ1JjkDZHO24CsmAD/SAtD
 vLjzS8ZzcDO+USdkk87P84eL/QhfYEorZHrXhQYA/AktFmvJPlFlTjc6MUIv3As4jmGAoznLEUM
 RoQSkcSUO
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Allow not providing rx or tx buffers. This is useful to check if drivers
that don't use SPI_CONTROLLER_MUST_RX (or -TX respectively) handle their
operations correctly without a buffer.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 84 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 7b343803903e..c58cccdf806d 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -45,6 +45,7 @@ static int transfer_size = -1;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
+static int do_tx = 1, do_rx = 1;
 static int random_input;
 static int input_choices;
 
@@ -157,7 +158,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 	if (ret < 0)
 		pabort("can't send spi message");
 
-	if (verbose)
+	if (verbose && tx)
 		hex_dump(tx, len, 32, "TX");
 
 	if (output_file) {
@@ -172,10 +173,10 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 		close(out_fd);
 	}
 
-	if (verbose)
+	if (verbose && rx)
 		hex_dump(rx, len, 32, "RX");
 
-	if (compare || mode & SPI_LOOP) {
+	if (tx && rx && (compare || mode & SPI_LOOP)) {
 		if (memcmp(tx, rx, len)) {
 			fprintf(stderr, "transfer error !\n");
 			hex_dump(tx, len, 32, "TX");
@@ -187,7 +188,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbcdilopsvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvw]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -195,6 +196,8 @@ static void print_usage(const char *prog)
 		 "  -w --word-delay     word delay (usec)\n"
 		 "  -l --loop           loopback\n"
 		 "  -c --compare        compare RX'ed and TX'ed data\n"
+		 "  -t --no-tx          don't send data\n"
+		 "  -r --no-rx          don't receive data\n"
 		 "spi mode:\n"
 		 "  -H --cpha           clock phase\n"
 		 "  -O --cpol           clock polarity\n"
@@ -233,6 +236,8 @@ static void parse_opts(int argc, char *argv[])
 			{ "word-delay",    1, 0, 'w' },
 			{ "loop",          0, 0, 'l' },
 			{ "compare",       0, 0, 'c' },
+			{ "no-tx",         0, 0, 't' },
+			{ "no-rx",         0, 0, 'r' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
 			{ "rx-cpha-flip",  0, 0, 'F' },
@@ -256,7 +261,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lcHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -291,6 +296,12 @@ static void parse_opts(int argc, char *argv[])
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
@@ -363,15 +374,17 @@ static void transfer_escaped_string(int fd, char *str)
 {
 	size_t size = strlen(str);
 	uint8_t *tx;
-	uint8_t *rx;
+	uint8_t *rx = NULL;
 
 	tx = malloc(size);
 	if (!tx)
 		pabort("can't allocate tx buffer");
 
-	rx = malloc(size);
-	if (!rx)
-		pabort("can't allocate rx buffer");
+	if (do_rx) {
+		rx = malloc(size);
+		if (!rx)
+			pabort("can't allocate rx buffer");
+	}
 
 	size = unescape((char *)tx, str, size);
 	transfer(fd, tx, rx, size);
@@ -385,7 +398,7 @@ static void transfer_file(int fd, char *filename)
 	struct stat sb;
 	int tx_fd;
 	uint8_t *tx;
-	uint8_t *rx;
+	uint8_t *rx = NULL;
 
 	if (stat(filename, &sb) == -1)
 		pabort("can't stat input file");
@@ -398,9 +411,12 @@ static void transfer_file(int fd, char *filename)
 	if (!tx)
 		pabort("can't allocate tx buffer");
 
-	rx = malloc(sb.st_size);
-	if (!rx)
-		pabort("can't allocate rx buffer");
+
+	if (do_rx) {
+		rx = malloc(sb.st_size);
+		if (!rx)
+			pabort("can't allocate rx buffer");
+	}
 
 	bytes = read(tx_fd, tx, sb.st_size);
 	if (bytes != sb.st_size)
@@ -431,24 +447,29 @@ static void show_transfer_rate(void)
 
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
-
-	_write_count += len;
-	_read_count += len;
+	if (do_tx)
+		_write_count += len;
+	if (do_rx)
+		_read_count += len;
 
 	free(rx);
 	free(tx);
@@ -472,6 +493,15 @@ int main(int argc, char *argv[])
 	if (iterations && transfer_size < 0)
 		pabort("-I (--iter) is only implemented for -S (--size)");
 
+	if (compare && (!do_tx || !do_rx))
+		pabort("-c (--compare) conflicts with -t (--no-tx) or -r (--no-rx)");
+
+	if (!do_rx && output_file)
+		pabort("-r (--no-rx) conflicts with -o (--output)");
+
+	if (!do_tx && transfer_size < 0)
+		pabort("-t (--no-tx) is only implemented for -S (--size)");
+
 	if (compare && mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
 		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");
 
@@ -549,7 +579,7 @@ int main(int argc, char *argv[])
 		printf("total: tx %.1fKB, rx %.1fKB\n",
 		       _write_count/1024.0, _read_count/1024.0);
 	} else
-		transfer(fd, default_tx, default_rx, sizeof(default_tx));
+		transfer(fd, do_tx ? default_tx : NULL, do_rx ? default_rx : NULL, sizeof(default_tx));
 
 	close(fd);
 

-- 
2.56.0.rc0.108.gf0ef1b96a0

