Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795085987;
	b=MFmeUuIyimfo8q4ON3GR8tnE6VRKta69S2kib1KcX9cdfr/Xr3T334PWKJp0PGppD49W
	 Z3yuIhymVkBub+1SnPcUrgGmO8DFZxSsAIFjYJgK7GV1/NL/YnFWY7YXy8IJTorNGPJoj
	 5BZ/uCPdjpv4OI6VpqHLGehcwAlkKZyrmqqaWPNdQJhy5xu+nH9rOj6WSv4GD+G2T9e3I
	 +D1SYNOXToxP7Z1smhohFJ/MKoBb+AD9zqIArOwEaL5SZNcMveaxU914tmokE2GhR+dVv
	 sjn4f4RFF9qfxCoTyP0tzoQw6UQ4ZMmpklR/5MUOd4ljgguf6dQLO0dHM8TfMh7bZlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085987;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=uZmBVCO/E+M3LGN206IhnPbUYGaF035jqFVGv/CZR9E=;
	b=aiTVyaHLyiyFikWkIruH7OmMq5XGDB6L7vQy30PxOGrROV3gVRj0Fc0yFhUJNbfUsmz+
	 jBJCWKMpcgywDkV6GtuOiokkwjCe3SjfMz27uKUssxdXUtwAYkLSu0iIKHW6dmLubQRiU
	 5avGiUejF/TecKruMfMZ0uQOzMwno1mHyN+gnKNtttHug+vAs59vBR7seZUXiHnWGIUW6
	 KfvtLw4Tif2giugB1KbqKygckQWnwufq6/ZQsv/8BZuJpBVvY828sJcjlLuhkqXNUj3vs
	 +J7YPXODh81r0+cAh+PHnPAsxlzAUO+N6T5M0hZ+kE+nuSom+3J3VwK8cqoF/Lsmu2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dKHe7A8q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFD606A324
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 10:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18DFD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dKHe7A8q
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9EC68200F2F;
	Thu, 19 Nov 2026 11:59:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795085983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZmBVCO/E+M3LGN206IhnPbUYGaF035jqFVGv/CZR9E=;
	b=dKHe7A8q9Xpwv+VQkBFatz9PfnUs9YrS8wWbAqbXIgDw8ZeyOEv0U19drTGgkSgLLojebV
	ch5WiFx5xevOhefB9+qkHqq/LYSNDiQ0Z/LOsPGbRkhzQZJHKdWm7Ail/45Yhfs/UmrhzD
	/lCEj/1JMrnGYdTG+3BIqqarJdXzszhIRT/YJy1zeW8fMbifHhAQ9FIUZjEEZXEgTB2msA
	KfHlQyW8DkERPX17sSa2jMGRQ9Zi2c9CdMVCB/aDkXmwESJMjBr72Wx1UFipIvZ8PZqCva
	ZmEpzWStAoEJli4UqSUhlXZYSydaTytDtDzcoyqMJHLg2W2xVe31NHpVGkFAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795085983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZmBVCO/E+M3LGN206IhnPbUYGaF035jqFVGv/CZR9E=;
	b=L0KBMMz7rb7mBp/ydrpatG2oqaEsYVIdolV19kZBorMrwtclV3h8h2ff9UhwRxDwIXooAd
	7nFxKpfXlava60tE2lmBDxLaAUvROT/lEUjLZUS0D6FnB2O7qjr5e7oJO8kOt8Hw90wSxR
	IeJXdNs4QHFU99mgblEKzfNJtuX9J2RBZZABuLK3pATVoIWDpJccNoUYmiyP5hmotoG9VJ
	hjq4bty9Flvg/YATQqjxdU4PothcT/5RgQrFJJXhgU24y4+0KlU6HhUIxaOXW+Eis01zzY
	+3HdZ3L0m6N2SPn2YNpVO3/Wnc0HmC8fAfxoM7IG/qkCva0rIUakhq2OzFaiBw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795085983; a=rsa-sha256;
	cv=none;
	b=Z7IqYLzL6AodbMdZCudDlRmnP8xJSry6QuSSGhBNZAGbGjVusyy/lk6fOQA+2ck4YOj/Bj
	AoNecKPbgmGdwFxqmvIRusyqRi3FozRiCC3+jdm4oJYAx3LuJ5QfgXWZCnVHtXoPq9d1aT
	uTZlQPfmbrngcrWI/pZpM1+dgQFsuejjKJYBulpW5ICCUD9FLkhjq6n4W4jkQTJfjSiIxg
	XVUGMhMvAmbPEo3LhiWKO9cjVzQcvsCk+lhYME0jzvlajf7JaCPpByafg1zJaNPMBtPjTI
	yw7KasOvVfjyat7iXlDWGNlX9CoiefrxNNnQbdkxb9dlGTZXwEiSXijp5AvpuA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Thu, 19 Nov 2026 11:59:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: carlos.song@oss.nxp.com
Cc: Frank.Li@nxp.com, broonie@kernel.org, linux-spi@vger.kernel.org, 
	imx@lists.linux.dev, Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH] spi: fsl-lpspi: expand FCR TWATER and RXWATER bit fields
 to 4 bits
Message-ID: <20261119-jumping-pompous-silkworm-a6e7df-mkl@pengutronix.de>
References: <20261119101539.2536367-1-carlos.song@oss.nxp.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w7lrfqvj3zly6jiv"
Content-Disposition: inline
In-Reply-To: <20261119101539.2536367-1-carlos.song@oss.nxp.com>


--w7lrfqvj3zly6jiv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] spi: fsl-lpspi: expand FCR TWATER and RXWATER bit fields
 to 4 bits
MIME-Version: 1.0

On 19.11.2026 18:15:39, carlos.song@oss.nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> The original FCR[TWATER|RXWATER] fields were defined as 3-bit values,
> limiting the FIFO watermark to values 0-7. This is sufficient for LPSPI
> instances with 8-word FIFOs (like i.MX93) where watermark =3D FIFO_SIZE/2.
>
> However, platforms like i.MX95 feature 16-word FIFOs requiring watermark
> values up to 8, which exceeds the 3-bit field capacity. Expands both
> TXWATER and RXWATER fields from 3 bits to 4 bits to support larger FIFO
> configurations across various IMX platforms while maintaining backward
> compatibility with existing 8-word FIFO implementations.
>
> Fixes: 732b903ea3e2 ("spi: spi-fsl-lpspi: fsl_lpspi_set_watermark(): use =
FIELD_PREP() to encode FIFO Control register")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

Maybe you can pick up the idea from:

| https://lore.kernel.org/all/20260319-spi-fsl-lpspi-cleanups-v2-3-02b56c5d=
44a8@pengutronix.de/

and mainline it too?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--w7lrfqvj3zly6jiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCav7WnQAKCRDMOmT6rpmt
0iOtAP96lbtWoS0f8szegRd9Db3yGX+sxGt4hk5qCpKotsaz4wEAh1BsGAVsljfN
Dt/bVCvNDsUdnWB31TAaa2LcPmUKqAc=
=PVp0
-----END PGP SIGNATURE-----

--w7lrfqvj3zly6jiv--
