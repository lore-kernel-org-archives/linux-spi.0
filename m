Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83348F03E;
	Thu, 24 Sep 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257463; cv=pass; b=op/Xk6LqFtNp5sDIyAk4E2Sq3zR/hdJrEJ01XC0uCJ8OC0oXJ4eLw0UiZRX+yZn7Cl1gniytfbCKBHmbHzlEoCt0KWjrL+i9kSPSG6gBymasUJO06/HlKpjfvQKdmu5/dmBgY3X4igcmfnRpt2HYS6DoXswKsgisp6XHyLHQijE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257463; c=relaxed/simple;
	bh=vR5sqWR/nWd+VdjrhfgG4Pruhff0XIMs5Q1R9eBOYOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVHvG+dxaerBaLaxlc4tj42MMc6btZTPnDrD92OQWZSgAuFCtGcwigAgkEZcb8hpSb3Qc0eehJhxE7/9W1bM1jLfdGkQUhkH62uDmr0pd7wviMKVtr9c1J8vmOz3IBb7DsMOYTdu5qkXqBCd83iKrplwmD0z/eVo/OABRARIiO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=AvvvjlP9; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="AvvvjlP9"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E287B2021F4;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nCQgkiuymy57snvAWn8LGeNEAr79Fh5kpire67Y6iDU=;
	b=AvvvjlP9oouUIJvTi4wnfHm48MYRQkNU9Pi4kOwlDGiQdAPptIDLZP6N2tQDT5O5T593RH
	Qpr5HOnMhp2NuXSQAhE9StW0B3JJk3XY4+wJNJiBA47aMY0X/uleWwCKFCJzbWPj6Qihsz
	PWIEGcRdB0vrYvR9HA2ValD1Q+3aNKNTpSVelwIyEU+/xOWZ/pDpkZ0nmRXgao7Qzvg/QQ
	rFOzQuucpMsamoX/n6kiAqcoVBJ31UvLbFLCo8n96+Y3+xW6P45ETOrfX91jSPlZZoZeO2
	2mx2QVp6qBkdPwmrmtCyiwiCN0meO0OS54LeX4k0/eK5qTxhvQaokEgbHyzA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nCQgkiuymy57snvAWn8LGeNEAr79Fh5kpire67Y6iDU=;
	b=fQ5qmZVSpHzo1qBmJyOkbUa0MC1Ogk1yGqvlhH0W32rStfpbSysqGOdf0L7zWtcBUTutX8
	X3XiUWn8/tOG/DKFfYUINWn23jAQc60/dlvxYQLi8RgM9acmvFFgOENBoYfQICcBamIwYu
	pEkspj4BgY/3cgeXsLhWh0afhmtWPhe0SUeKuCqs9yu1bVnWtwbgopTUHrUzL24y9ziiBF
	6h5O/tvjhMb3OCii/67mdvgJ1gznAMCwblngQVsROi/PzCrLMoGsxMfESJLttjAanYJLVk
	MmleaTkSj38lg2iBllerDBbAkVsg6xz2McqZYtxRQ0/zVxj39wcokrlrhsk3Bw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=OD8xsfwVlzXfTGtVKzF2w4cDyFEi319VrmoUpFjBsGYrjjNrG6fOJSaJGSjjdnCrur4hI7
	NL/zTbxxGBfPLFtVKNjQ2+V8yE6hnJCOwWGM2jjm8Dc5XPnqY6g0kUhmhO9T+lAOjWBdGE
	i2P1VTNld3YQOd8oBGBToW2zQQNlmwrG703BrOCrmj8tNz0jKL60i5sscu4ZtI8HfQ9BB8
	LnBYONCNBJZWtr0Q6UJmhP58usOk6IY2MOnj+qdfH6B+F02KANR+1VP2/TAQU/rLa4vYoZ
	vtT4SQYc7YcKqRd9XUzo0YfZwANlvASNYDiVFXVwYQXCTbUgC0F/x4AwdCirEw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 96F5A389213;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:44:02 +0200
Subject: [PATCH v7 12/13] spi: spidev_test: print TX on error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-12-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=XAdyvSbHsZttpkVRgKKTfki4zPWPU0Rk3xOF0kHQYEU=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqqn28qyWbKp/0jUhnkk9yzKPpbZMO7Y2/VxdW+CVt
 gORAYu1OkpZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABNxn8nIsH61d5b4XOMJJb42
 alzrAtZ1T4s7/mHBh5KGmVV/wngbnzL8D+9ena/08WPQy2cBN/7cKJViiq3rcmLq6tD3C3bPY5/
 CBwA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

If sending an spi message fails, dump its first up to 256 bytes to the
console.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index ac24d051835f..61951ed1c908 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -197,8 +197,18 @@ static void transfer(int fd, uint8_t const * const tx, uint8_t const * const rx,
 
 	ret = ioctl(fd, SPI_IOC_MESSAGE(effective_transfers), tr);
 	free(tr);
-	if (ret < 0)
+	if (ret < 0) {
+		const size_t dump_len = min_t(size_t, len, 256);
+		int saved_errno = errno;
+
+		if (tx) {
+			hex_dump(tx, dump_len, 32, "TX");
+			if (len > dump_len)
+				printf("... (%zu more bytes)\n", len - dump_len);
+		}
+		errno = saved_errno;
 		pabort("can't send spi message");
+	}
 
 	if (verbose && tx)
 		hex_dump(tx, len, 32, "TX");

-- 
2.56.0.rc0.108.gf0ef1b96a0

