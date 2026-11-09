Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256070;
	b=MIKZH4kGtimTbZ7VDeBBOX1kiPqpB+jTXe7Uyx+lWyhzDaGVpsSYOIvW4NmSucm3qjFb
	 TUAcW1XkK70mom+3myqzlQcyoCGpEfxrOuICUK1MWyc+RuyKA7TbPa8/gihvlcIZjR3Kv
	 NMWR87V48V+QhhKae1tUFigzQ3q016o9vL3QufpAmgh1MBMx8okhWtG6JWOVcxQiUoHe7
	 Cv7wbRW86c+ODqgdtGfoj48HunxPt1BkzFditNpzyprXTwxp30mdCoEq8/4rrfiNFOxN6
	 Ql7exJMt/zWvuPJcNlPc/aQ1gMKCBUVzvZ7vs6UO7Om1+oUgiBVlyLpjOSS4rOHPrfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256070;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=uSmqEwTPBCw7yv/vu+RoTvS1k78wUQRDkeFSllXkLKI=;
	b=TWoBjtrjfD3oxHZBq3z7WIGxzJElgpsKhvkgdEtKZVn4R1544M8LUmXvb+SqalzU3bCo
	 /27qnv50wKQKO2iVGexRjSr2SDXU/oG89r1QX+Y4G+xz0reA4UBcRJhKvHOiY2+qBa7T/
	 c9yWcqEJkXqAaY+yD9T92ohBhgaSZFjasCxl4GahbxgNuE/GH/x0+2OF6/0BDC3TY+GO0
	 fPOolFR/yID7QE19zVYKbvmomIfqVuQNGyIHKGoFEmsKyRa4K1G2thkCFmC+qXtQA2odI
	 2reWauTXJmbT/EflcelRwbM8aJKJtAjOUB0gMPKuhB2QMJWol/ixc8nQDpI8UUsHViQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8FIBdKP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53322606A31C;
	Mon,  9 Nov 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8FIBdKP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7830A1F008A1;
	Mon,  9 Nov 2026 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794256069;
	bh=uSmqEwTPBCw7yv/vu+RoTvS1k78wUQRDkeFSllXkLKI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=A8FIBdKPcoGsNZlhGhiZxSuNdfssvT5PPZ6PrGGJaBdnGlh1o1Uoc3D7idyPnLDiT
	 opYuDkhI6iTo2Dkz+j/2fqI0v2JoKsTponThIl770h6qo0JswzOFpuPxvcoISfhMLO
	 96j3RJ4LE5aydnXA6E3B6PD9yMVvYhuO+YDa7DOayKR1+meLwulbZPWOyrGw/Zy9XR
	 15iPrvzzJn0jCEPLUw84HtOy53ejShG6QX23kJRYzSx+whednhH04vvje3HVr3t+Dm
	 nW4yxHSm4PYTVRKI2m50h9lbf4d2syeJKmb9gnxqIi/Ac3TCjiT0EH0AYw5cSRm0nW
	 MzROyVWkrB9Sw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 7B1B130216A7;
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
Subject: Re: [PATCH 5/5] spi: atmel: fix division by zero when transfer
 speed is zero
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
In-Reply-To: <20261106234803459Z94udUX-Ai29-OfBFRND6@zte.com.cn>
References: 20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn
 <20261106234803459Z94udUX-Ai29-OfBFRND6@zte.com.cn>
Date: Mon, 09 Nov 2026 20:27:03 +0000
Message-Id: <179425602307.3711751.7845465463671042950.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5Ht5M+VjLA+M4Oeg4Wh7v9V7rBg4ioA0/PuJ6uvdihU=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+6cwo4GpdvnHDs+b2EqXGWWmFbOv3bLGv27Gy+iRXw
 +xl6+0CO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjAR/XKG/+mKh+SPln9/OHVZ
 iTCL3Tnj7mVTVhZfq9utt/jr8s0KtXMY/udUHd3KsWHVo+SciZ4KfYlxvJ7TO/hbzxa9OPSEs/v
 IY04A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> atmel_spi_one_transfer() calls atmel_spi_set_xfer_speed() for every
> transfer.  A device whose max_speed_hz is zero (no spi-max-frequency
> property, or created through the spidev sysfs new_device interface
> without a speed) leaves the transfer speed at zero, and the divider
> calculation divides by it.  spi_setup() would only clamp the speed if
> host->max_speed_hz was set, which this driver does not do.

...

> Clamp the divisor to 1 Hz so the zero never reaches the division.

> -	scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
> +	scbr = DIV_ROUND_UP(bus_hz, max_t(u32, xfer->speed_hz, 1));

This has a similar issue with limiting, in this case even worse as we
generate an invalid SCBR value and then validate it later in the
function.  We should just set the maximum instead of bothering with the
division if we're subsituting a default here.

-- 
Mark Brown <broonie@kernel.org>
