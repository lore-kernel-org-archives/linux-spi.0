Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A7481220;
	Wed, 23 Sep 2026 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194226; cv=pass; b=JftoYMo5+wz5H+n+Twia0/S9bdzciTFunf78dw+K0x+PauhHZC3l7UiJSKXkZBX4wZI0WqZm3o/Ri9ANTQSphwBFQh9KK1/BU1HTEkwIvvxVmv9aUieLZ/h8LuYfGS2bnhIBPiEsx/YLCDKQmL/k0B/7fHUfudWxD+Zg2vWgQv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194226; c=relaxed/simple;
	bh=Zy2TpJeok72ZTpepi7IceM0CjcMexXfnoHxWfcc4xZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5mlOXIBC5M1DRHK49XyQdN9q67NKjoD++2S6+JHzK6haehP6jvjdopfJ2ADh9B2nHg1LQpkYk9+Rxu74WYL0SX1FircUUZn4635x3Pj5oIuR+j0CxVsVPR/6FO9QMgGCTfiOUUbY/ENertoiEqtxQ+bxf9p5VSc6jKqnfvcRg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ALk/VpGd; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ALk/VpGd"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B8C46202040;
	Wed, 23 Sep 2026 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKUMYK9LZH4KTHBUyGfi5gylC3sySrNHoS5Iqb4EZuc=;
	b=ALk/VpGddlS/2KWvu3d3wokIOSzRUk/wpdLEf5/CEWRa11oY4xM+WVV4yOPMrpKUi/fVO3
	oz6sKytIW9wxcHX9BMdqKmsOCEb+eehdLEU4OlyHeWTnrlRgKrZfcw+03CsjqyTZ/Ij9/Y
	CuRzWpMznq8rJGnwrCARCpU5r0yIRV6RMQpnBeiGu5smBXLStWw5DxyBrdowLv27TNjjvI
	OrUM9P/rYHd+kqKiZ7FYdqB1LF+/ah8f9E34uNluZCm/lyK0N7nrLsXKSC+d2vn5WTFf5Q
	HSHdzJuxnljlnFg4v5ghhaej836ZGwe/N8twavYvxTHKcS5bD36LAaGzmDQkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKUMYK9LZH4KTHBUyGfi5gylC3sySrNHoS5Iqb4EZuc=;
	b=L9UQacbv3h/d9g3tlvcUkntTZp1nnT2BpMozhlMXAtFyL2h5KA7FdNH9yFLLoWC2zmnwbm
	RrZSw0ZU/+uTUuAplMsy5lrSptKj/DTG4iWwfEl4OiT8GA25ni7sHtuykCGOSxKvWzQGAu
	VCTk04IGRfqXdQxuhS3ff66YOMuAd/Bv5WMZOHxrTs/UEJj2aGA05d35x+MX6W2WMtVE23
	SpfVMFI4X3OjoFAvVKIpqNDt1fd5pbzp4qATmbGmgp2V1KwB0GjToSp/s3i78+2kmZA9/I
	I2o0e83dZvvbvNKvtGEZDEEzMm0IKkRso1IytndJDf5cXup8j+4L3VG20oqrjw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194207; a=rsa-sha256;
	cv=none;
	b=O3se0qSSY2Eiog/uUdVyXDXolEwjuXKm0ArKIHhhL3GDojY5p8zAamfAZ1SQdU3uFQIzST
	A6wIN9c7B73RDJSDA1DegLE0KN2x/EzExdNFnCKyYGSSyldu4SjpR6BjR/OM/NpYY8xJLg
	uClj6X8Ttgl5ZNkzaPQ2tl/RoPY62fZr4kwon+M80jY0GsnGimHZDFUxU011gbbhxszYiK
	zbUi6yaZfrZ4fl6hxht5i0W3ARaPFMEuzGK50FeK47WCrWEtfVQdNJVLbaB0/wxrWSqbPF
	EGNMuWUIYzod2OaCBL466pCaVhXBWknB8f/WFzH37ErOPgUT4xklhMzZ0bngAQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-28;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:10:02 +0200
Subject: [PATCH v5 07/13] spi: spidev_test: add compare mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-7-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=x+2HaQAw5mXIZYoBGkjt++b/iUvsl2DIGSNq2GMl9sI=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiR9s8Ce1UvPx03+2f6z4UwGd5urb1Um8Wbr7lkvI
 f3GsTexo5SFQYyLQVZMkSVWTU5ByNj/ulmlXSzMHFYmkCEMXJwCMJHXtowMW9xK3PLNj+xKmb7T
 zevREQnW39rbptRt4UkUyl4tHXovj+F/5vXA5yWzf7zrvrqlw73X7NQBxnkfkj7fnbH+kDB7/HI
 3PgA=
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
index b413c713174f..55944386cd69 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -44,6 +44,7 @@ static int verbose;
 static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
+static int compare;
 static int random_input;
 static int input_choices;
 
@@ -173,7 +174,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 	if (verbose)
 		hex_dump(rx, len, 32, "RX");
 
-	if (mode & SPI_LOOP) {
+	if (compare || mode & SPI_LOOP) {
 		if (memcmp(tx, rx, len)) {
 			fprintf(stderr, "transfer error !\n");
 			hex_dump(tx, len, 32, "TX");
@@ -185,13 +186,14 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
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
@@ -229,6 +231,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "delay",         1, 0, 'd' },
 			{ "word-delay",    1, 0, 'w' },
 			{ "loop",          0, 0, 'l' },
+			{ "compare",       0, 0, 'c' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
 			{ "rx-cpha-flip",  0, 0, 'F' },
@@ -252,7 +255,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lcHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -284,6 +287,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'l':
 			mode |= SPI_LOOP;
 			break;
+		case 'c':
+			compare = 1;
+			break;
 		case 'H':
 			mode |= SPI_CPHA;
 			break;
@@ -464,6 +470,9 @@ int main(int argc, char *argv[])
 	if (iterations && !transfer_size)
 		pabort("-I (--iter) is only implemented for -S (--size)");
 
+	if (compare && mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
+		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");

-- 
2.56.0.rc0.108.gf0ef1b96a0

