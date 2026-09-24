Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544447F3DF;
	Thu, 24 Sep 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252857; cv=pass; b=JVlstwBGmfylfWJ9ejDAhkWLHk8LZgwWAcOxW/Dm2jQghqXE2QuFRrLiKVQAe+2N5Z8Y8rUaKJLqPqvwLMnWJtN2k6h0niGsTAD30ZvNhuqKx1Nl7D6rNmJMib89COPKMtjex+QahBQJ4LDwvwfHXq1yLbak/bGq7m7zxp7f8Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252857; c=relaxed/simple;
	bh=u6Hv/WGyYbK2g045yLqZ+C3SBhy3UDc+5XLeVLIP9+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nf3YZdZSop4ji8H7lSGiA7jdP5x7ONN1ngtJjEF1l/genDXFme8YFzjDqF+QF31ECKUgc0XkRFLZy7DKsbwBd6o7hOLab54NNatLOwGsUjWbRDfBeV2+5z22vsvQAruletTo4rGmSZcOQNMD7bA3f2ktjPxUR1cVQ8o7mijfU/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=b5aPFk0p; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="b5aPFk0p"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3D8D120216B;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsUyzPo6/gFs/KIk27qpKHtGGjxctXlIPr2rX3gJxJ8=;
	b=b5aPFk0pphTsAm1A/+0KOmPckNb01GI4P+e6Y6ADPG7KZYcaMGNTQ6JMDCjt0OK4q7IWLp
	KvSzgmKeIlTDKoTudqX4D/PuiqYAsvIjc2ZkdgcVuQQfbxsGtzaMotjYchXZmngG2vmrpE
	/XJf7Wesha0/0ZhUVsB6Er5otvHtAS+D43pH4uo0HXUf8hqgPfKQfz9Oj8l31lef57jkAy
	39xKMKUiE/dsrCBHL4KC9H+bUsG7XSIGYIvfj2nBWQY2auJ8gRTWKdOR06SowqM8UVucfB
	65wsPopkl1M58l3bpLFUCOckiS0K09+v0ijyGkVf2Uu/IgERkxO1yPC9yioSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsUyzPo6/gFs/KIk27qpKHtGGjxctXlIPr2rX3gJxJ8=;
	b=bbTv/x1v8isUBPbHNt0KemRUxom4QLt5wbar0/TAcc4edYiCJvQBhOLQNlPdQnepcAVaES
	tACGq8CQ4OaSf9V4AaWOOXlPOKmEN/vL97ycMqtGmTiOvuzBhTGGFpnk8iv/Oq0xP6tCAh
	O1HsWGHJq7MEVP6ZtSWJ2EqY1lYHQVz5HgZpIkSWa6OO9t5ueU0o2RkKpNOelbhxzNeflw
	rGC5/kK/iaZUEjO2oJYz75k35bdiQCL2k/sU2e7cuAj7xpaDkFxDNfAq8zbyd1PmY4TQlK
	EUtEsb7JaGO3XRGI3eDsjyKLctYIkje7agsiSVYj1TyFchuTWG7NTfFNDs3nVA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=YJmt8IMVFn0EVotwVzYDV0nJLJLd/AemM3z4QB3TinX/BCN7v1/6Xo+JfT4LuQ47MMvAeG
	doyJLbxAlZ1W68uJtpy7l55B/bwZoIViY1Z+p4T9VCcm+R5NVbdUkrFh0oO9oES1+1SGqQ
	hiMVFZUATnzdKwlaKAOkHn1RyNU3wl54ZyhWHbE4Im4hiL1gX4CtuGZNJ+fUwluAmsQbQK
	JZpLzgxSfk/Sz07i651wiSxxXrsw3nE7EvtXCgdq/iJiojJQtQNOxuoLFBFJhR2AlITam+
	o/6PZOlQNVFEW3D8Deg6hgcdXCHxE/ZnhQW9Xp+9eSRgn2cECbg5Q3qJOrIaHQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id EE22E380E3F;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:26 +0200
Subject: [PATCH v6 10/13] spi: spidev_test: send predictable data
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-10-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4587; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=u6Hv/WGyYbK2g045yLqZ+C3SBhy3UDc+5XLeVLIP9+Y=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKq7f0tr48OALVWVvW0PlFZvYv6m5yTF5f33E+Ppp9
 n6hhfM5OkpZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABMxCWb4n8K9/KfW3HU6n57k
 F+of7fto6MId3T5ddKZhIfOhmfEsuQz/NO0D1Q7ZaanObbC++rmCIcZ+GvuEO0bhr5olt+z8NsG
 IBwA=
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
index 24fc2ee4c927..0917fd97d448 100644
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

