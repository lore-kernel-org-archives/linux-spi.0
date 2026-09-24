Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A93EB7F1;
	Thu, 24 Sep 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257460; cv=pass; b=UDc6o7hpkQ+yeGb5NmgJmR+RmRDWN+m+RKQxGW2SPR4Pq7ZpXMG1RECbbBFSfQS53M/qLWfa+bfIqktxuIuzNb6wa5LQVRrSsVspuErY9xemnhzUXA5NPiyAXzq4bE2X8uH7lzurDeRUPVVP4+P5G/b8+9Jt20I6L2gHd5gWWk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257460; c=relaxed/simple;
	bh=pmiHAYoL5DejakDEuW5LJ4rVM3eUhDSub8A1ECGnk18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=caxh0tqU3OCgSQh3cGnYtTjv29ZqPsGuUM4fD0gomHeJYKR8GJFGkDUilWBWWPKYFDnw9Fc7qCX8Juaj9yeFDAD58RF2lY4Fvq0i679WaCCBaO9ioL3uWxiRysPOZ+9y3D9+jAnHj53/Tw+0firxKu2meMwtIy6bDmgIlEXEFQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=L6lXz1u2; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="L6lXz1u2"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D074F202146;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pS2M3jmjM6rlh02id3kbSdC1ox1X59K7xtv6Fq7j2F0=;
	b=L6lXz1u2cL5aRoGe1X/sUKUgD+6NrmWLUHJ8YhEwL2MpzQCE3k2dDCDmwYAVlDs4m9YnMh
	tvbq6K7kspcBKCgGEYJS1KVi4fUcEpk6Vop2xcNk1inaqlUBxHrkmJx6s7R0ltqgCpYEq1
	QJlVghHpv70tCZHE5GK9wwc2YdvIeZDtJm+n39vOquQPg21LY+YIv4MDMvmmOfKlE6vMgl
	+50p2uM9v9ng71+D8M6FDpXZwCgn+c0LOkAxwh2aR1V+fdF/owEIps8vvwjvWX3y4TC23b
	Pc98w5BnPgJrW+3AU5qpX3dgOpsv3wBytuMYMuI3ByIW8otqRD3o667DIq202w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pS2M3jmjM6rlh02id3kbSdC1ox1X59K7xtv6Fq7j2F0=;
	b=M82xFq/tw9LUn+VjL9sbB6UZ5nH58oUirQd6jPFfomASnhxEF4V7lWfNAAgMlC/uZjKCm9
	jsqnuKz/c5ROZliNe/syUJB1vfV35JjJucAuTZ0RP3BpOkISTbWzDpU4jx0NNotW30O6Rh
	6vXPnNdkvQTT317tOso5nUKN6HkyikkFBEL+C9A1fYosWGbE+CEuN78PSYfl2RMOa13NBl
	1taWr1GRs+29HchlswVADlpHO+1Rz7SSfqeCONJmmPpJZeYtxVYJe93dMSA+FExIkIUxLV
	uQJYurRHCh+9GaHwW9w/sDNhlL0oJoyiik4FIsqNYzGeoSymHETugbiPlSoWaw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=eoYYgKpBcMCA1FgqzqZh3+I4gR6ghFEInU5fgfOtblnuE1Vs54DscjwcGV0xJDTP7Kgpiu
	RE5wmsRe5oqvpdhXHP+fYy4Jow8aHUzqlpYqPvwXskHE5j+7YD/z/QcJ6HbGIlEXyXXpSe
	9HEm/5ATvP7zzDP9P8JmBZaJoIebvKyePU/vsEd6Sa6WAhx/uKB4C2KjttHPgEAEi1CwoL
	TNSoIliE6bVRvphN6KMhuzBC709tI9Admcgwvh2hqDZ6rw4zewHJkzIJEzmZp4vxsEmary
	0I9TXUBwy8Yaz8oAVVbV+9TAI9Ua5aZl9xIhoIJ4msR9p8sztcDKBBz3ZLOiEg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 95C05389209;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:43:58 +0200
Subject: [PATCH v7 08/13] spi: spidev_test: allow disabling rx or tx
 buffers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-8-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6191; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=g8e/FAHF7ARJmiDeOBHpXrHrr0jwWi7quYYux7LCuYM=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqqnyddX03t3vMjzcfpa0eZwP5Nn2+/sqy66wd56PJ
 k3aks1zvKOUhUGMi0FWTJElVk1OQcjY/7pZpV0szBxWJpAhDFycAjCR9fGMDO1Wesd2TciqXtIZ
 sclv5Xr+1ynNcc0v+3VuJfFPMPBzvsHwz1R/tuKtU8o3rq8KdZUXu5g5scF68bv8vq7t/7JSMyN
 eMwMA
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
index 7b343803903e..b02a6384d27b 100644
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
+		transfer(fd, default_tx, do_rx ? default_rx : NULL, sizeof(default_tx));
 
 	close(fd);
 

-- 
2.56.0.rc0.108.gf0ef1b96a0

