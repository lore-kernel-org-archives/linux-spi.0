Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977139;
	b=bGwjYE5TGjmB1C60UsXZfLqVAqnm1euVO4rjmtXSn+iKeZGmhaYfW0uVm/IFGxnmxBKZ
	 5PZQc1TM9DnX78cvLXn3YcxS7nauA+Hg5pf2qiKMVQ7m8yexEfX0+Oy1edF8Nbi1BcDgw
	 1w2LEQRlT++fhWuekoqyc8KCXN9BU5gsCvmVPeYJsIW496asEANDK9omOUr2CcpkKnqBV
	 YIiB+nPM2AUtntAIkiqMUW59c4ZH5CFN6VvZa8mcw8N0xXTddTgcNhtwFIVI0uF7+yGCL
	 XUZL5gBW9ar5n8BME9f2Ul2wQLn1+Xw3xSdi7BEUvquj1tv4hMU1Dlhk2o0Y05VvIkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977139;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ztkgEBcGofqcpTmvgtqoSEmYhOEkwYXMRCRepVIF+24=;
	b=BL4pAXcg2bGcuorrT1NhqVyKiQ8EV3jFYICk0DeRQ3nWao+iN6hE+Nz4Aotcbww1QCBg
	 2xeZrKDPt0VjAxt8ykmuH93EfohwYfOUepoJudfBa2s700VIALAxW3qvI3TABAq2NL446
	 BfEGY2KOza2hj+itPkTBfgkzJSmqebYnAkP01iDwb9wuqpz0sVmtVlTsonoSS8h7PT483
	 QGxYcoV8aiJn8tBvX08D6SnBqGEqk6QCnZzOSYhok/x804vxP1+fGWVLfKjv0iTHeXpOG
	 9j4tBOg4S9bdTgEJlchRMZXrlc3dLN0GxLRyNn4iQqU0WSviL2Zcwh5+PyHHuid1qaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7letiVq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4131606A329
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7letiVq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516E21F008A1;
	Fri,  6 Nov 2026 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977138;
	bh=ztkgEBcGofqcpTmvgtqoSEmYhOEkwYXMRCRepVIF+24=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=F7letiVqvCssUTrccMfIzoyzEEEscr9xSgWzM+KV25xyPl18yAGml4ALQKbK9oFGc
	 j0v5pGzZZ2UdcGzR6Vq+1uQjp+tmuuJwrDlNV+Y/6Pm1ExJWyzqNpi3Rqi1xoU/+GO
	 QiyXTc0T02zCPhT8uTmwfyh9SP8aeP7NCqP2AB0LMLewDLd3+F9mUGHodPsGfwwJw5
	 9AGaoRyCv/lyJQNwxSOf4aSVuPOD/I5waAgZ5dmyzTepAGzNgRtLXMd0ia4Y9zTIwp
	 jfzoWWIeBtgeQm0lxk3ARHzA+S8TzmjNaIVlDwGZYrAZOXcctiely3BN7KEf9yl0b2
	 CzVIZJxOeTHTg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 08103289C411;
	Fri, 06 Nov 2026 14:58:40 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] spi: rockchip: Fix runtime PM underflow on CS error
 paths
From: Mark Brown <broonie@kernel.org>
To: Alexander Shiyan <eagle.alexander923@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20260806191854.922530-1-eagle.alexander923@gmail.com>
References: <20260806191854.922530-1-eagle.alexander923@gmail.com>
Date: Fri, 06 Nov 2026 14:58:38 +0000
Message-Id: <179397711825.3231166.14531785924256368148.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=701; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8DbhSsyDLwBEwvmYHDxI09dNPGpLlc0fHFNJSjSLDro=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLevpbPq8yLe2bMdy04w4zF+l3buZXPTNL3Ls5wfbrLx
 +vDLZkzHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZiI7n2G/9W37J8F3Czf1fxy
 2wK2U+c5N+6za5YRWLj7RK9Gr4O68VWGvyLFfqY/6vNfSKe7b646NSfizS/jT/8/S7k1nDk9dYd
 wHiMA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The Rockchip SPI driver manages runtime PM reference counting around
> chip select (CS) assertion: pm_runtime_get_sync() is called when CS is
> asserted, and pm_runtime_put() when deasserted. This balanced pair is
> expected.

> @@ -256,6 +257,7 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
>  	if (cs_asserted) {
>  		/* Keep things powered as long as CS is asserted */
>  		pm_runtime_get_sync(rs->dev);
> +		rs->cs_claimed = true;

This sort of boolean tracking of reference counts is extremely error
prone, and note that there are two chip selects on the device.  This
should probably at least be per chip select.

-- 
Mark Brown <broonie@kernel.org>
