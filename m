Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128D47C0E2;
	Thu, 24 Sep 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252853; cv=pass; b=OzGOboI3ZM0jEhJJtqUHVAdGA+k4o9Q4nOp/P4uHzRjkw9g58nC9sk55MshEpAira0Jo+4i7SLxZZpDCU74ghZGyYRbUFIGf7le5h86Yomeda6i8o7GWSUmpqI08iFlyreGmIisSIgplYbQ5upzvC1lD0372nhzd1Evqwst1kVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252853; c=relaxed/simple;
	bh=e1lyzIN2yK38kMVVEnZr4CyFEuSoy1/+Xx5TAndcZZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uk/xI3PA8Oehot10zpak4J+wpMI958CbMNIXf2FHzI9EXKJjuitOtPx54UdjXgU2vKsaq8SiFAA2MCYJccXIqHrEdkgGiPKqltL0SQ8ef77yiqFFmBaWMJA9tCLAS+qVr9q6d6ri9PEGl7UI10K4lHfxoOG78bj9BOVosNmsGR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=f+RbA3qj; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="f+RbA3qj"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 22175202122;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VKvwYgTV+3klTNx4TKLlBFDJQwc6zphT2d4plwh8xg=;
	b=f+RbA3qjaH4J/lnqaz8x1KaEluUrZDFLJ8sng0uHkLSnjsM+lCrsg4LzpSKn/blA9U7ri4
	9yCQuHNRCRU5qSjFfKwac3GupSghdTxjQSHhnonXgBsMcT1FzL11WUS77Wh0fcTArr8cGi
	/fDE7kniuo7mBzXaqlZ1X16g7ZqfEYhlG9L1rZAzWp+GBKxjFutf/zrbAI3oLEuuSMhF1Y
	hHhix+NSuAXCG8VNMJM+eYfe68xKydQ4MZA+6NisWxLZyHCIu9PIJXrn6lFJQqsQ8eT3Zm
	/Wk07Y8AZ2RL0rZJpzJoBJHohMrZO5xx3SBPWZAEq8wCVeoxVOo1VSEPUO4Q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VKvwYgTV+3klTNx4TKLlBFDJQwc6zphT2d4plwh8xg=;
	b=cR2NVg/Tvx8Ls6o/wyhH7jk3ssuOJwgnhniuLdfUBv0sDR2DBgwZqJfuRpnJrLJF1hURI0
	Mhn0p8l7fbUmf44qamfrDkC05iW8NN+ksLfuJUkGUlXb9V2O8KDCQDCYjy2UIG2/b9/THE
	OUtBgh6L+CMEbg8wuHLo2586vUbql4p3RaeE+oBygyDv9OxweAXeKWuWPM+J2Ycacr/NLJ
	lYIAhze/eznweQ4LWbbr7C1N4LW9EWII8s8p16mV/y6DOl0MKaHdONMgPB+UDFDALsYe4a
	7+Czi77LruR83UhalZ7esXeGSQD6ZHAt1PPHYEMJ+3APv73jvocRVhAqkurZBQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=FsnL2gplWm4MA+QH6cuShCeQLH39EKSXxTSoePLH7/KxrEfzfjGWRexsy9rg/Tr+DHsSFC
	QtWJXGwUsERoZ48SKqnNRx888F77JbUkVMsqT/PJc1UEjq5awY5qCg0K0aJQxlTicQvnBO
	zLPj25sghKloGBmX7ugyMVir5C+54rO3el6BZr7zHqUaLI0z9ukWq1ADCSfsGXy2NlnriT
	epRyqfn0w13CZrRPnjh5pMWpOO1vPvuGEPdNHU5fSrtETWPut86H9YBZlMxaCTiuxJv7YM
	bhv+0RBfsRv9n9c7oJk6e3imy/ObK8N8ID6dUyAsWgWICrrC+c/c4OacpxKh5Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id EC6623804D4;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:20 +0200
Subject: [PATCH v6 04/13] spi: spidev_test: allow zero-length transfers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-4-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=e1lyzIN2yK38kMVVEnZr4CyFEuSoy1/+Xx5TAndcZZA=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKq7zbd6Z8qyQIpvESq8LW469LxBbqVs1QdVtylr+j
 cYdpk9qOkpZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABOZIMrwz+Je6qb2NwEfdn5d
 IxI17WGYD+fDmw3RHCttvm5eIXkojZXhN1vwu8Zj+/Kv1AisO/xou5Wun+StffJbj7YE7g0N+HL
 hPhsA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

SPI drivers may in fact handle zero-length transfers. The behavior so
far was that such transfers would be executed but then result in the
"can't send spi message" error message because the spi_sync() call
returning 0 would be treated as an error while really it simply
indicates that zero bytes were successfully transferred in a message.

Don't treat a return value of zero as indication of an error.

Update hex_dump() to work with empty buffers now printing e.g.

  TX | __ ||

Now including a trailing newline.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 36292d868d69..908ed038889b 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -68,6 +68,10 @@ static void hex_dump(const void *src, size_t length, size_t line_size,
 	unsigned char c;
 
 	printf("%s | ", prefix);
+
+	if (length == 0)
+		printf("__ ||\n");
+
 	while (length-- > 0) {
 		printf("%02X ", *address++);
 		if (!(++i % line_size) || (length == 0 && i % line_size)) {
@@ -149,7 +153,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 	}
 
 	ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
-	if (ret < 1)
+	if (ret < 0)
 		pabort("can't send spi message");
 
 	if (verbose)

-- 
2.56.0.rc0.108.gf0ef1b96a0

