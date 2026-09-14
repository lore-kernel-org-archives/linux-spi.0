Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A34825BF;
	Mon, 14 Sep 2026 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397478; cv=none; b=fbZEBUBln6A6BQmJ0O2Vjg14krf1YVVuYyh4j79bp8vVYWPpdd+pftLw+5a/LmcOaP2y17JBpBram2VzsZwU54y2ACr/HsFhGk85Tn0iAga+G0Ry0tG5nbTL3CEu5txqlmfNOQ6MOcuHKqbaAnQl8gl7wzuOzFz6bSuUA3hvbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397478; c=relaxed/simple;
	bh=btyTcGPaP8SY8f7pIEybVB2fgyhjoMTv2WLbDP5WQiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtNhnk4r0AaVxH1edXSGFqN0VLGfscSBheeJoxbmT9301QelTEI6pqT3rTFRTBMiTBsio6I2SdSE5AaXXfWZEda6u0HKLOa8SaLU3SJJeZtjb03D1xMeo8um2DUzbLMmP5Qak78Kh5VcNAZgJh9+V+WHyyHfXEtM7eBIdkxj01E=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 40993202892;
	Mon, 14 Sep 2026 16:50:55 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x681H-000v8b-0X;
	Mon, 14 Sep 2026 16:50:55 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 14 Sep 2026 16:50:44 +0200
Subject: [PATCH 5/7] spi: spidev_test: send predictable data
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-spi-sun4i-spidev_test-v1-5-72d6a3b38cee@pengutronix.de>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3393; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=hyW09/s5603f18FDZkFHpbL0CwnQrbEs+ELS75Vgv7s=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshawXl2e0pz0895RlPOHY2aqek7d3Pion+f3ub9anLzT
 Iq+YBR0tqOUhUGMi0FWTJElVk1OQcjY/7pZpV0szBxWJpAhDFycAjCRL58YfrNN60rYlrBf7eO/
 RFOJH+8PZTRc/ClZkBYzw+QQq8m0a6oM/5QbQgN6d23JfsGcKbqs7IRmVpaEwpdl/tsvXMx90Xg
 /lhMA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Introduce a flag to test on a predictable byte sequence instead of
random bytes. This is useful when comparing multiple runs e.g. with an
oscilloscope.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 235b267c02f2..4d35ac0d9a48 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -49,6 +49,7 @@ static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
 static int nonzero;
 static int do_tx = 1, do_rx = 1;
+static int predictable;
 
 static uint8_t default_tx[] = {
 	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
@@ -176,7 +177,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbdilctropsvwz]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbdilctropsvwzP]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -201,6 +202,7 @@ static void print_usage(const char *prog)
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
 		 "  -p                  Send data (e.g. \"1234\\xde\\xad\")\n"
 		 "  -z --nonzero        Don't send 0x00 or 0xff bytes\n"
+		 "  -P --predictable    Send a predictable sequence instead of random numbers\n"
 		 "  -S --size           transfer size\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
@@ -246,12 +248,13 @@ static void parse_opts(int argc, char *argv[])
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
@@ -328,6 +331,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'p':
 			input_tx = optarg;
 			break;
+		case 'P':
+			predictable = 1;
+			break;
 		case '2':
 			mode |= SPI_TX_DUAL;
 			break;
@@ -441,9 +447,13 @@ static void transfer_buf(int fd, int len)
 		if (!tx)
 			pabort("can't allocate tx buffer");
 		for (i = 0; i < len; i++) {
-			do
-				tx[i] = random();
-			while (nonzero && (tx[i] == 0x0 || tx[i] == 0xff));
+			if (predictable) {
+				tx[i] = i - iterations;
+			} else {
+				do
+					tx[i] = random();
+				while (nonzero && (tx[i] == 0x0 || tx[i] == 0xff));
+			}
 		}
 	}
 
@@ -480,8 +490,8 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (!!input_tx + !!input_file + !do_tx + !!nonzero > 1)
-		pabort("only one of -p, -i (--input), -t (--no-tx), -z (--nonzero) may be selected");
+	if (!!input_tx + !!input_file + !do_tx + !!nonzero + !!predictable > 1)
+		pabort("only one of -p, -i (--input), -t (--no-tx), -z (--nonzero), -P (--predictable) may be selected");
 
 	if (compare && (!do_tx || !do_rx))
 		pabort("-l/-c conflict with -t or -r");

-- 
2.55.0.806.gb8242b093d

