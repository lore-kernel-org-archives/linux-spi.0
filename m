Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924248D890;
	Fri, 18 Sep 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736019; cv=none; b=ulLjTbbyIsXpnIB+Sba66V9uToi35uqqOElAEN/Ib8c2eMLKLqgbG3SVEnwiHKGjf6j3JgPOQOqh8J/jZrSidmAs8EV5Kc0D17QsJ0UnadY3J6xKWRu2a5YchWIt92UCMsm6bKuoEWnIewCiB/I+SIPt5W8frww9rDXMnMNKDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736019; c=relaxed/simple;
	bh=4JW+YvKXA5jdPrcDK6dFf7gDOuyqcwx/9aHDQ0RE974=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbIPe5Hl9vMyjPM564EVptRd8nLFNvUC4Ljzti2Y91a8W/03/NqY+B7O+uIuZL1lXw8MPWREPhWrxpnwUvVlyyJ9HPfSe5bUawlbt4Qg7GSgYiEfbu3fG+ldGnWMpM+KvyDkdPLfe09y4QZ3e23Mxp6ADwQdv5oaSOP4ch8UotE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 58AF4200B4C;
	Fri, 18 Sep 2026 14:45:12 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7Xxo-001Zaf-0r;
	Fri, 18 Sep 2026 14:45:12 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 14:44:58 +0200
Subject: [PATCH v3 4/8] spi: spidev_test: don't send 0x0 or 0xff
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v3-4-d3ca218d9f76@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3446; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=v3umAC9d76AWxUkUnDovEjxRqiyGKD0e5TDKo1DfXwA=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaaxT6VZZP4pb0xIzMqZ+yjKs1Wv9UZa5Oem1nmT7v9
 afFD9mlO0pZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABNZE8rwh9dCYHtTFpvima6V
 u8+vWPPUKdzj4dmakr87c44IZhooazIyTO2q+m1aoS0fESusml69mis0wH2WieO2iOmK9wq8Jiq
 wAgA=
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
index dce7583971c7..fcef8cdbefd2 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -45,6 +45,7 @@ static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
+static int nonzero;
 static int do_tx = 1, do_rx = 1;
 static int input_choices;
 
@@ -174,7 +175,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -198,6 +199,7 @@ static void print_usage(const char *prog)
 		 "  -i --input          input data from a file (e.g. \"test.bin\")\n"
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
 		 "  -p                  Send data (e.g. \"1234\\xde\\xad\")\n"
+		 "  -z --nonzero        Don't send 0x00 or 0xff bytes\n"
 		 "  -S --size           transfer size\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
@@ -235,6 +237,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "input",         1, 0, 'i' },
 			{ "output",        1, 0, 'o' },
 			{ "size",          1, 0, 'S' },
+			{ "nonzero",       0, 0, 'z' },
 			{ "iter",          1, 0, 'I' },
 			{ "bpw",           1, 0, 'b' },
 			{ "lsb",           0, 0, 'L' },
@@ -247,7 +250,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -339,6 +342,10 @@ static void parse_opts(int argc, char *argv[])
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
@@ -436,8 +443,11 @@ static void transfer_buf(int fd, int len)
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
@@ -474,7 +484,7 @@ int main(int argc, char *argv[])
 	parse_opts(argc, argv);
 
 	if (input_choices > 1)
-		pabort("only one of -p, -i (--input), -t (--no-tx) may be selected");
+		pabort("only one of -p, -i (--input), -t (--no-tx), -z (--nonzero) may be selected");
 
 	if (compare && (!do_tx || !do_rx))
 		pabort("-l/-c (--loop/--compare) conflict with -t (--no-tx) or -r (--no-rx)");

-- 
2.56.0.rc0.108.gf0ef1b96a0

