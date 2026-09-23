Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358E565110;
	Wed, 23 Sep 2026 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194219; cv=pass; b=MvudU9iuYLi4y/J2cKZgbvNdjEtHu+NBf4iEBHVSOpQRAoNvmg0iPqq8W/cvO0lKLKLeIGzOMgjCdfgf0MqdHzTHX21mF6cZUv0kg12DJQHmYFgFIeZXitaeJwrbMZjzJ5/oQF5NvjUOCJsG6uBgr+4JrtQOhOztRZmx12mMBt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194219; c=relaxed/simple;
	bh=1siKSRvhnv/OXuPwSTYRUUqqoFhdX5XlEnfgnS3F6ds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PzZWzL/vkgXTALqa9MqzxtZh7hXYeXWgdf6MHN5ct2/3azoxp2WfNWt8iFupwjjW4xTbh3HQAZwRtk+uw2C3ximjP1hpxubbrnWfyOx9A/JcoKKV464OtosWuEilvCJLXwRXDt45ftP2Bb9YerSeshhCl6NrJVWK5oWPcdGFlxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Mo61Be8q; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Mo61Be8q"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 83071201FAF;
	Wed, 23 Sep 2026 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHynKvBUts0aZW3ptaf3U9h+p5xs2LODc3+D+ISVZ0o=;
	b=Mo61Be8qQxWB/yHNHZvUxzCKuVuaD8MCva5rfQcLm01WfNQVAUdE+crPuMfc0W9jSBV3yC
	MAVNAxgjHAgJaoNZKemp+wO3/nCw44wnS93o8F5pRy+IUSvFxek2jlL+xQ4KZWI/aCHrdR
	DMTiqP6YH02fc6XNIEjxyui40CGJYBrH9PMN7CuNcd2uD1oMd+CylzKE/ZwWCnHYYH+Zso
	DKNI0l2kWQlp8FTtNG6sHxVMF76nDYciXA4naDKpXxg9KfmUS9qOpbTmWoTr6ncjSktX5U
	t4iuE5cjNvPhxpx7G9Ve5sQf3GVAGr1hlQxw5M3OVLa5OEvExJDzgrwkqS2npA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHynKvBUts0aZW3ptaf3U9h+p5xs2LODc3+D+ISVZ0o=;
	b=X8xb7kp6CniGgb12xnyRyyApwCXhd5TKUS1kvQ6dbW+TPlDWoRO41Ci6TPpGZeZy0rdY9f
	7QYr8Y+z37ElCYADCx8fG61eS8r1HGgu3b7LfICbY4t7huQ0KL3ZHvOAzzTPqKsJINAJkK
	8XXCph3gB1uvqKaLkAKz2fKM0zW1JGwxef1JHfXAGmAs72wdhLePSiafcrPTN/nFWUgJWY
	+AHODAjk7Eloq0hULCIGiVY2z1Rtvi/mm1iemfQHQkgzcsxJIHzQPBAglD83L+jSFOJld8
	JQNL9mB/dp2BYLDWdc/WIp8R3+dXx+WMRe++Vkc5fPFreFy3/eLA7tNKxKuiMA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194207; a=rsa-sha256;
	cv=none;
	b=ISTc4m7FlyCLD6aZo3cMfGRhRdm7+3HrupYW+kUpLfVhJc4q7N+OZlEsK+XYy4M2jbqzaz
	drkkRkg8EcknIyn1A753fQVwy/KCtCxEkL5rQnOlPdonVWKOWbQm8Rsv3U5GR6rQ9bfk+f
	bdG/I+wkB9J1WZB8v97/PljlVLUxiIYZ+8rgq/gyRQwkvoqRDSHiHSJsgNU08Xkvi/H7LJ
	DYqpEHrMoQqQemsO1aI+5yLgcffMtCz7+Yztw8govOm8/EGYGze2d5AfcHNufJL5ycLWhF
	wUe9Oic8D6x+Iv/HFNjKk7aVVjIGv0qhxhTm4VdY9u9bWhaGmc3KKRB9O4QeaA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-1Q;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:09:57 +0200
Subject: [PATCH v5 02/13] spi: spidev_test: clarify usage for --size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-2-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=1siKSRvhnv/OXuPwSTYRUUqqoFhdX5XlEnfgnS3F6ds=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiT5zfWF00TG/a9/Sk8ofut34EPSd9n5dlZdnxdk7
 ZsSskjlfEcpC4MYF4OsmCJLrJqcgpCx/3WzSrtYmDmsTCBDGLg4BWAitmkM/4ss+P5crP72rYDT
 eZPb0ktNhxa/Omj469YpuznCDltlOo8zMjz/a/Vi055jN6Z/XHPfZn3ytscx4XfvNXsfjbxckbx
 y5l1WAA==
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
 tools/spi/spidev_test.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index bd5ee7a6ac82..3721ed15352f 100644
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
@@ -446,8 +450,8 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (input_tx && input_file)
-		pabort("only one of -p and --input may be selected");
+	if (input_choices > 1)
+		pabort("only one of -S (--size), -p, -i (--input) may be selected");
 
 	fd = open(device, O_RDWR);
 	if (fd < 0)

-- 
2.56.0.rc0.108.gf0ef1b96a0

