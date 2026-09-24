Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BDB47F3D0;
	Thu, 24 Sep 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252858; cv=pass; b=IQ/zQVp4pikvsneE3C1I4bMkBhcJ4Ov/S2SYJPWmiU0D5R0o7bMaiG6UCu8A4/WWHV5el487xFLr0YIMzZ+0dnA4e+wWslWlqtj01R4vs2HUICWKGkb60WLDVCrdDT3foQO4llSBlHpmshNsHIg1FvSulf8oBDzmjI2FIqScNL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252858; c=relaxed/simple;
	bh=GE2IZwoNuKbcimoAQbnNFI8jCDtlCm5Q7YBRLHm4kwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJFedVV3lJvE6M0PYe562FFcguIEEDfllXjXjW5LkqnmzFDVyWw68wRpQz0SC+VhhPxENYiRSlwUuLb4VYTxMR7wW7SZrOmTOO5kd6ruS8Rl9xqTUI4vEWONAMnhrMlYch0VQSXWZaQwoW8ZAddgM14NUH0tmAv3K7B7EcJY5J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Vt+q38zc; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Vt+q38zc"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 37DAC202146;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UrzVfIS+tiJtdHJqi30Cc56dsqG2vVFZJsao508Mak=;
	b=Vt+q38zcFoh3wypzjW1M0lC0UpqrJ3lJkXEQFXDtjAGnRCzuysVY5x3YlGm/V3Ob/eGfHr
	Cu0LNBQqmgIJpqUnpwlHIwYC8i0aRjLhF2fIyxwI7P5gg65m5KrXVYo/TySMTD2lk1Dhxk
	4mkjCwSU62OOiSeH6EfcbCiE9MqViAP6GDE9zfjcarQrYEutYmsyS05nV/+L8UHrkp5szd
	gSZO3lE1wD8aAT2CrOUoBfBU6vr63Wbe6xq3ViejPrOgpi/xTDkfLuU+OVYAMMHDOqgyxN
	PPcIqP57q316bQYVUDWYe9kkhUqpKbIucLNArsCAM1aDc+h/tOecjfVhdSbUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UrzVfIS+tiJtdHJqi30Cc56dsqG2vVFZJsao508Mak=;
	b=FynnGxP1vDFN+J/M2ZcoKkt2Ip90HYpn2s5GhPpIGb414rJF/ufaT+t9OTNo6DMU71vzpE
	L7j2AMu1zFWdCFllR4u+WitVjXzZo/weJPNID5rx8YkX8vRAeIThtNZaqmi6s7JEsf9m30
	r57zPJrXCOsK9MhdOACNbs/njPAzXQIy7uNXSzi2LaC+Qh3abARcjmfvRg2aZ5tjw/VR3A
	ApXZ5CmocSEFNcp5EduztPsd4XSd2fSOD9+g01nIZc+JCAATh492LHn70RTdqT8E23MMwz
	5fFKc6d7rjLTtDIi+cIOGFkNPxMpav0VFG5qSNQvxguGGaxWIWEhjAIDhLHs3g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=Z/Ue4Zq/ea1byQjO79B59t7RkQ4B4KCxrqFdqLOcO4gb3iqTUZpiORj/uPf4Jfph9G8WlF
	Qo5T+EPPof6iFvNcdBlOdr4plAmIlbN7nyx/FjqkbZeOMPS50rHPmmTNWOdHT0scaNgVpL
	0ByZuCYNpdjxVJBR+H9+8yeAGaGA4407bEQyIWRDazQH8qY+I3yug6H0WU7cfXejG7qZYV
	y24Uv9jg8EeD53R9kwvhalutsgMIGiKlF7U/lBDjCgljdrVahHmTivoT5pYipppSzM36BB
	e3bXekjvVhGBrguqV7Bc1FMQKex4pfrNl4vDEkNVcmskW2umgEn3dwi5lXuEOw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id ED3E038099B;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:23 +0200
Subject: [PATCH v6 07/13] spi: spidev_test: add compare mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-7-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=iiVt8FFbdDNYXbVlEGd24i9U1o2f3a8oqYSP+ebf+Zc=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKq77dj9b1ofZ+RL3V63nO3CxY/5zaaa7XT2Ct60n2
 jPHPWN50lHKwiDGxSArpsgSqyanIGTsf92s0i4WZg4rE8gQBi5OAZhI/wOG/zV73do4r9Rf7X/N
 xf7tacs84+zUTs9Ijm/JZkXbZuZsus/I8HUPj2yAz3+BVzrSHVm8Fzg+rF954qbgm5xdOzfG7Od
 kYgEA
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
index e46eaef4d2ab..7b343803903e 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -44,6 +44,7 @@ static int verbose;
 static int transfer_size = -1;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
+static int compare;
 static int random_input;
 static int input_choices;
 
@@ -174,7 +175,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 	if (verbose)
 		hex_dump(rx, len, 32, "RX");
 
-	if (mode & SPI_LOOP) {
+	if (compare || mode & SPI_LOOP) {
 		if (memcmp(tx, rx, len)) {
 			fprintf(stderr, "transfer error !\n");
 			hex_dump(tx, len, 32, "TX");
@@ -186,13 +187,14 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
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
@@ -230,6 +232,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "delay",         1, 0, 'd' },
 			{ "word-delay",    1, 0, 'w' },
 			{ "loop",          0, 0, 'l' },
+			{ "compare",       0, 0, 'c' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
 			{ "rx-cpha-flip",  0, 0, 'F' },
@@ -253,7 +256,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lcHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -285,6 +288,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'l':
 			mode |= SPI_LOOP;
 			break;
+		case 'c':
+			compare = 1;
+			break;
 		case 'H':
 			mode |= SPI_CPHA;
 			break;
@@ -466,6 +472,9 @@ int main(int argc, char *argv[])
 	if (iterations && transfer_size < 0)
 		pabort("-I (--iter) is only implemented for -S (--size)");
 
+	if (compare && mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
+		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");

-- 
2.56.0.rc0.108.gf0ef1b96a0

