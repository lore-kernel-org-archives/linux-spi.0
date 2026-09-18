Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A9502D58;
	Fri, 18 Sep 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744994; cv=none; b=hR/AUz4KXcqNR5rG3H4jabllLpXvw/vPSjcRcdlSPEVrEuiiHdn56K58CMyr/IpguEhhLriIzPWihYz/R5BNtv9d1yU5rZwwGXl2t3jte0fhEwkkPvpVpWjjHbK0PBRS179oIMRU3zx+zT4HLd5duvLlDZUswJ6wJCkbFu+gUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744994; c=relaxed/simple;
	bh=r7/PvjZhUjg7QIW1LcYyaezUQI54Fsi3GwiYNF6HJlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g801WV45f720+PX8mdS7UDmSenmSCG2U/83rscenRGUjmEaJKaO7o6256uWSWre4P7nFOdS3YpueDrlBrSKHYmKjF1ap2jmHegqvcJg69WlSYw1IPNgW4HJrJ2pgKyEQ/6bbnGub5WRAMz1/8apJM1D/jGbcRqTJa/n8KzoE/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5275E201D7D;
	Fri, 18 Sep 2026 17:23:01 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7aQX-001awp-0i;
	Fri, 18 Sep 2026 17:23:01 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 17:22:50 +0200
Subject: [PATCH v4 4/9] spi: spidev_test: allow disabling rx or tx buffers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v4-4-5ffacb1a4ebd@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6766; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=4II9rXw8bFinhNlsnofkBsyj52J+XvYRnLbK1yMTRyk=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaGx507KZPxJSYBYuEdJmPGO/UNn+V3mOS9NJOmt/nx
 3zH4PcOHaUsDGJcDLJiiiyxanIKQsb+180q7WJh5rAygQxh4OIUgIn0HmNkuPP6jePqGrOwiP09
 1a/mrnq3w+qpgIUuz9ctm/tSkwUZbBj+J969fyB49d72m+9FX0XNbQ9xPXVnU41i4Hvfbx2vX77
 ZxgAA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Allow not providing rx or tx buffers. This is useful to check if drivers
that don't use SPI_CONTROLLER_MUST_RX (or -TX respectively) handle their
operations correctly without a buffer.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 90 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 7993eae88c44..906f9997b10a 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -45,6 +45,8 @@ static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
+static int do_tx = 1, do_rx = 1;
+static int input_choices;
 
 static uint8_t default_tx[] = {
 	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
@@ -151,7 +153,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 	if (ret < 1)
 		pabort("can't send spi message");
 
-	if (verbose)
+	if (verbose && tx)
 		hex_dump(tx, len, 32, "TX");
 
 	if (output_file) {
@@ -166,13 +168,13 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
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
@@ -180,6 +182,8 @@ static void print_usage(const char *prog)
 		 "  -w --word-delay     word delay (usec)\n"
 		 "  -l --loop           loopback\n"
 		 "  -c --compare        compare RX'ed and TX'ed data\n"
+		 "  -t --no-tx          don't send data\n"
+		 "  -r --no-rx          don't receive data\n"
 		 "spi mode:\n"
 		 "  -H --cpha           clock phase\n"
 		 "  -O --cpol           clock polarity\n"
@@ -218,6 +222,8 @@ static void parse_opts(int argc, char *argv[])
 			{ "word-delay",    1, 0, 'w' },
 			{ "loop",          0, 0, 'l' },
 			{ "compare",       0, 0, 'c' },
+			{ "no-tx",         0, 0, 't' },
+			{ "no-rx",         0, 0, 'r' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
 			{ "rx-cpha-flip",  0, 0, 'F' },
@@ -241,7 +247,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lcHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -265,6 +271,7 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'i':
 			input_file = optarg;
+			input_choices++;
 			break;
 		case 'o':
 			output_file = optarg;
@@ -275,6 +282,13 @@ static void parse_opts(int argc, char *argv[])
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
@@ -310,6 +324,7 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'p':
 			input_tx = optarg;
+			input_choices++;
 			break;
 		case '2':
 			mode |= SPI_TX_DUAL;
@@ -322,6 +337,7 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'S':
 			transfer_size = atoi(optarg);
+			input_choices++;
 			break;
 		case 'I':
 			iterations = atoi(optarg);
@@ -344,15 +360,17 @@ static void transfer_escaped_string(int fd, char *str)
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
@@ -366,7 +384,7 @@ static void transfer_file(int fd, char *filename)
 	struct stat sb;
 	int tx_fd;
 	uint8_t *tx;
-	uint8_t *rx;
+	uint8_t *rx = NULL;
 
 	if (stat(filename, &sb) == -1)
 		pabort("can't stat input file");
@@ -379,9 +397,12 @@ static void transfer_file(int fd, char *filename)
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
@@ -412,26 +433,31 @@ static void show_transfer_rate(void)
 
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
-	if (compare || mode & SPI_LOOP) {
+	if (tx && rx && (compare || mode & SPI_LOOP)) {
 		if (memcmp(tx, rx, len)) {
 			fprintf(stderr, "transfer error !\n");
 			hex_dump(tx, len, 32, "TX");
@@ -452,8 +478,14 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (input_tx && input_file)
-		pabort("only one of -p and --input may be selected");
+	if (input_choices > 1)
+		pabort("only one of -S (--size), -p, -i (--input), -t (--no-tx) may be selected");
+
+	if (compare && (!do_tx || !do_rx))
+		pabort("-c (--compare) conflicts with -t (--no-tx) or -r (--no-rx)");
+
+	if (!do_rx && output_file)
+		pabort("-r (--no-rx) conflicts with -o (--output)");
 
 	if (compare && mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
 		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");
@@ -532,7 +564,7 @@ int main(int argc, char *argv[])
 		printf("total: tx %.1fKB, rx %.1fKB\n",
 		       _write_count/1024.0, _read_count/1024.0);
 	} else
-		transfer(fd, default_tx, default_rx, sizeof(default_tx));
+		transfer(fd, do_tx ? default_tx : NULL, do_rx ? default_rx : NULL, sizeof(default_tx));
 
 	close(fd);
 

-- 
2.56.0.rc0.108.gf0ef1b96a0

