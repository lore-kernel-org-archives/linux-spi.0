Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F53DB322;
	Mon, 14 Sep 2026 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397466; cv=none; b=nm166heCr68mAbajWobv4LrsKvNtZ/98pYYKAPrmsDhIqNmN05QKOi2dcUS+c33FwRQ4Y+AAjmmL5QDFT0Ft/rxxSNzw0a0eGv52F47tcHlW923QrO0T+IaFHfO7eQ9yqvWfTTIb6kt2AvHtDIPnAx0UBc9dtU6ywI6t/yTM7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397466; c=relaxed/simple;
	bh=pLGzksEYxAMowkLCkYjKre8q9DTVGCylcDcx6ArTnDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnd/fc2hp6b/gLbdVfkdpEQKFEFZNLjQ6beAmM5dka4/7LPR0d+Pp6cdhaUPKz37ojvNWyFYIF0hfRZ4MrWJ+BnHtguHYCyL6uLkCa75J0ttP3XaemPhfYRSZKfpty4w6HsRv/FXn9TtQrC0ZgTSmZTB4G9yD7dOggK2EPBcYdc=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 330A2202891;
	Mon, 14 Sep 2026 16:50:55 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x681H-000v8b-0M;
	Mon, 14 Sep 2026 16:50:55 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 14 Sep 2026 16:50:43 +0200
Subject: [PATCH 4/7] spi: spidev_test: don't send 0x0 or 0xff
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-spi-sun4i-spidev_test-v1-4-72d6a3b38cee@pengutronix.de>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3470; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=Mw7mDN17u8DrdK4YWIBU+Wo0Q9q/V1Teq2WQR79/RDk=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshawXn25tX32z9e2ftiD9dsv818OT90V5QpXF9+X/Tp1
 B3ukhwv53SUsjCIcTHIiimyxKrJKQgZ+183q7SLhZnDygQyhIGLUwAm8u86w/+Yo7KXA5NOl74K
 v/iF/di7w+8TeJJfJAfcke766clzIEaIkeHp132K3C3LZEqmBaYdUPJ2Pj7xnYFp+BuVbydWy02
 4cpsdAA==
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
 tools/spi/spidev_test.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 6b0e839e6c33..235b267c02f2 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -47,6 +47,7 @@ static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
+static int nonzero;
 static int do_tx = 1, do_rx = 1;
 
 static uint8_t default_tx[] = {
@@ -175,7 +176,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbdilctropsvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbdilctropsvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -199,6 +200,7 @@ static void print_usage(const char *prog)
 		 "  -i --input          input data from a file (e.g. \"test.bin\")\n"
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
 		 "  -p                  Send data (e.g. \"1234\\xde\\xad\")\n"
+		 "  -z --nonzero        Don't send 0x00 or 0xff bytes\n"
 		 "  -S --size           transfer size\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
@@ -236,6 +238,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "input",         1, 0, 'i' },
 			{ "output",        1, 0, 'o' },
 			{ "size",          1, 0, 'S' },
+			{ "nonzero",       0, 0, 'z' },
 			{ "iter",          1, 0, 'I' },
 			{ "bpw",           1, 0, 'b' },
 			{ "lsb",           0, 0, 'L' },
@@ -248,7 +251,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -337,6 +340,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'S':
 			transfer_size = atoi(optarg);
 			break;
+		case 'z':
+			nonzero = 1;
+			break;
 		case 'I':
 			iterations = atoi(optarg);
 			break;
@@ -434,8 +440,11 @@ static void transfer_buf(int fd, int len)
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
@@ -471,8 +480,8 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (!!input_tx + !!input_file + !do_tx > 0)
-		pabort("only one of -p, -i (--input), -t (--no-tx) may be selected");
+	if (!!input_tx + !!input_file + !do_tx + !!nonzero > 1)
+		pabort("only one of -p, -i (--input), -t (--no-tx), -z (--nonzero) may be selected");
 
 	if (compare && (!do_tx || !do_rx))
 		pabort("-l/-c conflict with -t or -r");

-- 
2.55.0.806.gb8242b093d

