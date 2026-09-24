Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C04746B7;
	Thu, 24 Sep 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257454; cv=pass; b=fYkOqsCaVP1t3i5yMjjP5ZCoNCbazc4uKYLiBh3IJ0+mFEiXv5TqYUOKD8+m+3LRHp2UOVjwDyirX/hXEADILq7aZCfHNBfX2W0aAY7Z9BAmJEm2Uz2XnSKn5xUoP0aJl/gbmul7FdMFB7I6a/ZmxTndQ3fH7ni2MlJWssAiRGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257454; c=relaxed/simple;
	bh=QIM3ATguBW1KxFnBRxcFy1QeaPHB0iP0ILr09Q6npOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szHKfXHUzqfAYMVz2q4YYRaSPLBqWJpE1M3PKmzucRLWDN8eUY82pV8Xgr21HZMYnL2vbOxc8GyZE6alQJENaxT3geVBlrTqV5V7jhHQvnVX/milObMFlYUKmzjo7lm3xTvQwzBnihuQn7ASd+TFfRJ5N0Jl6lhEKjp5u26x/3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=BlQ7g70h; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="BlQ7g70h"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id ADB922010E2;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERK0rnOr1yfnoRiGKDjw68xenkNj89jkhbImLRhjWzQ=;
	b=BlQ7g70hbXkrKIQUXt5DDGUoAUMThpwj7JokOhb4fAzKTreCHNmCDil/oxAtHyp9p1E6j2
	We/u8VQTIGdgMxz4o+ZRQ4NLRdefOGzrHqN1E/RMyVClhZy7lhS84QlMAUTqelenrnQKoo
	pQYdvFrRC4mPefr3zhRSpPfUEhjAkuFRBTeljge8mqTuDq5BsPYHG9ZNNcc7hcd2KqGsXK
	NDIcvHbFhz7o/p5ZRMT/Y5twoAtEB0vahblJH9spdWhiOglHIAK7DOZbiV4q1jKKZa70bc
	svFzb97rGJzt5WnPWs36y1s0bCsKj6aG2FTfKok3JrFQZnqZZpm2dWdeWJWtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERK0rnOr1yfnoRiGKDjw68xenkNj89jkhbImLRhjWzQ=;
	b=Xm0/kWXOEW/nMfoL1Y2hPNvrrGldq2jirumZhl/ag0/rfrUg04X5dhMW0GszrgMX5tHB5P
	I79LqeHEvjbl0+wLefq+f0CC1cwYNRtBVSu87DW9Lz8i4sTL0EIHU6mzy312cwlHcB2UsW
	tTkINkBMFLRaofRA8m90XOrJK8yX+ct71onIYweANrFbE4dwYuMO/sxT3GuQFATE9WyBHF
	xfwspPUVYHH4I9AUrEqHmnYtMbGOg9Pu3+Oym5tizhxIvCDWHmc7l6/20V0X9oXipFcM6Q
	tvR6IQ4cBAFllPNT/rNoG2cDR33t/qZhKFdQg5AisuV5TMKJwp4vf9BJbdvGTg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=Nn56oz9jVMhf5KcNUhNNnWtjGSXByl27No5UOkUa1/OcoqURPLgkN4WPR17jpLkYIodthz
	nL/e4gmaVFrUHa39XhlBKomhJ6xQQSkLFxO0OZ9yq7UUg36ItuocpiTTqEA5bT8Tg7PX80
	wa1i34wz+hbUFK4hnR5p8zje5Rh4rbHEw1Bc3X7QlowtwR5so/gygxToDizJDcRTfyoqsG
	fjufGlo3lk8tI4RFAECLgADnJsqmqiwY9TdQzw6qCaAb2xKq0nqViDeulc/2KH3M/xOBM8
	b+HyypmTHrzw6oRrtK1x/m5d73leExBAZaxwMTSU6VqRg9eWQaWOYyGALqtqIA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 9478E3802CD;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:43:52 +0200
Subject: [PATCH v7 02/13] spi: spidev_test: clarify usage for --size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-2-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=QIM3ATguBW1KxFnBRxcFy1QeaPHB0iP0ILr09Q6npOc=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqqnIdWnlvZttF0656MfoqfQadVt+1EtU5w7PC316i
 f3Ehi9hHaUsDGJcDLJiiiyxanIKQsb+180q7WJh5rAygQxh4OIUgIm4TmP4w5lnO+HEKevE2lON
 Rk+aeypXNs4wbW9a38sym13pkeENFkaGkyd8FRI4+WaHbp0qv9wrlJk/0EJwaZp/pltk07SEfdc
 YAA==
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

By default, spidev_test transmits the predetermined message default_tx.
Given the --size parameter, the given number of random bytes are
transmitted instead.

Make all the input options (random bytes, string, file) mutually
exclusive.

Clarify the help text for --size.

While at it, make the -p help text consistently lowercase.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index bd5ee7a6ac82..0bd6ae419cbf 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -44,6 +44,7 @@ static int verbose;
 static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
+static int input_choices;
 
 static uint8_t default_tx[] = {
 	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
@@ -191,8 +192,8 @@ static void print_usage(const char *prog)
 		 "data:\n"
 		 "  -i --input          input data from a file (e.g. \"test.bin\")\n"
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
-		 "  -p                  Send data (e.g. \"1234\\xde\\xad\")\n"
-		 "  -S --size           transfer size\n"
+		 "  -p                  send data (e.g. \"1234\\xde\\xad\")\n"
+		 "  -S --size           transfer the given number of random bytes\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
 		 "  -b --bpw            bits per word\n"
@@ -262,6 +263,7 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'i':
 			input_file = optarg;
+			input_choices++;
 			break;
 		case 'o':
 			output_file = optarg;
@@ -304,6 +306,7 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'p':
 			input_tx = optarg;
+			input_choices++;
 			break;
 		case '2':
 			mode |= SPI_TX_DUAL;
@@ -316,6 +319,7 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'S':
 			transfer_size = atoi(optarg);
+			input_choices++;
 			break;
 		case 'I':
 			iterations = atoi(optarg);
@@ -446,8 +450,9 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (input_tx && input_file)
-		pabort("only one of -p and --input may be selected");
+	if (input_choices > 1)
+		pabort("at most one of -S (--size), -p, -i (--input) may be selected, "
+		       "and each may be specified only once");
 
 	fd = open(device, O_RDWR);
 	if (fd < 0)

-- 
2.56.0.rc0.108.gf0ef1b96a0

