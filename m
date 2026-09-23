Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFD47D92E;
	Wed, 23 Sep 2026 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194231; cv=pass; b=OnDiK3wDSFNUACroXGSXIdPoTU3k/gP76PvmcQabRVqmpVTU/VSM3oNr2HYx9fGOCPzCgyeEOMucKGXKGJ0EhRCe65bAZ32XagVubgYqkpwkbmV3zf+oaOqgXFVaFOFqkbGrITg0qk/ZAiibOUzvt8nZbihARbN1S1IWELIpcMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194231; c=relaxed/simple;
	bh=LWVVdPz2u3HFK6oulf9T/dtpoeGa7qjhKy1xq7OqM0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfVcC8PuHLGdafIIqHG+9hiCYoKAoG1QSk3Q2ZaSYfWwj0lG7x33ei/g9a4i1UwR6kOpOpcFBcfthvO1Jgr/4C3dz98nP1TXKouzZvNkS7KFA55nXFF+m5vuY6Q66hC13Ycnf3b0YiH9MIYMoaDyfyrEjXoxm6F56TBd95LsNKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=bWacoinn; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="bWacoinn"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C8BE6202041;
	Wed, 23 Sep 2026 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEfb7uy5p8PKIgjeFtIMNJ6FSHVlEWKHZCUjA1owMSc=;
	b=bWacoinnWhUYIEvNrTPwLWHHzcpwRTJIS/alkZsuTl84ikq+q384apJPO5pR7uslU2oLGj
	a3ScgNqm9/RXeA3Jwy99wm2U5rtNMJ6EEFjwW/H5/em09fu0PWOyEOhrBIPY2VRsoi88Hp
	tEQaO4BLfWIE/oCwo+M06QKbBV7s8Ye2ZMfZqO4tRN9NmPrL3JBZy4SmR1q/077OO1IZ2z
	ypUoXOU9hrZWBEy8JdJCTAsHvgCPRJd4edcePRs35pdmSwYXCPUp/Sdf217INffk3LehTX
	UmKnzhpZGJSklS2v+9VuAJ98aCaSmLjTe2CGVnHhwfuoBW7zItsaDgRpkkQf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEfb7uy5p8PKIgjeFtIMNJ6FSHVlEWKHZCUjA1owMSc=;
	b=YHId11RwD6zOw9yPzAxkYRHiZUbOxXuG3ihJl8wor62S9HDSC4x98kD9Huu7yCJXrbnnYz
	zTd8Ymm6NhLINIFEGnGpupSeeLc0tcv11MGS7hHzQGuNXLTsMh4YGwvEYgEWt3SNzIn8GY
	JNzJDjobCOprXbf6gPnLJcYg0Zc+Nbm2YdiOUKCM+pB95VmBypLG25s/cv3Jg4WhJneXgK
	24cDe6QB3WkzJ01q8ov35g+aBNGpSFyWHQ1Lnsfk6F2tkSrV7da34C3xNnGZRL5Xv89FNF
	3DpVWvwBdz5TkM5bfO+wcPTyiv05jmJ2q4WsBEnfdZosO4l4o5ZcyKiqdrTTfw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194207; a=rsa-sha256;
	cv=none;
	b=bXoNEKm9WAsTGnrciw8x0NY1u/qh50h7vDP73Hmh5G6t3FnokK1u/C0QOiz8SCLNKXQRHx
	+qZNqbwNfASUa0FD4e95hx7vRak5HR96c3zPG8TWHXk0ZosfAbQVIYIG76r6Xmbbs9QgxM
	SLbPYtmwacnKPFFW0RP/9k7y9qemiNgmyZmS9ZQrmkq1xO2XyPEWzdAkgMVe2ncfKdsVxY
	Ch2FEjH1E0mAiqNh3U2fvLkVPpJhkCjct4we325tSp+QO7zZs7UashR8+mcsbu0fCRDQZq
	r5e92k69/HS8ojvzb+Y6w7fAP0SST/HazBUYibtfKHqhUrWk1PGqquDVtZwNrg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-2H;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:10:03 +0200
Subject: [PATCH v5 08/13] spi: spidev_test: allow disabling rx or tx
 buffers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-8-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6195; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=1ChqCM84PG8y0GZ5UNIXYU0ulDoeK0y2cg17bpb4AzI=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiSzc6F2aNsWsc/1We8LWiZ7/eb80Phm55lHkhzKS
 bmHVLS/dJSyMIhxMciKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACbiycjwPynjPl/S6erDF6Mk
 e/2Yrjm+uc48h8sqZWb76c7w0p8x6owMTz1qTjY+Epr3gflkhEqNnGGqHOcFfZ3Mm3fqz4hEehz
 nBgA=
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
index 55944386cd69..770f40097535 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -45,6 +45,7 @@ static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
+static int do_tx = 1, do_rx = 1;
 static int random_input;
 static int input_choices;
 
@@ -156,7 +157,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 	if (ret < 1)
 		pabort("can't send spi message");
 
-	if (verbose)
+	if (verbose && tx)
 		hex_dump(tx, len, 32, "TX");
 
 	if (output_file) {
@@ -171,10 +172,10 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
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
@@ -186,7 +187,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbcdilopsvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvw]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -194,6 +195,8 @@ static void print_usage(const char *prog)
 		 "  -w --word-delay     word delay (usec)\n"
 		 "  -l --loop           loopback\n"
 		 "  -c --compare        compare RX'ed and TX'ed data\n"
+		 "  -t --no-tx          don't send data\n"
+		 "  -r --no-rx          don't receive data\n"
 		 "spi mode:\n"
 		 "  -H --cpha           clock phase\n"
 		 "  -O --cpol           clock polarity\n"
@@ -232,6 +235,8 @@ static void parse_opts(int argc, char *argv[])
 			{ "word-delay",    1, 0, 'w' },
 			{ "loop",          0, 0, 'l' },
 			{ "compare",       0, 0, 'c' },
+			{ "no-tx",         0, 0, 't' },
+			{ "no-rx",         0, 0, 'r' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
 			{ "rx-cpha-flip",  0, 0, 'F' },
@@ -255,7 +260,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lcHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -290,6 +295,12 @@ static void parse_opts(int argc, char *argv[])
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
@@ -362,15 +373,17 @@ static void transfer_escaped_string(int fd, char *str)
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
@@ -384,7 +397,7 @@ static void transfer_file(int fd, char *filename)
 	struct stat sb;
 	int tx_fd;
 	uint8_t *tx;
-	uint8_t *rx;
+	uint8_t *rx = NULL;
 
 	if (stat(filename, &sb) == -1)
 		pabort("can't stat input file");
@@ -397,9 +410,12 @@ static void transfer_file(int fd, char *filename)
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
@@ -430,24 +446,29 @@ static void show_transfer_rate(void)
 
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
@@ -470,6 +491,15 @@ int main(int argc, char *argv[])
 	if (iterations && !transfer_size)
 		pabort("-I (--iter) is only implemented for -S (--size)");
 
+	if (compare && (!do_tx || !do_rx))
+		pabort("-c (--compare) conflicts with -t (--no-tx) or -r (--no-rx)");
+
+	if (!do_rx && output_file)
+		pabort("-r (--no-rx) conflicts with -o (--output)");
+
+	if (!do_tx && !transfer_size)
+		pabort("-t (--no-tx) is only implemented for -S (--size)");
+
 	if (compare && mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
 		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");
 
@@ -547,7 +577,7 @@ int main(int argc, char *argv[])
 		printf("total: tx %.1fKB, rx %.1fKB\n",
 		       _write_count/1024.0, _read_count/1024.0);
 	} else
-		transfer(fd, default_tx, default_rx, sizeof(default_tx));
+		transfer(fd, do_tx ? default_tx : NULL, do_rx ? default_rx : NULL, sizeof(default_tx));
 
 	close(fd);
 

-- 
2.56.0.rc0.108.gf0ef1b96a0

