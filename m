Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794596691;
	b=xckUGup4Ni1pgyknuGzKYD2STBmlxwfKUc1rhhJqYbbjmWeHxPuYh258MMUP7EfR3o5t
	 oAv47fDoS0CMUNo9a3oAjb3pxWNCxcuQplMZto9ReZHev06m5cFI19PZr6zGVeRMgFaT4
	 Lw4qT4YyVPEoExGLuC/kAZx0w41pvvijTQ2Hc1mN3bEw14mGRZT1gBI4ukzqiMcEHOD5T
	 F7KZCvxpZrAvEVBFxzyRO9U7+Clf93SyTN6uiCCLmeDpmvgnguql/7QPaL81bmwnHM6al
	 hbIE8KY4KjTNKRnItpFNTWpbmuhR8A4QLgKlrTHTEgLTFlGGtkV5ONYgW1Q7rjZ4Q8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596691;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=qtXRWZX8lyyUjDUIPQ2a+6/ACkXeGDBsZspX2iINCgA=;
	b=CuM3ZBAFFgf04F9+EGL+/vh4McrIcFRuLLiMJf2LVb5WRuvLA5jsOJhGw9zI8abfRyYT
	 LFt0kO0GDhyF0fSbooO8AyTWUUqsuyLa0pIn26nRGzYfdTeXrxVRVPSFdZXx42VAdO6fc
	 OiHaZIqa3BN5eC8W+2AlGx0T5sjYn2ZuzjMKMbR45wodag3w+daHvXPxGwLKN3XNouXzw
	 4CZVX3rIahMu5b0BSbtQs9hIPWbD2T9SXwTcwzchWYEeeSDcc5t5gVQQfHpSrotpLR7kG
	 MNsExnzIho53wOLKflvJz7knneGb9k/4dhGu+7jt3mJBkdZ2AEnpYX3OJltEJRtfn4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=QzIvBgdd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA62606A32E
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 19:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DA62606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=QzIvBgdd
ARC-Seal: i=1; a=rsa-sha256; t=1794596673; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LiRpgm1CauBflaOZwu/xXvDklze2ptyVaSygIeLvrFJAq6glWLqzwkYTbG9vhxsKSvkO/frJKcG0bx7ZrbeGD7bo3pzSntrOmzAQ5/59jTACROROHWhy+W9TBh4CQeR3ZSE+p+ibrcr5D1GeYvjrwIXCQxCPWt2soU18b4hz8yk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794596673; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qtXRWZX8lyyUjDUIPQ2a+6/ACkXeGDBsZspX2iINCgA=; 
	b=nl9kpIEy78p9NEYSa80+HxRL6PUCPbA8QS/DUzlv8xSOlKcDopyAc0BcSvyEm4QCFf13NI2KKb0GDjGxz5j4nvozhCvAWvLGe15f+Vt2a8WzvPEAJGKRF27dQQrXcA/9qCFPdk0CC/F/f1yDH/OUyn+iNtlNQsEBPVFbCWY0Z4A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=QzIvBgddWuS6SrqUXrHqdqu6eG5mcK1OiWNvVcuHVyV/8uF6TG1Ek1hecXLfQOwPO1jokoxSEeIrZFLqlY2ynwumTESc6PusEYcCoujmaN6qkReLM1aCfo5iW7RjqFM6zj1wO7MGfcnVQIXbCAmCA8lmfq4T0bYUronxgwlfvH4=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=qtXRWZX8lyyUjDUIPQ2a+6/ACkXeGDBsZspX2iINCgA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794596671066492.48212326178293;
	Fri, 13 Nov 2026 11:04:31 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 6638318040C; Fri, 13 Nov 2026 20:04:27 +0100 (CET)
Date: Fri, 13 Nov 2026 20:04:27 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, quentin.schulz@cherry.de, 
	Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 6/6] spi: rockchip: Add an atomic transfer function
Message-ID: <avddeGqlBywKn53D@venus>
References: <20261113135017.1047959-1-heiko@sntech.de>
 <20261113135017.1047959-7-heiko@sntech.de>
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
	protocol="application/pgp-signature"; boundary="p4xnodbjf6ofm7xh"
Content-Disposition: inline
In-Reply-To: <20261113135017.1047959-7-heiko@sntech.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.590.96
X-ZohoMailClient: External


--p4xnodbjf6ofm7xh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/6] spi: rockchip: Add an atomic transfer function
MIME-Version: 1.0

Hi,

On Fri, Nov 13, 2026 at 02:50:17PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>=20
> Rockchip SPI controllers are often used to handle SPI connected PMICs that
> also handle system power-off events, like the RK806.
>=20
> When the kernel signals the power-off, all the interrupts are already
> disabled, so regular SPI with its mutexes and DMA transfers does not
> work anymore.
>=20
> Implement an atomic transfer function that does SPI transfers polling the
> controller in a loop without any DMA or IRQ.
>=20
> This can successfully handle the power-off command to RK806, but also
> read back the 2 chip-id registers just fine before that, as a test.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
> [...]
> +static int rockchip_spi_transfer_atomic(struct spi_device *spi, struct s=
pi_message *msg)
> +{
> +	struct spi_controller *ctlr =3D spi->controller;
> +	struct rockchip_spi *rs =3D spi_controller_get_devdata(ctlr);
> +	struct spi_transfer *xfer;
> +	int ret =3D 0;
> +
> +	spi_set_cs(spi, true, false);

I think it's sensible to avoid SErrors in case something went wrong
with the preparation:

if (!pm_runtime_active(rs->dev)) {
    dev_err(rs->dev, "Failed to do atomic SPI transfer due to runtime suspe=
nd\n");
    ret =3D -EIO;
    goto out;
}

> +
> +	/* make sure all interrupts are masked and status cleared */
> +	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
> +	writel_relaxed(0xffffffff, rs->regs + ROCKCHIP_SPI_ICR);
>
> [...]

Greetings,=20

-- Sebastian

--p4xnodbjf6ofm7xh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr3XzAACgkQ2O7X88g7
+pqr1hAAm0ee/gMQJyENpJ51cAGCGYlcvGb5uhlcnCQO7cZUgNbg8dH/LNlGSecx
ShFkrb4mOhElluGZ4ux/ZR0AthXbo/UHCjkn4U0+AfYIJyEEl5D5gj3BSRtoRfwV
RbI6cott2k4EK77FnlnfqW4ImcSG8aMynnl6oJznDd1QZ7xSvUHuAmEoBXIr+HSB
LuWp2ofCdbf5Sh/RPJ55zlYZw3ybQKt+kHOqR6Sa50uBRoL4e+uwVpCpNS7YvDoG
PND7G0riiU0Ux3G7RG9YqN5VePSTK55+NPBZO8fMR/aUeqxJhZvniVpRm/V0XWz6
nsZl2Qk27zi/0p3WIGgpabyMUtRdUcrQTIUkHw/8z2DA7cbqK4RNmE7QY+jotUho
SKdrdMnREHBRQbWQwTvqIS7eB4q+xM/T5LlMUUya+kNE3YHpPflwXq5lLr9Ti58x
NwWnwoFOj93xqhjZbzmZXCuozkmNBn+HH1w8R2lu6jXxfBfPv2udmP6/L9ZwDM6P
k/vVQCULbpXFQHXVMyo5y0JPz7LRgHtKvUFdgHUH8qdtwh8Gf/hQ6yHJLQhcqxIB
wQzs4kNZdtG2WFvNnFqZ8UoCaYQDXnipIUtD+8045hNz60p4n0eFGw5Wc63ZroiW
Fl1xW5kPhuM7X4RS5K1LFXPxe9VBjB8oU6sNDVmGHz8utu8avpM=
=2Pc0
-----END PGP SIGNATURE-----

--p4xnodbjf6ofm7xh--
