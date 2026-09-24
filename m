Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1748F832;
	Thu, 24 Sep 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257460; cv=pass; b=ZjwrTy5QMSFMzWBa7zSUJcjtrmicJ98SCfR8+XoeVL1AspDQ/BpGtNUa5+9LjKA/UEJhsFXh8r3zO7GKEnxYdopxC1ZNbsgUbYPgfg66JNEOLH9yH24ddYoN3QlC7KxWLnKIkMLxTEDHuLX9LViOWjfokz3JeQxTXxJOYdjS1cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257460; c=relaxed/simple;
	bh=fEbdjsyxyH4HU41g60qM0jTAeNkFQMW0hNkM2uRdOZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QW3/1L81W8IRFGrSYVdiUCsncZ8Kf4KuIFBfX4bovyW8tk0kwcPtEbuLV5kTDSpXrv0sYg7MjE3jTYu9e2RAvdjl83at4Fw2jXifGRW7x6lTDPehLDwu0gXPN7BLAV1jIlGrEd3aWXXZ03p7jynIL2M/k6MwjONFl2Hh2324XHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VVaUNxm0; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VVaUNxm0"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D7A6E20216B;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uqou9h0ayeeThfllId6Q8YVk8ffh6BKxj6G+xhZmANc=;
	b=VVaUNxm08vfyzBW5t5WBtsKtNEyVdawZikARvKUI05fnhMXAoG8W9u59SshrXhR67ydGB8
	hNlddcPrBBYKxS0QQMqJYFiC7+ydrQO9deEs5uA2JmlEFQ/mNIwByCcdz7sDlckcvdfXVi
	SokXVv5GpM/sqE3dGtoRtzBAmDyvyTCwsFWiuYiOCWIhmgij1tTbB1DVur/715zzSr2Avx
	xHvrIODbEsfy9SC91vHHrIawIEfrptPps16iT9+OgVLNtvVtoes/rgOmVQoBfEVku4MGGj
	yZCXvVfJyBdHTt/WWpuBWZQnQ5fW1r0CW5o3hysRu9FNcWZhW77aZcNKh5NOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uqou9h0ayeeThfllId6Q8YVk8ffh6BKxj6G+xhZmANc=;
	b=BkZXBcD/pCiuWAVLL5FYQ1EG+A2cyGoej8+QLXdqqCK1SaNa9QHovaUbz5y54U3f3niK8b
	pK/1rbTxRgthGtnXoiTcB+cYZzOaqSvBK0EYVRpZqQVvjMJ+HK9GI7aIe5k8yDDMucpVO6
	Xp6UkZKtHV3EdY7HGlQQOtONcngvjV6NwszmCmAbuHWW0NDd6/+qO+209GuHo7ky0OjbdY
	ciARijNuSNPuMGw01YZCBfxOChOiHDc/0OumP4ZAtD+SSaGie57wVETOoYeItUUH/psqnf
	8fDGt7Nsz2UF0ZaF/WOCN4OZ0E38m6+rLX4vzRw0aNi8dQo7C6YcOC4qItuolw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=St5ZC9jbFrArR26v9n/ABXOtgUYZZ46wDucP7lMeGeXgwWQjw3ayXhRTsVmHzUSJNO6IUK
	kNVO6ybZIDnypoiyGYKMsT1bgEgfE5COEjXW8yWnTAv2FtLpISfslEwu+wcqDg/RfWYsDb
	PQDy32jD96aD/DeGtaU1zj8imCSFgX/vgidPG2iuiMs8HuC7b/x5dL9rdKRjhCd4IyB4/M
	5tIYpqTXgY3CCW4Oswbsx2lSjY6sY6aKxdAl3se5kFghRC/plSV3+81Tp+vjCFmXuzEWDz
	Ae3/DXv6oN6HaJ9Aru7aQrI2qm19fnerogjm96a1Y1V6bvjnfKVxrMrfWi/a8g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 9659E38920F;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:44:00 +0200
Subject: [PATCH v7 10/13] spi: spidev_test: send predictable data
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-10-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4587; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=fEbdjsyxyH4HU41g60qM0jTAeNkFQMW0hNkM2uRdOZA=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqqnKzeG23frK1hvhsx/L5LIwRD79LXm6Uks4pHS9Y
 13xp+BPHaUsDGJcDLJiiiyxanIKQsb+180q7WJh5rAygQxh4OIUgIl4mjMyLPle5qEmIbxxuoT7
 yu+q+zbdTz75N2nNn+1R7wwEJzl7H2Bk2PT68bm9dt3sqbe4/xaonp/w+L123YRT07NaEudN5/z
 iywYA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

Introduce a flag to test on a predictable byte sequence instead of
random bytes. This is useful when comparing multiple runs with the same
option set e.g. with an oscilloscope.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 7ca427c27f07..a58680b6288a 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -48,6 +48,7 @@ static int compare;
 static int nonzero;
 static int do_tx = 1, do_rx = 1;
 static int random_input;
+static int predictable;
 static int input_choices;
 
 static uint8_t default_tx[] = {
@@ -189,7 +190,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvwz]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNOPRSZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -214,6 +215,7 @@ static void print_usage(const char *prog)
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
 		 "  -p                  send data (e.g. \"1234\\xde\\xad\")\n"
 		 "  -z --nonzero        don't send 0x00 or 0xff bytes\n"
+		 "  -P --predictable    transfer the given number of sequential bytes\n"
 		 "  -S --size           transfer the given number of random bytes\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
@@ -259,12 +261,13 @@ static void parse_opts(int argc, char *argv[])
 			{ "no-cs",         0, 0, 'N' },
 			{ "ready",         0, 0, 'R' },
 			{ "mosi-idle-low", 0, 0, 'M' },
+			{ "predictable",   1, 0, 'P' },
 			{ "verbose",       0, 0, 'v' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:zI:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:P:vS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -342,6 +345,11 @@ static void parse_opts(int argc, char *argv[])
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
@@ -462,9 +470,17 @@ static void transfer_buf(int fd, int len)
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
 
@@ -493,17 +509,17 @@ int main(int argc, char *argv[])
 	parse_opts(argc, argv);
 
 	if (input_choices > 1)
-		pabort("at most one of -S (--size), -p, -i (--input) may be selected, "
+		pabort("at most one of -S (--size), -p, -i (--input), -P (--predictable) may be selected, "
 		       "and each may be specified only once");
 
-	if (random_input && transfer_size < 0)
-		pabort("a size argument is mandatory for -S (--size)");
+	if ((random_input || predictable) && transfer_size < 0)
+		pabort("a size argument is mandatory for -S (--size) and -P (--predictable)");
 
 	if (iterations && transfer_size < 0)
-		pabort("-I (--iter) is only implemented for -S (--size)");
+		pabort("-I (--iter) is only implemented for -S (--size) and -P (--predictable)");
 
 	if (nonzero && transfer_size < 0)
-		pabort("-z (--nonzero) is only implemented for -S (--size)");
+		pabort("-z (--nonzero) is only implemented for -S (--size) and -P (--predictable)");
 
 	if (compare && (!do_tx || !do_rx))
 		pabort("-c (--compare) conflicts with -t (--no-tx) or -r (--no-rx)");
@@ -512,7 +528,7 @@ int main(int argc, char *argv[])
 		pabort("-r (--no-rx) conflicts with -o (--output)");
 
 	if (!do_tx && transfer_size < 0)
-		pabort("-t (--no-tx) is only implemented for -S (--size)");
+		pabort("-t (--no-tx) is only implemented for -S (--size) and -P (--predictable)");
 
 	if (compare && mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
 		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");

-- 
2.56.0.rc0.108.gf0ef1b96a0

