Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46C377566;
	Fri, 25 Sep 2026 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790320336; cv=pass; b=GMijtPzeU7Vk0yyMC2dHRSj94iKgk9tW9tGGK+7h1smgkgXcy9NQFdmFux2YnX4SI2kjMTUn8u9YycvHzdUf1fHpBPaUVqcCUUmAytAXRC6kzU9ahVz+fbFeiO6VIBCRPf7ETN1KkQyZQbY1199l4K0gv6R5GWG2cVswMBvztCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790320336; c=relaxed/simple;
	bh=Lkiffe5FkjmRwCEIJiARInfaotTz0oU+aPya9yS26Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaSqJeWytCU5aLBkt3zPX1rabGqFZm7zb4CwTn1DNAFa/hTquZETSsVx8mlsG27NDz1WRVspyASadIdUN7Fuzc5cs/ogXdeJGJFjDNTievTsXJL5MXMQkLKcRdDxPOmmLzH1690yoQYwcTUTuKzFygM6P0t0eHbBZIu9uuoNHhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Bw9g2JvD; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Bw9g2JvD"
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: jre@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 768D72010E2;
	Fri, 25 Sep 2026 09:12:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790320332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s75d+fphesp7wa5+RMGKxgqYDyarIm8vHI66BTMR2Vg=;
	b=Bw9g2JvDigT83d8lWPMtZN5VDJowLx7u5qv+uMLU38sRPNtcDP2TAF+pGCKUpMBTRWZbHO
	VKbNnjxBRiyjChkoclh7hBmvyOJzSnxCX9aVdbJgNf8IKKOTaWiYYud06rdRdglyqYBkoK
	Rl50SeVuoWvD3ifJqadrJS8uTIQqzew0jeSXC9wbdoSkWQpVX5JZ60D9RASFW+fSdsjSdK
	ll0v9qH7wpGU7V3Joje72aA1jY+q4MW0cOeNuGzSc3WesYnR1SjNKrL0bOxn8JeV9oRD94
	ZHLCR5A6fGsrx0ZuEETRpfLxO/hG84AFYbZXz++FVuL8ZU5S8GXKTHt+RNUNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790320332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s75d+fphesp7wa5+RMGKxgqYDyarIm8vHI66BTMR2Vg=;
	b=e0n2VXVUUa8dN5yuDprVReT9i+ZVRS2MuORkmNKT1MA71Si3DHd/LK1/7z18pfwMUyoO26
	W480RbSUutwxCvLsiE7gMH4FQbxCTsYXkx7JGjpEWZQA1+gi1DyQp1wTd4eD8Ks2qqtGDf
	L5tStfQfxsUjhKTcUzC1mgg2KzezCKaTlI4/HOeAKAqNMNYtMcv8Ato9fVVHEmOicKZGBG
	Qpu5J+nZ1NiRYR3KlYpw76aQYpDTEOExZGbU7tle5cNFjWmEOxKTazNs6iBbdaiDVjPXGm
	+hGET3hnUJd/gN1+B7diswsob/ATsZs+e3FSf2cNVk9IoSuDW/oMVzJ9fgi89A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790320332; a=rsa-sha256;
	cv=none;
	b=HfOGIM5bJ2515uTo12VdA5HxZXujg25oWklWUlflbv4slBwoAq7oZEYMyhjBpXhFibu570
	6+o4FGbr+NtJcz33013wQXkeFg80POsJOHTdJBnrddjriaMJRAF2blTmEzj7jyZb05HI4A
	uoNH0GI88lEM59DeufK4goyde/f38xTtqFh7JX4hVo28V6WHmu77df74R33iPt1u7DMayy
	MDwxaeQalRf2WzV5eFXYsuNAKNk9ziLEcIf3fCqrmqfkSRRyfPYsMpkoVas8gIkT8iuTpF
	HEV5L6dkqwG/WjJG+/HQV6IkbMFr2ARkop+fUHkimoMiMbP+KU1rNFsXu4/BpA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jre@pengutronix.de smtp.mailfrom=jre@pengutronix.de
Message-ID: <a834ff79-bc22-4a9f-8e37-ddfb4fba124b@pengutronix.de>
Date: Fri, 25 Sep 2026 09:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] spi: spidev_test: don't mix up rx_rate and tx_rate
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
 <20260924-spi-sun4i-spidev_test-v7-8-126e31a07fdc@pengutronix.de>
 <dcb8c604-b394-4126-bfc0-81ce23603d26@sirena.org.uk>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <dcb8c604-b394-4126-bfc0-81ce23603d26@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

When printing the transfer rate, correctly label tx as tx and rx as rx.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---

Good catch! Should I add this to v8?

  tools/spi/spidev_test.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 5bd3159f61a7..1dfb748c1427 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -512,7 +512,7 @@ static void show_transfer_rate(void)
  	rx_rate = ((_read_count - prev_read_count) * 8) / (interval*1000.0);
  	tx_rate = ((_write_count - prev_write_count) * 8) / (interval*1000.0);
  
-	printf("rate: tx %.1fkbps, rx %.1fkbps\n", rx_rate, tx_rate);
+	printf("rate: tx %.1fkbps, rx %.1fkbps\n", tx_rate, rx_rate);
  
  	prev_read_count = _read_count;
  	prev_write_count = _write_count;
-- 
2.56.0.rc0.108.gf0ef1b96a0

