Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444548820D;
	Thu, 24 Sep 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257459; cv=pass; b=EaQGv8LcYAZOKjqWoebnjoYlRBgsjsJKHXWBw37C4kt9z7GUPsxZ2p2mcSZtvLlVrUc5J30tKpTMaIoQOjUtBLoWZDXYxAbPhHPp4dIgHF7pRlm5ZvFdwsEoEYF2dSEnZ8eA6oW7IPfQ6qyWMqt9QhjxbLmzfbmDtMOyjpf1Koc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257459; c=relaxed/simple;
	bh=GE2IZwoNuKbcimoAQbnNFI8jCDtlCm5Q7YBRLHm4kwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zqh4rxnA+pxSMI5W/YTM/9YQ1o5Lbg3utYmLW6jhNac35H/aF5fViyZ/gIcf+zOX5L6l2dNfMfx/xHQKFQ+7nUQpzoTpRFIOvcTSEUMEsmTv8vgh3MVahPcphgb6kWMNXGgzY55wkLxscFEd2y2eUsR3umrQ63xIOK+dSjDlQ0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gZLa3nU6; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gZLa3nU6"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D09B8202148;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UrzVfIS+tiJtdHJqi30Cc56dsqG2vVFZJsao508Mak=;
	b=gZLa3nU6CS4Sz7nDg1PnbzymZDd2OB/G/5ShEyTVbTcawtCW3PgUTSj8mLPbrTrw6uP6E/
	deJmq3vEz4exbBJNlOOP6waA6tkHQxKp0Ek+EVpR3kGihM4r2AEhS3WUcOsO5rM63Sx93G
	BFUyH2hI9Dvz+AS1+7IwQ4CwXNuX2lhlW7ndcZz9nUn0yO242xVY05xGduIQm/uP8kW+4S
	6DdmiMUCj4xaVXaSyxhFA3jg5TRENXOp6adTP8uRq1504QSbz9rKnrpG11RN8XsXba649G
	wtMqJaEn8iJp1lBydXCycdFE8Ix8myYr+hnIHpGa6xaHLg8MqHUfje8qEWk2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UrzVfIS+tiJtdHJqi30Cc56dsqG2vVFZJsao508Mak=;
	b=dH0GDdsMivkJZJgw10PJ3RVBNkSe5W/m4BNUsZQ9sBwaWA+mhMpin0Jkn4y5tZG1anIBxn
	4VwjEMbi3rGPV2v2h1a/LhFREKxfErM5K/UlP6v9q6s72iM7coLVPYqCs+DpdRMiks1T8+
	IPuPAGsGVH0U+MXJODYhIoidMmh0sIvNpG7qwQJevwcoxvMPNP2UOwyiGZvnGcSJgCBb30
	rH0f612W/JkOKlSDOkDsiUSxX5nlypcxAfP0WgIMSJaYc6FauFSus+QqoV5LsD9ksU/fgH
	xj/xxiYbKWbuZ5bxKAb5bLf71f7+zjewcSVMPDcWk3q/h2Gr2A+TyhZJ7l5T1g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=FPMtK67FSHIa/iqTYHJi/NbXU9DyJh1XkSKP3WAs+KmULnVA83sRHDF8MRWESs9ZynGsGD
	LB9dU9FarYuPLiZ9oUhTgBQYvrBicnyIcWHeJ36gzz49Pv310tJEtCkirblNRPL7jocm+f
	HkqQEEsCPxk++kF5yMGFtAdvDKe4gEvFbrIIOihtdpoaG4SeOv2xsJHmVou5DBWcp1VEEa
	SWPB6pkzg4TuglTSkC6cDLbxDfmOANeQj3XHmt+k6droIjpckHVS34wppCaqkQIMalUI7c
	sydOWZMXDh/cJ878HYGo1BvnlU233w4nSLLHp3HweNw4C2qO3a/I0q8XTzzeIA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 95836389203;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:43:57 +0200
Subject: [PATCH v7 07/13] spi: spidev_test: add compare mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-7-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=iiVt8FFbdDNYXbVlEGd24i9U1o2f3a8oqYSP+ebf+Zc=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqqniu3UHz5pZmhYlH+L/qTz1KWPYXxMjWhhxuf7yB
 M274t4mHaUsDGJcDLJiiiyxanIKQsb+180q7WJh5rAygQxh4OIUgIkI1TD894hXrHyr6znPNnfG
 t0WOuXJdTL8LLprEa0nuOG/ofOrWJYbf7NubNwYuzZkpvvk6c4/zr2rVrpvPJU9c/vXN6fGjSs3
 NbAA=
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

