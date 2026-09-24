Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F944908CA;
	Thu, 24 Sep 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257461; cv=pass; b=mdHD7WdBPuyzQ7tUJBJb4XZE0ajwQB3mCbKetyblixwRK3INAXZ6fF8eBSSsMFPclN0dU+aN/aU3yPX5dOxi3VuHLFNHetkp9QgUIN5SG58zfOXMChZGOvE6t9PBHE3lsYtQHormMueYuBX+FTu8mqAjzonxlFifDiIsdVwZ7wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257461; c=relaxed/simple;
	bh=h/QxEQFU7oNx+a9fYXwk7xYQKYAfUUSa0P0j48QMuLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3ri8w1YXXwkIrOTr3kLdnFb0uO1swH/762ads/QGz72W1ZdjX97dbWUf4w03uBjxHsHQWvdSdy1lhdoAjsEB1fgsVsSpwHt1iqF+r1rCPlooVNBN9zMWoyX2t5+4SV3U/y5C2Zq/Uvq1Pk3nxnjRbxfpsxnTFiB0fx8ABvVfJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=D8tm+GKH; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="D8tm+GKH"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D80032021BD;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVGfzABT/SyB7pATNgWgP8psyd4ik19RSTTi9sUTYjw=;
	b=D8tm+GKH57RUR2VMl6Tj10tmmJd5DgtmFc5nVj0ri+yshTEUGOdNSGEEZoWHGO4cYO3weW
	sMUY5laY86FpgLHEAYMFs9F+i9J+xjUDVnxY8sul0GzQ465B1gaB+RMAvm+Z9sSw10y+lU
	OEwEJa9NMTWzjmx0gPFRSGJT+W3TMrWoZAY4IlzhncdOB6bz0ekW1CS2NV2gHa0AbpFnHt
	CKjxvybo6+SWQ1rp/Zc4uJI64lYsN6Y24U8mEEd89lNMpozm/XPYRLRJkZ1VRlq4dNlHDj
	e/AlvT11SyWXf+qve++ZhiW7mwZhvSiMZ6r15EDNesGceDKk+2afxop57lMBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVGfzABT/SyB7pATNgWgP8psyd4ik19RSTTi9sUTYjw=;
	b=L5iZeb1K314SejhMiAE2iW2oh73UFGU7CHhuRSxkbbuyBdP7/8M5wVhVQpExRcsiuUT1it
	WYup7+unfAFQ0zbB0ABqH3mueGmScvLTXOnZwpu0kZhmILLYYM8dCE0HqKIMneUQYjiWI5
	xuWLRyjBuhudbyeuyWXNe42Ar5SVuQHYEtfD95WX+Y20jaL3aN68AWFCBdg80+Hy3hEGDf
	AzoXdphnRo5zyxsjYCa5y4jW/mi44ucBHtg/eZJrVPQiDUA2DPUgoYgT7cV8Stb9xDGuDu
	z6a2U4jZY2UgaAV1Q4E7TsHkgztl7qlHlNuz/x15pHhrgNQYGXa2R8VfwTspbw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=KHqWHeVtS7AJfIpIwG0vEJNRD7tGLusKKOaWdC2qn0adObE762YQYkIMLsrPLJNRqihjRG
	MCsN0Z8Qt/db9KBy5mKNdes2tGL0eJ3iYYrH6dbEBgjNSn5HsK7d6xudLkR1iQfBTSviV7
	Moiecl7SJIHAQudrXxJ0RG7i22tsxk9Ol3+mk3YzXp513OjuqSwWU4IfC9tgd5EUI6jzjn
	0RBcHKJ/Hio1L71gj1ZTLmyknTzmbIWjCeP1Mh7uPZuwSIt+/ew0bpEkfrOfUCMEdpGCsG
	eionJPptB85+v6vpdUtrkySiwFrt3Qreb77BRuOTjATt2ZrGXVGo+tFd2ihQmg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 95FDB38920B;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:43:59 +0200
Subject: [PATCH v7 09/13] spi: spidev_test: don't send 0x0 or 0xff
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-9-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=MY366KmR7OYF67j25VUTUgwc9lLxg0kfhZtgtWdWo3M=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqqk6VU3xN/tMiQ3hBi2TrD9NCN+0dONz55zImot3p
 K1KbNjUO0pZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABMR62T4ZzZNPb3Q9Oa+/GfW
 H5p7jK9ECX1pFs08+67lCdOu3EWzUxgZpv78yLqq/KtRjIt/cHpiUdP9Qv3Sxs06txQYtisGXU1
 iAgA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Particularly when using compare mode, if the controller fails to
transfer any data, asserting on a read of 0x00 or 0xff may lead to a
false negative test, indicating a byte was successfully transferred when
the values simply originate from the pull-up or pull-down of RX.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index b02a6384d27b..7ca427c27f07 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -45,6 +45,7 @@ static int transfer_size = -1;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
+static int nonzero;
 static int do_tx = 1, do_rx = 1;
 static int random_input;
 static int input_choices;
@@ -188,7 +189,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -212,6 +213,7 @@ static void print_usage(const char *prog)
 		 "  -i --input          input data from a file (e.g. \"test.bin\")\n"
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
 		 "  -p                  send data (e.g. \"1234\\xde\\xad\")\n"
+		 "  -z --nonzero        don't send 0x00 or 0xff bytes\n"
 		 "  -S --size           transfer the given number of random bytes\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
@@ -249,6 +251,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "input",         1, 0, 'i' },
 			{ "output",        1, 0, 'o' },
 			{ "size",          1, 0, 'S' },
+			{ "nonzero",       0, 0, 'z' },
 			{ "iter",          1, 0, 'I' },
 			{ "bpw",           1, 0, 'b' },
 			{ "lsb",           0, 0, 'L' },
@@ -261,7 +264,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -353,6 +356,9 @@ static void parse_opts(int argc, char *argv[])
 			random_input = 1;
 			input_choices++;
 			break;
+		case 'z':
+			nonzero = 1;
+			break;
 		case 'I':
 			iterations = atoi(optarg);
 			break;
@@ -455,8 +461,11 @@ static void transfer_buf(int fd, int len)
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
@@ -493,6 +502,9 @@ int main(int argc, char *argv[])
 	if (iterations && transfer_size < 0)
 		pabort("-I (--iter) is only implemented for -S (--size)");
 
+	if (nonzero && transfer_size < 0)
+		pabort("-z (--nonzero) is only implemented for -S (--size)");
+
 	if (compare && (!do_tx || !do_rx))
 		pabort("-c (--compare) conflicts with -t (--no-tx) or -r (--no-rx)");
 

-- 
2.56.0.rc0.108.gf0ef1b96a0

