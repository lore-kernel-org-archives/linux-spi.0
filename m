Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A134D4DE;
	Fri, 18 Sep 2026 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735523; cv=none; b=VQ9sg+Oxyl/F5ORq0w8mnyhdNQ/NiCdu6LE6OljUndRTLjvMzuGXQQHaIP+CASOZHxW9dWvt/rhQxXGW0p9aQkDbiRH7pb79WmjS13wOwp8NB5iuQtXAD+kEGPZfeFOU+ZibsCVp5mBP/tYus4JfI63azxI6/335EVF+Kszexpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735523; c=relaxed/simple;
	bh=ym/o/NcL7ESv6D9+WfJITX3QAIkhTYSmwxgB4J0NN7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WC8Kld7H4HhmjhMmXgv3o18QUOIXHtGUKMxh2vAxdfJ0gBj+W5N0PGXRq2dw34OVTL90qYSb/3Hm1neHf1TuJfUq7KBY2M6HUF7Mcr6ppVOJh4pgBVbI2C+i604OsVxXZ+8t+goJQ//VEo7ct7q3wdINmOYJOCjZHJA6Grr604w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 63AC5200B67;
	Fri, 18 Sep 2026 14:45:12 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7Xxo-001Zaf-11;
	Fri, 18 Sep 2026 14:45:12 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 14:44:59 +0200
Subject: [PATCH v3 5/8] spi: spidev_test: send predictable data
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v3-5-d3ca218d9f76@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3373; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=YkRoTi7buq9hQM791dyaH9KNzd4yNxZXuKkrp3bzoRU=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaaxS2RvNEkx3DgUmq+XvvMW4yc1ybqsFw8ckrgY/P5
 xW6qP1q6ihlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAEwk4ysjw2q3rdd33Miwe/rx
 1auIoDVKy+8e+3BQPtv/mZzmVNFZ8uUM/2zfrMlL25V6OTLOU4TbqVKVq0f7tF79T7nQfckqc33
 38wIA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Introduce a flag to test on a predictable byte sequence instead of
random bytes. This is useful when comparing multiple runs with the same
option set e.g. with an oscilloscope.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index fcef8cdbefd2..011ac0593736 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -47,6 +47,7 @@ static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
 static int nonzero;
 static int do_tx = 1, do_rx = 1;
+static int predictable;
 static int input_choices;
 
 static uint8_t default_tx[] = {
@@ -175,7 +176,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvwz]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNOPRSZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -200,6 +201,7 @@ static void print_usage(const char *prog)
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
 		 "  -p                  Send data (e.g. \"1234\\xde\\xad\")\n"
 		 "  -z --nonzero        Don't send 0x00 or 0xff bytes\n"
+		 "  -P --predictable    Send a predictable sequence instead of random numbers\n"
 		 "  -S --size           transfer size\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
@@ -245,12 +247,13 @@ static void parse_opts(int argc, char *argv[])
 			{ "no-cs",         0, 0, 'N' },
 			{ "ready",         0, 0, 'R' },
 			{ "mosi-idle-low", 0, 0, 'M' },
+			{ "predictable",   0, 0, 'P' },
 			{ "verbose",       0, 0, 'v' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:zI:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:PvS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -330,6 +333,10 @@ static void parse_opts(int argc, char *argv[])
 			input_tx = optarg;
 			input_choices++;
 			break;
+		case 'P':
+			predictable = 1;
+			input_choices++;
+			break;
 		case '2':
 			mode |= SPI_TX_DUAL;
 			break;
@@ -444,9 +451,13 @@ static void transfer_buf(int fd, int len)
 		if (!tx)
 			pabort("can't allocate tx buffer");
 		for (i = 0; i < len; i++) {
-			do
-				tx[i] = random();
-			while (nonzero && (tx[i] == 0x0 || tx[i] == 0xff));
+			if (predictable) {
+				tx[i] = i - iterations;
+			} else {
+				do {
+					tx[i] = random();
+				} while (nonzero && (tx[i] == 0x0 || tx[i] == 0xff));
+			}
 		}
 	}
 
@@ -484,7 +495,7 @@ int main(int argc, char *argv[])
 	parse_opts(argc, argv);
 
 	if (input_choices > 1)
-		pabort("only one of -p, -i (--input), -t (--no-tx), -z (--nonzero) may be selected");
+		pabort("only one of -p, -i (--input), -t (--no-tx), -z (--nonzero), -P (--predictable) may be selected");
 
 	if (compare && (!do_tx || !do_rx))
 		pabort("-l/-c (--loop/--compare) conflict with -t (--no-tx) or -r (--no-rx)");

-- 
2.56.0.rc0.108.gf0ef1b96a0

