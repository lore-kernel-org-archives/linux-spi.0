Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408F21CA03;
	Thu, 24 Sep 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252853; cv=pass; b=GDkArzEwkrqis9zuULZDnMxrJJ3YGBOFRvuyOK069YxNH6fdRIEPEW797RVDXl+K5nSLs/79ZZ/EyU9kIeB+9JKGpL6m3tzU7qqRfE5ZtHIgHx9EJeStqG292IFjkIgdv4Doz9TC2MKfRbmh/U00TUdZsNJFBHvsjHJZ0jwpE3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252853; c=relaxed/simple;
	bh=QIM3ATguBW1KxFnBRxcFy1QeaPHB0iP0ILr09Q6npOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIogX2vA/xRtKft+646FMK7zzQM0wX4eAu+vm4wMHVPCUS37xqn2MzeukTH/T6qzrb8iF19mZgZ5hQiFhow8gNxtexRvIyEKnx81uTiickXIHK1dwoKRHV+2N4MuEKcJGHfCaeAS4a3E1MIXJajFJ8iuC8dPLIE9gBhioyopOEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=cb2EERUy; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="cb2EERUy"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1BA0920211C;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERK0rnOr1yfnoRiGKDjw68xenkNj89jkhbImLRhjWzQ=;
	b=cb2EERUyZ4iVZEYjS4wrR2WVlNV5NqBE4swnqqrYmlxUPswsvht0bKyGIBPTa5JHMlSqVp
	jkCDeqLXljuCGkr9f39b1W9zt5vLl4vrgao2lDxf0nlUVHsYVuRqTuYKif2PDYq5J5Ljji
	GzglbKT3GkpImLLWZVTL/fBtXLTph3JH+aaO1b0viXFjrbIf5Swm8egoQtNCg+/bIRvzwE
	ARPaNqtQxAcOCXaXib8k+CZDS6U6E0C3h0aBGv7m8ThEdMjxFqMHJkdnK41ikfj+9gOY6r
	1Y7/AWxk0dlfpv6Oi2zbvMqLTV945CQqnAgVakbE9A/O6Kr5HXfCInA5L5Upmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERK0rnOr1yfnoRiGKDjw68xenkNj89jkhbImLRhjWzQ=;
	b=KgCaOwnCPE1KUDiZxiW23E3wgFUoHKlHHMJDn8Uc6T99JxAdMmiIBpst2qD/x5phL0d8Os
	PVDq578Ptp1KSXHGiuE5MQNNPGR5J8xkAItX3Sw0yMdT/FVdly/6c1DiUWs4DasC494zDa
	XH+0FbKOetGAUsUKPsdokrpcrs+0xiPI0QlAVGLC/JUyUk6i0ApRB45Y8GRduzw36St9ta
	vPn7+cTWsFApp9jA8tZl8VOXZweuPYUOpuwlu87ZUSoWHteUUcm5ESEh2r5pcT6ztLukIv
	2P9ZU4/ziCzCyR1ZYjADq59mQVu1pLuewCb6lK90r3ROy06Mf4C+UM9Mha97+Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=Uz2CzE3mO15zttiri3XPVQDZhakKKM7n3TZhK4GIUAPFOpSzAItftn2UZNTt5wWuaqd953
	mk69isN9bGB4bPUXwEHWsS8AThNAwWkBb/M88IeogYoIQMV35JhNKUVtqsxzIcdg827gem
	IMmSeyFhvPes/qyEvBEVB4fzg6GDL3RCDko4JSdt/d1bgP/ry5qyVf0cQHESQ9TJfVPWLh
	YryiDkeFy75ycnmLOrft2bdY0HbrAa0UaPp3QiOylI2E+stJ/l9KZPWhfdVXDKMvunebfJ
	N/nvihOuhjoFnaoyP6iN3q1pyEHzQupPmkESIvowiH1tu8x4QKLxxw8ljaclhQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id EBD0138038A;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:18 +0200
Subject: [PATCH v6 02/13] spi: spidev_test: clarify usage for --size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-2-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=QIM3ATguBW1KxFnBRxcFy1QeaPHB0iP0ILr09Q6npOc=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKq5dN3HRygkK+jnc235K333w2rFqVuyaXTwe/Fu/u
 J/aG9Xf31HKwiDGxSArpsgSqyanIGTsf92s0i4WZg4rE8gQBi5OAZgI93RGhm6JgvBXEz3Yvv+e
 nsA+VcKhfPfePq6bnzsjUvcVLGN4lMfwV1zdZFVQwlXdz+/eVP5aoS2uJW0a3nFo8rPwa5mfBRP
 iuAE=
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

