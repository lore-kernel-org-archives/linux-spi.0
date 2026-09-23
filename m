Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558D5678F1;
	Wed, 23 Sep 2026 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194534; cv=pass; b=D9w2+0Qb7sJAbV8KITujSuV0aeCPtlDOvGSIo6/APaIseL5I5+dOZuTGrEugDnTFZ281pTRR2QFG4NaI35r2yevCaUfK9DuC1ohxWhUxGrgUE8XizWT9jcVhhPr7VqeJkgCCELMbcMT3SgrZt5LcRgIQ1xrvw6ZAHMeTte01Zps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194534; c=relaxed/simple;
	bh=4qdD4jbz/LyLufcNQOhcZl+57WSq5cvo7q3Igr3BkXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7bwJnl2v+zQLHQyO9laX/Xmv2muM0sIakJrKyYGkXUi0tHwFAkz2O5HKo8Ep3ooVg13CtX69cgg4Gvm52go5aF4lw4xbrQv0Dv/xgRAM7T1Ch1w07g7mr6Ud85Z7PXQSRVAxisnlyrnZKtrTSdfi/Zzj6JoDzAhnCcHuqxBayo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=SIBcGzgW; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="SIBcGzgW"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B024620200E;
	Wed, 23 Sep 2026 22:15:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOTFH6Gb1kpjuq9poq6S2LaSZyLKcNyrqGl6ITny74A=;
	b=SIBcGzgWwve7NXdR+Gx1LFR/PWMq6Ksw3cj7I0XNo63mNcI6uROXmGTlPUucdzv+kqa5oh
	kXNGhZyde5iy3sKPrsofn21k+jUf1P1IjYnLbNwKoqRSSvczvPnDM4jUjxAewV0qt8cQ3a
	WJDx/dkalrGoosQ88PzZo2gm0f++KnjuMy79qPszupxJicFwwVMYcWeQMZijqnOOz50cbX
	ToMgybzHsUToWWGUACdHFrUUDhxolEJIFvY6EjHpvFHr1dug6bFTb5T9PZhZ8ndTrCdaw6
	e+yLVB6L7U37huw4mw9fzZJCzPIXByCoDlG39Zfty7sJCA2U7t3c8gO3mhudXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOTFH6Gb1kpjuq9poq6S2LaSZyLKcNyrqGl6ITny74A=;
	b=LWwJNLuND/yzt2+4uMByAAf+cxdrMcZ3fM7v9R0LVP+3tlKTAh3e++W+prgxAn5zcYX+JE
	zOyfu0lEyNBNsLpFgDTK72NOa+yVjWSjpMXpEVx327yb2jsVwbMk1oTLgif4L3riSS9odk
	27jRx+jdf5SCVhr8T5rGclTxqs1Q1f85lwWlhBAa2dNPfDamYFASuYJVJ82wr2aCDsHMft
	qMD+92nRiRs36k7exAsa/ZpVxL/pp35EjvourPbPxyPQFRKB/wIhQP3CerhWvg7tmx4mXQ
	i/VeUOS9CQvo2bnv2mCOlUXQFT0YL5Bbve611pLi+Exiw8pyS4B3hDmyaIzyEw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194519; a=rsa-sha256;
	cv=none;
	b=G8+bi+CkD1u3+0bk/F9k/o/zQPWyu7aiF9g6tZCjD0XlksGz/mnbxo5Ju4lhIIwTsJa8Zy
	tUX6Mbs7Xtm1G9FjRhGwfwL/XgMhbfM0PoCKYynfHWj4KvbXWM1U25fLsRyu9ZvT3wfD8O
	lptqnTgW+sL3eOvADWv6lPECkGV+IcLJGyRFwsZekR1j80lduWCf980icoz9DdTgpKkz8Q
	9m/do4cCPBp6E9W0pnvRtWZZfpHWGdK6ehWJxt8/kXxsNpO77LjOwjoGV+jcnXIBTW6rZP
	ouTX6h+MEiYmEy1C/w/fU9EeUZ0rmEttVuVBg1zYHaYcCxwVBRwr2PvIE6JjEA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-2a;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:10:05 +0200
Subject: [PATCH v5 10/13] spi: spidev_test: send predictable data
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-10-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4443; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=4qdD4jbz/LyLufcNQOhcZl+57WSq5cvo7q3Igr3BkXQ=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiQrtTS47wY795npJf45DfdWsFqdU5EQbpQ6XTbr0
 72CoIPWHaUsDGJcDLJiiiyxanIKQsb+180q7WJh5rAygQxh4OIUgInob2NkWNd5ZF/RHPumSDvn
 kpP/X581tuY30HZdpmP+5XCn0pW6NEaG5VwTtc8/kSpaayx/rN3v18yljP873wrNq+le2VN6Z9V
 LRgA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

Introduce a flag to test on a predictable byte sequence instead of
random bytes. This is useful when comparing multiple runs with the same
option set e.g. with an oscilloscope.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index e7ee7d5a701e..56b71b842fb5 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -48,6 +48,7 @@ static int compare;
 static int nonzero;
 static int do_tx = 1, do_rx = 1;
 static int random_input;
+static int predictable;
 static int input_choices;
 
 static uint8_t default_tx[] = {
@@ -188,7 +189,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvwz]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNOPRSZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -213,6 +214,7 @@ static void print_usage(const char *prog)
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
 		 "  -p                  send data (e.g. \"1234\\xde\\xad\")\n"
 		 "  -z --nonzero        don't send 0x00 or 0xff bytes\n"
+		 "  -P --predictable    transfer the given number of sequential bytes\n"
 		 "  -S --size           transfer the given number of random bytes\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
@@ -258,12 +260,13 @@ static void parse_opts(int argc, char *argv[])
 			{ "no-cs",         0, 0, 'N' },
 			{ "ready",         0, 0, 'R' },
 			{ "mosi-idle-low", 0, 0, 'M' },
+			{ "predictable",   0, 0, 'P' },
 			{ "verbose",       0, 0, 'v' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:zI:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:P:vS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -341,6 +344,11 @@ static void parse_opts(int argc, char *argv[])
 			input_tx = optarg;
 			input_choices++;
 			break;
+		case 'P':
+			transfer_size = atoi(optarg);
+			predictable = 1;
+			input_choices++;
+			break;
 		case '2':
 			mode |= SPI_TX_DUAL;
 			break;
@@ -461,9 +469,17 @@ static void transfer_buf(int fd, int len)
 		if (!tx)
 			pabort("can't allocate tx buffer");
 		for (i = 0; i < len; i++) {
-			do
-				tx[i] = random();
-			while (nonzero && (tx[i] == 0x0 || tx[i] == 0xff));
+			if (predictable) {
+				int v = i - iterations;
+
+				if (nonzero)
+					v = ((v % 254) + 254) % 254 + 1;
+				tx[i] = (char)v;
+			} else {
+				do {
+					tx[i] = random();
+				} while (nonzero && (tx[i] == 0x0 || tx[i] == 0xff));
+			}
 		}
 	}
 
@@ -492,16 +508,16 @@ int main(int argc, char *argv[])
 	parse_opts(argc, argv);
 
 	if (input_choices > 1)
-		pabort("only one of -S (--size), -p, -i (--input) may be selected");
+		pabort("only one of -S (--size), -p, -i (--input), -P (--predictable) may be selected");
 
-	if (random_input && !transfer_size)
-		pabort("a nonzero size argument is mandatory for -S (--size)");
+	if ((random_input || predictable) && !transfer_size)
+		pabort("a nonzero size argument is mandatory for -S (--size) and -P (--predictable)");
 
 	if (iterations && !transfer_size)
 		pabort("-I (--iter) is only implemented for -S (--size)");
 
 	if (nonzero && !transfer_size)
-		pabort("-z (--nonzero) is only implemented for -S (--size)");
+		pabort("-z (--nonzero) is only implemented for -S (--size) and -P (--predictable)");
 
 	if (compare && (!do_tx || !do_rx))
 		pabort("-c (--compare) conflicts with -t (--no-tx) or -r (--no-rx)");
@@ -510,7 +526,7 @@ int main(int argc, char *argv[])
 		pabort("-r (--no-rx) conflicts with -o (--output)");
 
 	if (!do_tx && !transfer_size)
-		pabort("-t (--no-tx) is only implemented for -S (--size)");
+		pabort("-t (--no-tx) is only implemented for -S (--size) and -P (--predictable)");
 
 	if (compare && mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
 		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");

-- 
2.56.0.rc0.108.gf0ef1b96a0

