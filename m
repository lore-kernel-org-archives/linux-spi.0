Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612547F765;
	Thu, 24 Sep 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252857; cv=pass; b=OVzoiVZ7BpMkfe+gCoEhVVK7R3188dUMY2F/FXSWKdbXC9F1GkRv+TK0YKWGlIJvbrkyT5CJ9RUSZNB8iEWbp8x5vfIcqmv2SlDe6uMom45RLJgyDwOh8Qnct0iuQFw3angpx2to2pGz5Y4PJa7x51ZKHmJ8mXmeceNYboAggRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252857; c=relaxed/simple;
	bh=l3iFDMYh1QfxiCzvqTnmgRwu85cRujE2CN2zxe3Ghog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9uzS4V0e8m/shECvylfr38eE4qvxi5SPEJxZWgCkW4v25kyeHnwxTpNjBI0fG4x2VmOp38Ll3BxhKqa09es+ScJ9vmCW20KEKvf0whBKwsduVp/yfTL2mDIabryWTdx6oRL4epZi4e+ElcjuZ7RQhEm+ar2GhdIzD2UaV7cZ9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=I/3SalCE; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="I/3SalCE"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 27AEE202136;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOViLPgS0+p7O3SXL0hpW6f81qAbMrdTlv722/27a9U=;
	b=I/3SalCEcwxXo6Zb4IdOEZ6LY17+YM9ct8jheL5OVLnXM1YBMKSXb52r/ySbiVFkJk80hA
	2O7Czw+TP77zb6/UHeyCu05Hd/y2BKJt/TS45KgV12xVpHhU6c1RESB/nx7lylgKxKOhNk
	DFp+F+5IEr4gqxSF/FDx/Z27wAo6IOIvDtZhnkzcAIA/ORbEKbtOm8hs+Jf9ByupMlagr2
	qE/SZ7tquge/ClCutvdQ9AnHxLygxs5tisaX/C3tpkSxfDkRTlePuvFDwgKcDO/Tc1TPn8
	9gpBnO6JS6sC3FQtx8L0nfOraWAnjp2FRVEVBqzRoR2880xvxpQGITou1cGOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOViLPgS0+p7O3SXL0hpW6f81qAbMrdTlv722/27a9U=;
	b=VXKFzcTw0w8yS97pECFF5xJweu54sYYUioo4f6sTrPoew4/l3CkGjxUOlFZMoYtCEJg/43
	UgGXTTD4zic1CSfWR6eatCLKX2Np5I5oQstMact1ndE03TTvR6OEUIMgaKlOHP07VME4UC
	ncmkMk5wDv0Fa/xftqdBYEXHbtS4AYinqMFUmJ7/+iRI5ATDxS1ZPbeSC8KSTXxTHK8Bw6
	rVYCmuoa6iwj008+YgbecarXzkLkYMmI7+kg1LBWP04CA5FOaTrTQaKQyjfdqhG2V+LgdJ
	kBeEoR5dKeORtWuBBH8MSzCK9wr0r83F5A8tG5VKTeMZmPraoazL0Kp5y3J1qA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=Gm5cN/HCnjs9fxe3BzvbRJI+/8eaon+IG9egAjG2p02S74b5/ZTkxl9NYTBIIBi7aEbVeB
	aK14QfnxP9mbDM2i9nAsp8fYufQlDPFu6uo6wUPZcb8O81NIcB4+Vpz4OaSu4dGJLaYcV5
	J+K0mW5fAUlfCuwdPKuJGBnnI2oe7dihGRuftqfcP203ktCh2HKmhtClKs48AnTXp7PpC+
	6b7mNPYtLG/EhDZKgNUaKNoJz6sCCNE8B06k5+do5A04nNNmkUsRxwlw5HGswCPt3FTC2s
	LHCLij32J8/FhBORNtwZNMK8rQ8BZxsVDjFR3cfJpZrY0tQvNRuWz9KPcIzHjw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id EC1CD38039A;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:19 +0200
Subject: [PATCH v6 03/13] spi: spidev_test: make size argument mandatory
 for --size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-3-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=l3iFDMYh1QfxiCzvqTnmgRwu85cRujE2CN2zxe3Ghog=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKq49WWZ/1+FVE/sq0lescXib/b7HM3m3ff29dUpVj
 Zdra5cIdZSyMIhxMciKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACYSeZzhn7rczeqjjy4bB7r/
 5NEp/HwgsLN3W0jUmxyfiQ/MpQ9M12ZkWHUx9itbI49Pj/D02AnrtCZMN5/V0RgkeUvA0/jmzFk
 MDAA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

When the argument to --size is omitted, zero or not a number,
abort with a message instead of transmitting default_tx[].

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 0bd6ae419cbf..36292d868d69 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -41,9 +41,10 @@ static uint32_t speed = 500000;
 static uint16_t delay;
 static uint16_t word_delay;
 static int verbose;
-static int transfer_size;
+static int transfer_size = -1;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
+static int random_input;
 static int input_choices;
 
 static uint8_t default_tx[] = {
@@ -319,6 +320,7 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'S':
 			transfer_size = atoi(optarg);
+			random_input = 1;
 			input_choices++;
 			break;
 		case 'I':
@@ -454,6 +456,9 @@ int main(int argc, char *argv[])
 		pabort("at most one of -S (--size), -p, -i (--input) may be selected, "
 		       "and each may be specified only once");
 
+	if (random_input && transfer_size < 0)
+		pabort("a size argument is mandatory for -S (--size)");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");
@@ -509,7 +514,7 @@ int main(int argc, char *argv[])
 		transfer_escaped_string(fd, input_tx);
 	else if (input_file)
 		transfer_file(fd, input_file);
-	else if (transfer_size) {
+	else if (transfer_size >= 0) {
 		struct timespec last_stat;
 
 		clock_gettime(CLOCK_MONOTONIC, &last_stat);

-- 
2.56.0.rc0.108.gf0ef1b96a0

