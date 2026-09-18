Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8250276C;
	Fri, 18 Sep 2026 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744991; cv=none; b=Grpma04CpfgIvj4IhXJgpJerpzJoH2t0RNL/So0XLOKkaSCuuOCOik9IKsEZAe11yGvnaPDFydQSD9ohsyBlERGVX13zu3qHNUXW/gzXRANYAuEsltKsNcYLdNyV4HDdAXdac6PNg6ilIOPQp7KROBpjk02d1CAPJCPAkIgYOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744991; c=relaxed/simple;
	bh=7YVXq8vXFh9JGK2OgAlbDJkcSwXJMi81LEDdKZRlYUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcHkRolyfaLWAawYy3qGjvSuYV44+wywz+LSMaegff/Mij9MCxao/krzkoAn59fhwTUDpN/IgOtsxsTrP78zXXNL5BTbLxF+KPV1f8ULt7srDIRVybG9h7M77cYq850P2a5Ojg6zz1/P7cIGBD3Bl8xyY7dzNKUu+8Zru3n5K5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4451D201C37;
	Fri, 18 Sep 2026 17:23:01 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7aQX-001awp-0Y;
	Fri, 18 Sep 2026 17:23:01 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 17:22:49 +0200
Subject: [PATCH v4 3/9] spi: spidev_test: add compare mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v4-3-5ffacb1a4ebd@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3137; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=n8XhVZLSFhOpD3ZnWIq+soYNGBUAkwZyn6fB56crf98=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaGx7oW8m8fe4RT7USv2OZdmdUJp9b8qejR/DD4vP/L
 01c9IO7oaOUhUGMi0FWTJElVk1OQcjY/7pZpV0szBxWJpAhDFycAjCRtImMDLO3L5re7qO7J+hV
 lHjfrcdHWc4GvLM9ub9IVDBq1xW5jtUM/wwezyqb+WzpohlKXF8XSmv0z9A03v5gVv/WguXnpgZ
 /yWUGAA==
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Check whether the received data correspond to the transferred data but
without enabling loopback mode in the controller.

This is for testing with TX physically bridged to RX which is useful if
a loopback mode is unavailable or insufficient.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index f5ab67236fac..7993eae88c44 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -44,6 +44,7 @@ static int verbose;
 static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
+static int compare;
 
 static uint8_t default_tx[] = {
 	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
@@ -171,13 +172,14 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbdilopsvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbcdilopsvw]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
 		 "  -d --delay          delay (usec)\n"
 		 "  -w --word-delay     word delay (usec)\n"
 		 "  -l --loop           loopback\n"
+		 "  -c --compare        compare RX'ed and TX'ed data\n"
 		 "spi mode:\n"
 		 "  -H --cpha           clock phase\n"
 		 "  -O --cpol           clock polarity\n"
@@ -215,6 +217,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "delay",         1, 0, 'd' },
 			{ "word-delay",    1, 0, 'w' },
 			{ "loop",          0, 0, 'l' },
+			{ "compare",       0, 0, 'c' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
 			{ "rx-cpha-flip",  0, 0, 'F' },
@@ -238,7 +241,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lcHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -269,6 +272,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'l':
 			mode |= SPI_LOOP;
 			break;
+		case 'c':
+			compare = 1;
+			break;
 		case 'H':
 			mode |= SPI_CPHA;
 			break;
@@ -425,7 +431,7 @@ static void transfer_buf(int fd, int len)
 	_write_count += len;
 	_read_count += len;
 
-	if (mode & SPI_LOOP) {
+	if (compare || mode & SPI_LOOP) {
 		if (memcmp(tx, rx, len)) {
 			fprintf(stderr, "transfer error !\n");
 			hex_dump(tx, len, 32, "TX");
@@ -449,6 +455,9 @@ int main(int argc, char *argv[])
 	if (input_tx && input_file)
 		pabort("only one of -p and --input may be selected");
 
+	if (compare && mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
+		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");

-- 
2.56.0.rc0.108.gf0ef1b96a0

