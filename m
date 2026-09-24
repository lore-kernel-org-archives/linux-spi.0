Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684547F777;
	Thu, 24 Sep 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252857; cv=pass; b=RgEXmBHcPD3Mnrq1ORL5xHHjebG88Jxxq/wufU2NjYO5dbO2t/wzUk64sPxdN1ULHCM0nd+gUXazgz63S8Sbic3HxdRym+agw5HNkrYwWto+3lKZBBSHvUaygvW3JcdSrGeE6kiEchjzhthtyKNvwAp5cx20ZStYd1bP4ZUFZU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252857; c=relaxed/simple;
	bh=caq/vwJv4XWW5KBfxcBkwXDgXKMSpjsyvcPbH9Ya5vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPhJR63/Yj6r1GcCjKegb05TcozMzPwunoCyOPcRLEmnZXPKZ82xAr18kqYdXgHP21MG1kXfLXd9USp40ucUINu6UxQ3BsLopdJeIqJdL760opG6aj+1Q148UC/mRfxcqT2ZqNErFZrekEjexwEddQvstuol/UHN4UbFHVTqoF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=KdkKTCqi; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="KdkKTCqi"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4034E2021BD;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQfHewfuWJ1fEbjxkyK66/QJga0X256UMAxRWuVoY8E=;
	b=KdkKTCqiM1iEpiGp7OeDyq3+2RI2FCsVh4uxADKSbpTNvmC8C9mrNvJI27PRaiIbcmvP8c
	1YZcs81qVqxed9qrMKiCANt4B9+ZvTvweerC3Jt7PkONF9+Vd06RjxvkB0BMYlIyA98Ijj
	LmPbUpt9SglwhXSzm1SWLMtoQxieDa4azJDRGOr45vFfLDXvHpQV8s01v5MEW/hd96wLDf
	jR7yv5NJjKwKGTUfHg/wk7KasYO2eufrzc4OEgNqq91730NM1mZQIJ63UXvvr0+TpN0D9Y
	K2i9CFH3K8ohR4w2AW58WUExqWpve9vnVxk3p31xhCM7NGp4f189rnhGefQong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQfHewfuWJ1fEbjxkyK66/QJga0X256UMAxRWuVoY8E=;
	b=Lm7vq8WwZgYXaTDoRdcMuTGzUxLWpfbe4cWK/YCAVYP1Jaspk7p5yItEMJgXTC4yQHcYkQ
	h6O6b44iAKuEhAItKC8MVp1qIgtfeeCxjVVGyQNcBM9GZGB6qHkyx69tOO20Sq81CtNEET
	IZgLJ8z3UuHwHCOpTVtfKvy4UFP4AOd/K5Se3ZfVdLEP0QzAxMzg0QPRD38jSXLo1yyIiv
	9hQuBxus1cbWBRcufLhR3iQv381S/gr42gW5dqbTEmI8R2gIkexQTUvuWamDEraanLEsAh
	bOtz3YzxqzEPyalAIZLO7NnMN3sJ8rz7xAXP39o7rxsy1yhu8TzGQRYrl13dGQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=MZFrGcYxLVZxTk5+bJt4ZcGaezw9nqL5JgildiEbcxSOvGwWhqJiw4lYsco8CvBJy22ZnK
	LWiPQPG2t/5ZbgW7pn4qjFanr7cNH3f+s8kE8aAvxulVM00/hIOqSGCNM5xQWDEZ+aTlkQ
	2FxIjmUY7fls68uC/dcobLm+y7MUUEOVKukozGOx5St3eTDRp39OgoVKPFt475pIFhZL3m
	OfI4YArzN5+AYz5mSpfYOXBjD+qbFhmCaiTPyba8AC2/5YzgdGshT1sFPmXg5DeXPCfSQk
	rC9RzBHEP7yedp/ZWpYMJRmIbeDwghGuLWWOQZTyPd8lxCV8uEvysLxw+rK5Sg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id EDD7A380CDF;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:25 +0200
Subject: [PATCH v6 09/13] spi: spidev_test: don't send 0x0 or 0xff
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-9-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=+WQwD/onrQAguPuQyicIeFjFHIPjtNRFpJhPzEwWG+o=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKq5nGNHuG/BeXuzugqBjPybO4AwObhCXrQ2sVtn2w
 uKZUoteRykLgxgXg6yYIkusmpyCkLH/dbNKu1iYOaxMIEMYuDgFYCLhEgz//U+I9fQ93bBDsnvW
 hptz3z8ybTdcalKgy/TUVO53mU/+e0aGjesy5mu7K1as71r1PmTX9rdCeV0NW5d7ZORKtUhGt9/
 kBQA=
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
index c58cccdf806d..24fc2ee4c927 100644
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

