Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF7481255;
	Mon, 14 Sep 2026 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397466; cv=none; b=QwBoRTHdb7K4lO8JMcJZtV+IDcnb53zNARW7c/9MmfvBucah4e9A3iCcJy9OZfsd33OYBS2DkwixIYUWpDWgcRoOKojxbRhcHZDw67PQpTPnQvs3bvc94SRpmYJEhwjunrLxDeRrLpSU7QsEeixMAVsR8GAVFMkt7bjOmK7Av4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397466; c=relaxed/simple;
	bh=O2mIRbzfyydoVcq6ZD+4eXn2XyRdMD7JsGA2cqw1IW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0G6CVS6tYpmWL+/3SO7YrWs2HNtgIH65lfJqC9RH/hQVnRQKMJV14fRfK2AVrwY0ACsnwvWivOi25xPzszYRlN2aS0f+qfND1TjPVQSi0+eP6udyZCfzANinSrL5gDlY3vUMMKrnJm+YRuY7gbdWo2nZNafW+z+Bl7/tKbanYA=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 24D2F20288B;
	Mon, 14 Sep 2026 16:50:55 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x681H-000v8b-06;
	Mon, 14 Sep 2026 16:50:55 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 14 Sep 2026 16:50:41 +0200
Subject: [PATCH 2/7] spi: spidev_test: add compare mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-spi-sun4i-spidev_test-v1-2-72d6a3b38cee@pengutronix.de>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2749; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=bDTMwUdBsSo0f0ru/t7hZY2vv3h+kAW8HmZqE7fjn+M=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshawXnGs1qKK+HhqZkPlPd8aJ0ZzDtX4WnrWXXFw/WZz
 kF9fzUkO0pZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABMp3cnwP9Vr47nVudfqpKab
 TTe7+/Q9a4nQ+Z1uMpOYJLcwKmZW3Gf4H7dlt8Bi9+03/TXvGFyJu6/FdfDqmV/X1Z+Jslgfu1A
 uyw0A
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
 tools/spi/spidev_test.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 8058a7830b50..05c585ea71b2 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -46,6 +46,7 @@ static int verbose;
 static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
+static int compare;
 
 static uint8_t default_tx[] = {
 	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
@@ -173,13 +174,14 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbdilopsvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbdilcopsvw]\n", prog);
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
@@ -217,6 +219,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "delay",         1, 0, 'd' },
 			{ "word-delay",    1, 0, 'w' },
 			{ "loop",          0, 0, 'l' },
+			{ "compare",       0, 0, 'c' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
 			{ "rx-cpha-flip",  0, 0, 'F' },
@@ -240,7 +243,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lcHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -270,6 +273,10 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'l':
 			mode |= SPI_LOOP;
+			compare = 1;
+			break;
+		case 'c':
+			compare = 1;
 			break;
 		case 'H':
 			mode |= SPI_CPHA;
@@ -427,7 +434,7 @@ static void transfer_buf(int fd, int len)
 	_write_count += len;
 	_read_count += len;
 
-	if (mode & SPI_LOOP) {
+	if (compare) {
 		if (memcmp(tx, rx, len)) {
 			fprintf(stderr, "transfer error !\n");
 			hex_dump(tx, len, 32, "TX");

-- 
2.55.0.806.gb8242b093d

