Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801310;
	b=BefYmD+oK06/ydww8JNcpihYyEZ751VzZUaQIHsDaZLKaeaeNY8wu14m6gh7/42dsFLt
	 dOUS4hrXgodVTGgFoR/1GCCCv5BxQNGVr6L/Z8OtXxn2ZejssQ0adCMUsUj1+xr/K2PHm
	 6BNu4/QY94xrqOVw1LN6Pa6Ny7QPxy9J7e2llOqSeeCLkUdYsBauWBy5HXTivS2+8Gmpi
	 W/4JUeFW9T+cR8oyb8CW0IEcweLu3QDuA2vHZMbPforGSdVZ18pYtvx79WuCF9LJ12LFP
	 rWEQuo8txbA6K8iODPxuRp51L0i6Zjj5DJTQiPcxiA0nvfAQZZWLR8gQLXD82YbU5cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=dWwYy9yOUtMM9FKrkdi2HNFhdL0N+OVbqHHFpRUCaAo=;
	b=O2uXzWqEElr5xw49z+QzJ7C/szIC17yx7EQuqOu0sqxj7JhlJRx0/Dh7mS0ik/prDs9f
	 2adqgO6jlFDEWDyZHf7/87PLhYaxKe3DFSxWOCRXKzhuxGn7T2ACBeQ/yFuXuPWJraN67
	 vT9bq/cm+8Sr4EQHyt4koVIeFrgizfBPet28OOtdV4IdBF1YS2A2CT970nbSED+gEVRlt
	 gfxOvY3w7qu6vaXgFZXMRG9nGd+4wPaXn+KOL9rklCwGNxv6C564R9ppPHhXMY8waql0N
	 imZua6lsu472341/j8UMKdYloqhlvxVznXo3ZxCaJB55oeJaaoTRz7LUQf+NDAViNgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1iJhxYi;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F020606A332
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 14:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F020606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1iJhxYi
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so403135b3a.0
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2026 06:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801309; x=1794406109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWwYy9yOUtMM9FKrkdi2HNFhdL0N+OVbqHHFpRUCaAo=;
        b=q1iJhxYi15RMQdoeJ+jJvEo/uA+nv7K6gF7LiPYuGUstobJKghqUzgOqOWqc+FL69i
         4XWTRMg456PKmjmM5qKW84a9CrVkbUFMeyk3Ge1TlcCPL9pFgo9B8WVUROrLIhz2tVPj
         Mrw4Zb/e5oU77YR8k2yvNHa18WP/j7Fwthi/aJ+eKK9wb5yRe/WYsiws6lTf1TPr0lH6
         y2v/4ufwKEmTc1vhTKzBgmunVLVo1R/briGCeFK8vBsabFqwX2xAdMbcSyHwc+fQopIR
         4s3WlGizhh+4L9ioIwaWxb8AupG+GqtZagWqjydS7MFSuoCTycyvpLjGfLscUepuGOKC
         Johg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801309; x=1794406109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dWwYy9yOUtMM9FKrkdi2HNFhdL0N+OVbqHHFpRUCaAo=;
        b=ay9iMCbvecP9gSSWIv/eJBUWPo9QX9Cbzb3ZgWEfE4ly9Aht4GaYUw9UDGjXsPscc8
         5fjHGr5K4yNYB28GZbyh6I3jfNZw3WGigoWLXfzRXoWuaVJyq4nET6NV6B17lSvtbp+L
         Nso/5GP2Yw0PkQl2lUOTBjFVvZu0za8xb5Kb+ZeauzJ1ccKa2T5nuXVReC92iwha3PYJ
         0mken42IVEdSs2awO8E0DJyGH1eC/OBwOYMvUG4vOURpIzySWTHYOaD0Y/00f2kUxAAz
         PVetx+LeXlrmZ8cizafQ1jSn+biiW7fswr2mzCnIRAs93S/jdKthSFX2MCAcDsanLcaX
         Pssw==
X-Gm-Message-State: APuU4Z9ZLXq9AG3cVSnLCbn/XeObDb8Vo/+TdFAFPya6JvTWqi5ezeDO
	qmTJ9QQ6xoLcjSO0wmHr3TvemczXlezBnSxoIH6lp+Y8DWgoH2I6H3AR
X-Gm-Gg: AYBFou2FFRRwknYmWmPdoHw0uShWOn219pKtjt102po7hgx0OHVGTyG5nusWctNOZLD
	rcjw2H2N/cc4j4zIvo4L1FeiYkz6E1XiPLGsby2xIU1k0W8A8Ucg4RgkA4NgTHu5cL0qK0uqdx8
	b+2p1k37AEIlZpiT97823m3u3DH83T1OVWM/tdi7NgWATKru/CLK6d2S6Nwxer+VdHMBJeUfFt6
	ONpUD9NHcH6aMcZ+wl5i15kXrtsGEOH7V5+VeZ/61ZWPbgdbG1/obAMO6yifSUcHXaOhq0ZyEcp
	leR9vdXZrC5QUsW8YoCu7hFjOo+ybmfpHPpOkZYPBD6BKoIoDUUAebkU3AmcUBZ2drOS5qnl4n3
	ZoeYwJGaEXEbMnhYjZB0MCIxkgXPi8WaMbQwZ9STUAiyaM22jYZNSb8y4+iuDIDFJBYhOzRnUcN
	gKrcK32agBMJg+9GHaAe7MvHD0qShdQeGkc8fJLrqNDB4/Ts0Vbc66VRGH/T86nOOoDN88NspT4
	gf/pMXjBzscLsZtEAzk6UCCsbY3T2VsLMY59Hzj0SF4tZTKQMJThwA7Yo5HvLvr8UhsO3NpPX34
	ykO07itPYXKnhUg/6fLVWm22SDbDXUPRcBkrad9mXLOwA7Kh8F3GOOeuRCML2YiSOzlyoPuW0Xl
	Oq2mg16rvkHTwRI0g1AHIr0U=
X-Received: by 2002:a05:6a00:3d04:b0:8a0:5d6f:8a5b with SMTP id d2e1a72fcca58-8a9bfddfbcdmr13245493b3a.50.1793801309436;
        Wed, 04 Nov 2026 06:08:29 -0800 (PST)
Received: from junjungu-PC.localdomain ([223.167.147.108])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8b09ba508fasm990259b3a.48.2026.11.04.06.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:08:29 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 04 Nov 2026 22:08:12 +0800
Subject: [PATCH 3/3] spi: ti-qspi: Correct runtime PM error message
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
Message-Id: <20261104-ti-qspi-v1-3-c286943c22c3@gmail.com>
References: <20261104-ti-qspi-v1-0-c286943c22c3@gmail.com>
In-Reply-To: <20261104-ti-qspi-v1-0-c286943c22c3@gmail.com>
To: Mark Brown <broonie@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@linaro.org>, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793801296; l=728;
 i=ustc.gu@gmail.com; s=20261030; h=from:subject:message-id;
 bh=mlxKx0GdG0RFl4NpxWtZoGjus73/eWTJRgYdr2YGhH4=;
 b=7R9FtVIsPVOYT/0WyJbN8HNnDVWe0J6QpiVy4H/kA7NtNIAcsrbC+hnDFjEE/m93f/c6sgEi3
 SwbxyeFzO0qC0/uKR8Lvb886Ozjwi+qUw0q5jv3xRVw2PY9rbP6YLKr
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjDJtbnSeysEBjmOfNYqYUUDS6g7Tfov9W5oGngTBfo=

Update the error message to name pm_runtime_resume_and_get() instead
of the previously used pm_runtime_get_sync().

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-ti-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 2026fbcbeb90..c9fc0bf4b8fc 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -154,7 +154,7 @@ static int ti_qspi_setup(struct spi_device *spi)
 
 	ret = pm_runtime_resume_and_get(qspi->dev);
 	if (ret < 0) {
-		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
+		dev_err(qspi->dev, "pm_runtime_resume_and_get() failed\n");
 		return ret;
 	}
 

-- 
2.53.0

