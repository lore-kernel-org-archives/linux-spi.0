Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256061;
	b=voXWdwEoXhOPdLMs2iQDzgrB7QuwW8G2oP2/TVbt2Klj4lPOtjDKMkSb10dkjOetlcBN
	 tKdMYcMVd2WqAjxVxzqEwhMB2fN9Ec52rYxsYcruSZhOVrknRZ2z6TlzyXI/3IfLiBhmp
	 4VXNjJXBjqGXG83ZC+l3I1XgXi3qCW9rXLfhARAepOO7cWnyOboUG5+1HaApiMlZAy2pa
	 3CKRuq444Mw8KTqNA96KKlawFecHXw6uyjKKyzAVClyNdolQupgR4nbJit2w7A+nfvJr0
	 jMqcWSLLlO4RqkVPZhuVR9rDd1NqRSsL6XzwHN3YAwVwuMXCaTzhQKNfpnRHx5zhdrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256061;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bSSYE7l0m2Lbw/z8BOO6ZEg+OH6DFPR1Glr9kdGiV3o=;
	b=yVnPNxgb1NWPJ2lBSazED4k7JJJwfz7KuWRs9O/Ty+g01nW52he//9RkF0b8l7xRlRsn
	 +YZ2E7EkZCX1r6Wh6ygQmZUP/c0JzmvEQ2U+CKq8gevrMKYnuG+T9ew2mkU07VfdcRjxV
	 WLCOcBBdTe0t1ibm9aPE7dNdT3z29pDRK+28BFZLV5+OnaopdvoStFYIcuVLdFFL9kapG
	 XRx2bjABeZpbvsgxSyo4IlGr4vFvAGrspRCPsA7VMzAlydapZjAMAJgfWjilIeX/MycEh
	 TpH8GWL84MsJgLfZHsxHJLpugToaJWHg4bbbyMGlzKSQcVL0rWsgdHO4JABD4rcrPnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHhjktSL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1AC606A321;
	Mon,  9 Nov 2026 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHhjktSL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F871F0089F;
	Mon,  9 Nov 2026 20:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794256060;
	bh=bSSYE7l0m2Lbw/z8BOO6ZEg+OH6DFPR1Glr9kdGiV3o=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=UHhjktSLeWOD/tGVNplwVa0Q7ggxUXoT+CFNoInRKLbMWeiez8pFUyYitGWg6ovNU
	 VOwffa3R/xHzJicPyIc5nq74rMgvFCS0+CtaEV84fcbnBujX62vJwfo7KGlFEirqrC
	 IAsEG2nMr4Cc3tE3AWsRg0FfDIIK64O+rATx34ZmMW/+Hzmym7Wtve4DsDgOe1ctSJ
	 H5tm4RyGfxiUOwpQaBEH8xocAiGmI0UBh0ShCpF+RzgYRY0tdvwITFo7iKgAOqXX7P
	 D5QNIOKBBvk1ACSUXqRuTg2mrrd8qsH5GrTWgM8uSyP1Vxu3oRqfvh/btaNz1wKCDi
	 Iv35oDyaakI8g==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 7722730216A6;
	Mon, 09 Nov 2026 20:27:04 +0000 (GMT)
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
Subject: Re: [PATCH 1/5] spi: sifive: fix division by zero in clock divisor
 calculation
From: Mark Brown <broonie@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 pjw@kernel.org, samuel.holland@sifive.com, william.zhang@broadcom.com, 
 kursad.oney@broadcom.com, jonas.gorski@gmail.com, 
 bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com, 
 florian.fainelli@broadcom.com, rafal@milecki.pl, 
 linux-arm-kernel@lists.infradead.org, sven@kernel.org, j@jannau.net, 
 neal@gompa.dev, asahi@lists.linux.dev, ryan.wanner@microchip.com, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev
In-Reply-To: <20261106234756882V9wUQNCEZAYUGTAbexMSL@zte.com.cn>
References: 20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn
 <20261106234756882V9wUQNCEZAYUGTAbexMSL@zte.com.cn>
Date: Mon, 09 Nov 2026 20:27:03 +0000
Message-Id: <179425602306.3711751.12136281369535948110.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=763; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5xd3GS5/MG9NcUE+L6KjqXG6YKTxSTMJYectNTsrnko=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+6Ux/lKFcMGP9nyZxi7W/mg7N3VBZbPJdrk1e23q73
 7FDvwwsOkpYGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjARLxOG/4GPfmTnXbhjyrhD
 4H1v0cUCwZ+tBXy7C+346q498LbaepLhx1KmWkOhWQHH7rhFPMsx+LjCJv615P293RUu+zPzzRO
 YAQ==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Clamp the divisor to 1 Hz so the divider calculation is well defined.

> +	/* A device with max_speed_hz == 0 must not divide by zero */
> +	speed_hz = max_t(u32, t->speed_hz, 1);
> +
>  	/* Calculate and program the clock rate */
> -	cr = DIV_ROUND_UP(clk_get_rate(spi->clk) >> 1, t->speed_hz) - 1;
> +	cr = DIV_ROUND_UP(clk_get_rate(spi->clk) >> 1, speed_hz) - 1;
>  	cr &= SIFIVE_SPI_SCKDIV_DIV_MASK;
>  	sifive_spi_write(spi, SIFIVE_SPI_REG_SCKDIV, cr);

If we did genuinely end up with a speed of 1Hz this results in only
dividing by 2, and we then truncate this to 12 bits to fit in the
register which feels a bit risky.  We should probably handle the
overflow if the result doesn't fit in the mask.

-- 
Mark Brown <broonie@kernel.org>
