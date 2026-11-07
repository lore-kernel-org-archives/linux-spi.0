Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053323;
	b=n/6GPPOKk9dYJkglMHI36j7KYMG1PyFijnx1jyjhTDxtZNEquJVnLkQ/21ZjdMqUiBYA
	 iTjMOUAzVlmX8XDUMk3L1F8cx/NfiJuJBsaLxDIuTPeaWawSCFqXojJQzakPH/ktj+ARh
	 rL3PNucY8Nr11e4uN+Js+I+43oM8nDa6pkMJwa10uclL+elRo3ukK5A/cl4UvIFoM/d/c
	 h/7xVjcP68p6zIqxdam2mVoC6QCITVAjeMAD6bisezrcecZclviwhlP2iE9TU14N51mtK
	 MoboAeZV9S4f9I39Medv3qWuWA7NDiyDBwW9vdddjm2XAKBkMunROQAsuiUpJhrJJRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053323;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5nSQkXmXfxxM7Nm4tDDJOggvKcwjPg2ZURcHL5eMDZU=;
	b=XrYkWwvMQ562urcYcxrlTBQIuSXWy9nP4XWfWq0s90+5DBUKnPL9VnPv1ew+pSN98K3R
	 Pwe5I0gGvSiwDtnapu12D/07eOT4BfoS5F4UQyDfK98iK+wmgIdAVLNrCYGygWhip+u2s
	 yYruYBHUs53FSAKLqs73qBV5PYGYrpVgaFecELW1GZjJoZ+FBgJYzMjm99DElWYyjuban
	 2jIo3HyxBgDnorurgDvVDN9RWhWpbbFV38YgCgdg2VaoWkLlH/2uqcGbfMduSz3L39iov
	 gBI2cQC17IzA4BZJSC5WsFqnlyah+3rqL0x6mq/sRcao/0CHUUndQJIZYcFVeAqtFkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kco8H4wW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D323606A32E;
	Sat,  7 Nov 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kco8H4wW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A9D1F008A2;
	Sat,  7 Nov 2026 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053323;
	bh=5nSQkXmXfxxM7Nm4tDDJOggvKcwjPg2ZURcHL5eMDZU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=kco8H4wWuC5UfcMStDEe8y/qd36m13ItEovZCsCy8DPmg4eyzim2MWefgVAVCtsYF
	 fC9qMVtsoHc0/LV9JccFeGX+1QEbLnC33tPHih3whiHLeR41/fbACtGFlW9JUOAYoX
	 mFDy3qTFTjmFjvC9Jcj1f0FIdXDk76kI8ZZYZet2RAFG9FD5u3mWbIsmP15oWu2ClE
	 iHk4iBF3wKdc2WMUa6f5e1wgBSganvWTjSiEjPpxdNXNIaf+C6Ya5Q8Ni1heBU1ShR
	 JyTgk+aaPG4t8zXO7YDIFlRdM0nW43aA3DiPKVChV/7q39Jjlyb4X12YHfCZqSqNKW
	 vbnSg+rkPptSw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 62ACB28F342D;
	Sat, 07 Nov 2026 12:08:39 +0000 (GMT)
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
Subject: Re: [PATCH 5/5] spi: cadence-xspi: Add workaround for old Marvell
 firmwares
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, 
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, 
 Tanmay Jagdale <tanmay@marvell.com>
In-Reply-To: <20261104100643.162694-6-paul.cercueil@bootlin.com>
References: <20261104100643.162694-1-paul.cercueil@bootlin.com>
 <20261104100643.162694-6-paul.cercueil@bootlin.com>
Date: Sat, 07 Nov 2026 12:08:34 +0000
Message-Id: <179405331443.3424803.17548465864948492414.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4/sNqT1IMJMYOgXLlLBZ9E5WqJ86XdK7cwNGyKM8T2c=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeixyX26l799z0jLjVv5Im14mui18571vU7wNuCVN/y
 u9SspeZ3VHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJRL9j+CtdxlCgYWfZ4zKv
 zKqRVfz2l0oPd9ZU/m9CDxTt1LIXZDMyHPhYckr+4Uzm80r7Hju8esQWHpi03Mzr7cv1kcrKrl+
 TOAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Older firmwares from Marvell used the cdns,xspi-nor compatible string
> for the Marvell-specific xSPI IP, which is incompatible.
> 
> Add a workaround to support this by assuming that if the "xfer" resource
> is found, it means that a Marvell IP is used.

> +	if (res && !cdns_xspi->driver_data->mrvl_hw_overlay) {
> +		/*
> +		 * Handle old Marvell firmwares using the cdns,xspi-nor string
> +		 * instead of the marvell,cn10-xspi-nor string.
> +		 */
> +		dev_warn(dev, "Marvell-specific xfer resource passed, but using the cdns,xspi-nor compatible string. Please fix firmware!\n");
>  
> +		cdns_xspi->driver_data = &marvell_driver_data;

A bunch of ops were already selected further up in the function, that
probably needs to be moved after here too.

-- 
Mark Brown <broonie@kernel.org>
