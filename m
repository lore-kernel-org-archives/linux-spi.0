Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77D57983A;
	Wed, 23 Sep 2026 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194228; cv=pass; b=Dp7yPWDKQP80ogIOGl8Y7wBoDNqU7GUxprr0Kev2lVJfbRR6Tz+k79y+3M+e4FSnRh4sKSJz+ZVmASQncdJN/M8sowuSG42yD/SUCM4YUPQWVsCpmZE1DyV6MKam+BJUCHQbDCPvi5MAUPu6N9c0DC8S+5aiHPhRl3609hk97dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194228; c=relaxed/simple;
	bh=yfJTnfJdt9/eD9l64hgWqkzh//TY8CyRwV/BFj8w+Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IATX+5U2v28vq3lp8eMgzqqE0HMNay2ZmVqkwP+wo5O+H9/12ZCODDW55E9Ck5X4Pe9MxDBwp2DPXy21N5poLlukQEWNq5/3BTl/9lmIVB4N8txKV3mMS/7skeIinCITCy2vYZ2t1d4qSW0Cf0PlFugt533OBSUe1Zyy7McKb+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DMNxmeoE; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DMNxmeoE"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D4D09202047;
	Wed, 23 Sep 2026 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IElSWLgwB1bLMmOeaFUbLyZiYfpxZNidYeKOFatnshM=;
	b=DMNxmeoETERVahoSO6PGfxX7qJT8bMVzr+Lar/kq3ZIwpMNozhTjpJneFlaLvx45/TcXQO
	R8Knnc2WQUb1u3SDc5s0sIDIPfwab12H8A7vo+tNqV3FoiAiEqzMWALWa5MTGRLrg1iOhv
	c85mkNrpCj+VYzVBoF2L5P3lUcJFzieDxztwXWImDatocDWfAPTT15GGeg8vCvaMBMvMpm
	bGTRv+GvhGr+JLd4ug9Kq4YerZi67B/MFSxN9LEEohzpu1qShHrDNrt92FSVRuJEzn/Z9B
	hmcKEo/ZbLErwkd/4EXm1H/Zf1CFRfafL637F3Rrm7PHVIjgOtG98KcGdmt3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IElSWLgwB1bLMmOeaFUbLyZiYfpxZNidYeKOFatnshM=;
	b=OzO6RHmXQfBt9BIt2e8s6OjLqgah2Ft1C28HhqvOk3xoRPb4i4mrtD0DxbMSrzobJa3fGE
	jHBs2jFhtr+u/CAXBzsSUWOwAqdp7AQ/tvm5fVxe3y4UCzKCsCq8iE0bbmuKUk5HdCb4Ms
	xeAbFrPMNfrQUbGqSco/p8NLG8VhYTLq3edY1qhQZk8dvF5T0DLmsTzncduCHY/XuJAw55
	2jU9VBsJeTjOfIMoAxsMT0JeNxi+HxIN1RwaJz5r3Q+BjXUPcJ1eDXUDukjX99ApHzsyWd
	m6vz64rrUpb85ppnegKE74tQ9/PO7GItXvhn16LZvnYZ+HjwGgTrtK81ZPMRig==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194207; a=rsa-sha256;
	cv=none;
	b=BA8ij5CNTbquXPikNi1nPU2gX0T/auY9kjkIVGy1xfNPCOUP/9YmuCfGYtUTlmelI03WO9
	dsICdXQawPuQw0czYwgZOvt0AOcbwwynBD80kQKt1bfNKsaurWApbNr5wTE3+XP+Sr3SV+
	2fWrdxMrT8InPD+qQVCMmSpWmxxPewFKsexdSKzNaCoXWlWaSUeEJkJHb8ZbVs8cxak5w4
	X8Ri1VFiYy4EMmDGATJMdPFEwl1Pf8sI9+pqEfERPe5nLJPapUkvyyOGk3bwNAAgKuEXAO
	SmFk0/B1ygezDB0v17FjhO39X9bEryRKBbnH4DVDiF+UbJm5J39fYXceaEbGYA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-2Q;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:10:04 +0200
Subject: [PATCH v5 09/13] spi: spidev_test: don't send 0x0 or 0xff
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-9-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3448; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=KiwJkWhWTNc+u3nhRMWq6chUQ3ICWmLDLPEGoxYFQmo=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiSzr2zW1bu8kgGr2i2iTt5g8Oi85/Nr3oRVT+81Z
 X9aKpvI2lHKwiDGxSArpsgSqyanIGTsf92s0i4WZg4rE8gQBi5OAZiInyojw/WUh5PjX099v6vm
 +G7J3KeL1faKX3We6LPxvmp6q/jTlZyMDItXqhyLuH8z0889VPiWYXl7uMkeri1T1n1daSvlfdZ
 qIRsA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Particularly when using compare mode, if the controller fails to
transfer any data, asserting on a read of 0x00 or 0xff may lead a false
negative test, indicating a byte was successfully transferred when the
values simply originate from the pull-up or pull-down of RX.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 770f40097535..e7ee7d5a701e 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -45,6 +45,7 @@ static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 static int compare;
+static int nonzero;
 static int do_tx = 1, do_rx = 1;
 static int random_input;
 static int input_choices;
@@ -187,7 +188,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvw]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbcdiloprstvwz]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -211,6 +212,7 @@ static void print_usage(const char *prog)
 		 "  -i --input          input data from a file (e.g. \"test.bin\")\n"
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
 		 "  -p                  send data (e.g. \"1234\\xde\\xad\")\n"
+		 "  -z --nonzero        don't send 0x00 or 0xff bytes\n"
 		 "  -S --size           transfer the given number of random bytes\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
@@ -248,6 +250,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "input",         1, 0, 'i' },
 			{ "output",        1, 0, 'o' },
 			{ "size",          1, 0, 'S' },
+			{ "nonzero",       0, 0, 'z' },
 			{ "iter",          1, 0, 'I' },
 			{ "bpw",           1, 0, 'b' },
 			{ "lsb",           0, 0, 'L' },
@@ -260,7 +263,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lctrHOLC3ZFMNR248p:vS:zI:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -352,6 +355,9 @@ static void parse_opts(int argc, char *argv[])
 			random_input = 1;
 			input_choices++;
 			break;
+		case 'z':
+			nonzero = 1;
+			break;
 		case 'I':
 			iterations = atoi(optarg);
 			break;
@@ -454,8 +460,11 @@ static void transfer_buf(int fd, int len)
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
@@ -491,6 +500,9 @@ int main(int argc, char *argv[])
 	if (iterations && !transfer_size)
 		pabort("-I (--iter) is only implemented for -S (--size)");
 
+	if (nonzero && !transfer_size)
+		pabort("-z (--nonzero) is only implemented for -S (--size)");
+
 	if (compare && (!do_tx || !do_rx))
 		pabort("-c (--compare) conflicts with -t (--no-tx) or -r (--no-rx)");
 

-- 
2.56.0.rc0.108.gf0ef1b96a0

