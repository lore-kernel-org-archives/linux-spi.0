Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A54D9572;
	Wed, 16 Sep 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580511; cv=none; b=aZR0Qz2h1dtCBwLeMlYuafw2ssB3ASd3udOrLWhs5itBqSB5HtLYt833NsxDJBwl2sd7n1oh3/OmDeoXZSR/GBD6T6yFb6AqPMK7H0rV+xfo64inylV/TMumk88t5qcCuxT5O7ovmfCu0Nl2bbq3cZtco3mhR5QyZephmEBL4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580511; c=relaxed/simple;
	bh=YAgUVcdbbMUdE+Der1NuFD51gUOg60O+5KQPe/r8y2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkKcB/AsWasW7kPvLyFlFKkTLlHPLVJA2lVmNPAN6CelYVjONGw5voLT2e4Kj5JYV76ivvxZVaVmifmk2ylcNfQK1LrbVf0bAxNjvFhrWMWxhmepf5+Q6Q6yuvN2cQrYei8d6v9CAo62Mfkia3MvKidPvOfS92vHMP3Ajc53qKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AF479202B14;
	Wed, 16 Sep 2026 19:41:29 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6tdR-001Gol-1y;
	Wed, 16 Sep 2026 19:41:29 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 16 Sep 2026 19:41:22 +0200
Subject: [PATCH v2 4/8] spi: spidev_test: don't send 0x0 or 0xff
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-spi-sun4i-spidev_test-v2-4-e7d25bf96e4e@pengutronix.de>
References: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
In-Reply-To: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=V5HOW+qe9y1hoBD5xHMMTx63hQXLftppCsPjFTs6X6w=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadeW4ZgpjXuujD2Hc3Xc+XLT4dCSmtZ7ViYVlcb1H3
 o0fP17v7yhlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAExklzsjw4EZ/sb3THP31ml+
 3sVidCHUVOnzFxWOa0oLtZPuPrtXdpzhf/FlsYvN30VuyC7Rn3iB72DfJX27oP92xxt/z2ZjSVd
 PZAUA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Particularly when using compare mode, if the controller fails to
transfer any data, asserting on a read of 0x00 or 0xff may lead a false
negative test, indicating a byte was successfully transferred when the
values simply originate from the pull-up or pull-down of RX.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index b4f9c40a246a..b8677fa3d134 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -47,6 +47,7 @@ static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
+static int nonzero;
 static int do_tx = 1, do_rx = 1;
 static int input_choices = 0;
 
@@ -176,7 +177,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -200,6 +201,7 @@ static void print_usage(const char *prog)
 		 "  -i --input          input data from a file (e.g. \"test.bin\")\n"
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
 		 "  -p                  Send data (e.g. \"1234\\xde\\xad\")\n"
+		 "  -z --nonzero        Don't send 0x00 or 0xff bytes\n"
 		 "  -S --size           transfer size\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
@@ -237,6 +239,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "input",         1, 0, 'i' },
 			{ "output",        1, 0, 'o' },
 			{ "size",          1, 0, 'S' },
+			{ "nonzero",       0, 0, 'z' },
 			{ "iter",          1, 0, 'I' },
 			{ "bpw",           1, 0, 'b' },
 			{ "lsb",           0, 0, 'L' },
@@ -249,7 +252,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -341,6 +344,10 @@ static void parse_opts(int argc, char *argv[])
 		case 'S':
 			transfer_size = atoi(optarg);
 			break;
+		case 'z':
+			nonzero = 1;
+			input_choices++;
+			break;
 		case 'I':
 			iterations = atoi(optarg);
 			break;
@@ -438,8 +445,11 @@ static void transfer_buf(int fd, int len)
 		tx = malloc(len);
 		if (!tx)
 			pabort("can't allocate tx buffer");
-		for (i = 0; i < len; i++)
-			tx[i] = random();
+		for (i = 0; i < len; i++) {
+			do
+				tx[i] = random();
+			while (nonzero && (tx[i] == 0x0 || tx[i] == 0xff));
+		}
 	}
 
 	if (do_rx) {
@@ -476,7 +486,7 @@ int main(int argc, char *argv[])
 	parse_opts(argc, argv);
 
 	if (input_choices > 1)
-		pabort("only one of -p, -i (--input), -t (--no-tx) may be selected");
+		pabort("only one of -p, -i (--input), -t (--no-tx), -z (--nonzero) may be selected");
 
 	if (compare && (!do_tx || !do_rx))
 		pabort("-l/-c (--loop/--compare) conflict with -t (--no-tx) or -r (--no-rx)");

-- 
2.56.0.rc0.108.gf0ef1b96a0

