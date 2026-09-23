Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01822577E4B;
	Wed, 23 Sep 2026 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194220; cv=pass; b=IMEeiRxJ+gCY2vJeNhrlrD4cFV8biq1msrfKTamEm5JwOk9dF84Y3kKJm2DTSTCMC0si+9FopIl7Zm52oGKhbIa8Tq8Mf3xCx6fvOfPs7L7EAbibC7osGctbOoB78Z7VEDHESPwXfm6aAfDsgvpLH8IPzSfycE2XpwHX15FmIyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194220; c=relaxed/simple;
	bh=RwiRc9QPgpQ3PJD6BhTgf1UsqFyVHmYQzc4kaDrTn0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIQ04ApMLO44TeCjO67TdFUYngvINQl051OHIv4bN72tChCLynpL1gSlVoR1m1zmTuPUNEHO2d2zoJG5BaPbkQvvsEPLtAtXNATkPNsMxE2GpdKrVtgoBnrF9eQX+XRchwsR+B9RgGpRXHDXq5ZVVDw/l8NXjlTaOvxwzz9Jw+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=TXEzKuJI; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="TXEzKuJI"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8C21D20200E;
	Wed, 23 Sep 2026 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0J9+GrhXtzUzxEtOI3PwxbOCzbTKhMnFeRp5Sx6I7iI=;
	b=TXEzKuJI1XBsJMe0jDrzZs0zDdXKFEeqOLV7Pl6PWbtA/laGNi3Vo2n1CC6UJfUwZRFs95
	nIYRC9pQT3bGQ+gEtZA0yuZqwvB1PvSn+gWBFVSMarExLEXKUxHz4xuySY5wIUPfEuSsig
	1ctWH4truU5P/5pGq9nqdLy5Rbt74+fhTD/C/yn+emBU6Uprg5hitwMpcspUmf149dHgtF
	NUZUYHOUE9WnfYAE4x7dNcm4YUqnaUAMb0Ghu8Uk4/LmMI5Z4t5qedOlPpiiREntasiWWF
	6m8tXS6AnT6aauw+KbPUAgG2Kv5GTnhiBfJ+97MOKy8wNKWNIlZ99sRRwbbU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0J9+GrhXtzUzxEtOI3PwxbOCzbTKhMnFeRp5Sx6I7iI=;
	b=X4H1/tjQ4/Ib4wJ/OG+xBWf1oDMIDpN/K776otecS1NoKYlgM7rI99SaWWl7v7sT6KIrJG
	xzTqBr4Jt7b0JlIRrd6k0mUtECBjY9QhH4AnTiqIRLE0v3/NKMgc3O1C5D3m5RpOVmWdS0
	xw6wy+s6C/wgBO50eRQbeFWjOHY8/3VWbE7PfnJ5RAaIoQO7/0ElsEI6D7at9POI57J1ss
	h9vQ+xQE5CMVI1MmpkKr9Ij3gB/r5r80EvgW8gP/IXR+NVsaHM6KzaCnuJzNVoPFD5I6t8
	8QYaMl9evg86Vrd7GjJm7GVimhFIjWe90LVyCOGhS7Rf1ObWQ97ttQnZ2sKe7w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194207; a=rsa-sha256;
	cv=none;
	b=TvApsVjOLNJTpMMBgAmdGW1mVdIlDsMuc2vIdaZdfsZxU1wfX4dntKIFK5gieIz0/bVvcY
	YPrvleo4GKEzGtIUs8mdZqCOD7YQpIYZpCQThiHcgE1NLZArQ3lP/+RNb8f2oM+WVWxSDx
	Ap5ieJurhO4xH2udjAJJNNVuFh0hduasuL8U6wIvnkqh6jkZgMAO75mqtUAEeOG2d8TuB1
	UE1SFHmi2fs/p/WT4KbyL608X1wknycVYAzYzynassm6KS4YJiccDQ1o66HaDJX7ZdX54e
	AV0GI2jLt6wqSvsqUDK5sVDrbXHoHxwDJct8crtIkh1jai390/GInbgds17uOw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-1Z;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:09:58 +0200
Subject: [PATCH v5 03/13] spi: spidev_test: make size argument mandatory
 for --size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-3-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=RwiRc9QPgpQ3PJD6BhTgf1UsqFyVHmYQzc4kaDrTn0A=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiR5LSrhQMm1VNeac3v5VWfpfFPjnTftwO/3ThKPA
 zZrBqyq7yhlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAEykbAUjQ+NqxW2XEpYZ1r7s
 mzHT82ZP9I7I+Px02ZT6iVcqC+60HWFkuKi+1ers5Z8nvcKPSnmmCi0tSF3TbXJ7fYTJdFHPrqU
 /WAE=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

When the argument to --size is omitted, zero or not a number,
abort with a message instead of transmitting default_tx[].

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 3721ed15352f..b2940a25b7a8 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -44,6 +44,7 @@ static int verbose;
 static int transfer_size;
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
@@ -453,6 +455,9 @@ int main(int argc, char *argv[])
 	if (input_choices > 1)
 		pabort("only one of -S (--size), -p, -i (--input) may be selected");
 
+	if (random_input && !transfer_size)
+		pabort("a nonzero size argument is mandatory for -S (--size)");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");

-- 
2.56.0.rc0.108.gf0ef1b96a0

