Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61106502D59;
	Fri, 18 Sep 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744994; cv=none; b=tnLDlEA3jQd+j5kq0mLgmq0trNrd8dYNzeDyhwhOkseEKaPQzedeZk94+8+PnQr8FZPgGGeUhW8fjq4qObYdA3kgBrMKF+QcQXXfHP3XxxuPcPiPv/Twx+2CSCKjGsw3e0PLgzbnONIlT59xUrC5mjeMXGgDqzkUW4l8vUNooxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744994; c=relaxed/simple;
	bh=teDU+jsKaLqxcV9T2d/W44RsJpnkOzRGmLjayhbf0Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=navYhOsNgNtGfQioSI8brrAB/fWho5hw/EK+okVpARsjrnsMwvOpFy2XgUU/7s9YrS/N2HolPE/Bp+P6OrZFnK2gAcWaKHZCgO7VX185OCxq33kbnuzeNFLmp5kfBFeJYht3AScDQGP3rDEisxNmRtWtU///g3T85P9x0LJwOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6B2D3201DF6;
	Fri, 18 Sep 2026 17:23:01 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7aQX-001awp-11;
	Fri, 18 Sep 2026 17:23:01 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 17:22:52 +0200
Subject: [PATCH v4 6/9] spi: spidev_test: send predictable data
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v4-6-5ffacb1a4ebd@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3374; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=AlWK5cCS//6rBkEsTOGeF1HnmyMz5zeZy/fD+EBk87o=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaGx4skpyg23wgp7150YOoy08UDm6u8zA6Xp693eTzv
 +rji+vcOkpZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABP5NIPhnwqDrXFg6vXm1hnT
 vp5y+1W5RC81/cPDxt4HOwpE3j9cb8zI8Jbtne6+yHunXp/Lfy9o+S7g6Y2ab+oTT/hy9ATd9Ph
 8mQUA
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
index c34601558646..21a631d346a4 100644
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
 		 "  -p                  send data (e.g. \"1234\\xde\\xad\")\n"
 		 "  -z --nonzero        don't send 0x00 or 0xff bytes\n"
+		 "  -P --predictable    send a predictable sequence instead of random numbers\n"
 		 "  -S --size           transfer the given number of random bytes\n"
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
@@ -329,6 +332,10 @@ static void parse_opts(int argc, char *argv[])
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
@@ -448,9 +455,13 @@ static void transfer_buf(int fd, int len)
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
 
@@ -488,7 +499,7 @@ int main(int argc, char *argv[])
 	parse_opts(argc, argv);
 
 	if (input_choices > 1)
-		pabort("only one of -S (--size), -p, -i (--input), -t (--no-tx) may be selected");
+		pabort("only one of -S (--size), -p, -i (--input), -t (--no-tx), -P (--predictable) may be selected");
 
 	if (nonzero && !transfer_size)
 		pabort("-z (--nonzero) is only implemented for -S (--size)");

-- 
2.56.0.rc0.108.gf0ef1b96a0

