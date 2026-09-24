Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4EE4AF9E9;
	Thu, 24 Sep 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266374; cv=none; b=HXd7tNghR3Jf6AQ2jSAJTcvx4oR83Z7aB3hcQLUG3hLWEgYjqUZZUw06ZTO32zblZGVWqmyz/p8gmLFJmZCXXUCcQlm2YtkkZyfMHFQ07DnuqNZCzFyXD6Cr9ZnYi5aMmBn6k+M42ruMaUIAc4462Ig8EBy1qGaBWrV69VQKYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266374; c=relaxed/simple;
	bh=b2PqtK759tahLYQVFM2aQ2BL1FXq11TOg2iTXnd5hys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrtGdG4q7VIIARXhAXsg6JsejIxws4mvX1qbFDt17vhr5YJX5YlgS2T8qKaooO6nv1d2+UzrVndrOnfba95+eXo7SFBKa7KjqzEG9+DTmumiLkL3YzxX7h2NzeLFUn+kRZrrttxsqv4aAIvTmtYX9ECFRp0ekX4kGMqKvqu7BrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1sv50L2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1sv50L2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF341F00893;
	Thu, 24 Sep 2026 16:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266368;
	bh=KdKXqQhPo9qVulHmU2Yll0NxU6DbM6lCKm2r6akP/bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a1sv50L25FrmlrNjcSmzH8HIQVlBbj53dI4UIlrJ/kFqYv2zX2m/OUF7+zqg5AhZD
	 i8+Nvor4SoWL7EOFxIqio/NwshCBm5XM2VkrnD51vqhE53VI/PdXWEbMyO08fMIWvt
	 En4DH+G17tTrbaURxppsC5XgZbJZtUVvhxBLTqQBzzkCPL/Hv0af+DDQ+HcE2Mw7Wv
	 SzDF/5G8DDct1X8ICxmqKvrLiC+XOP2b6Kc7DMujg/ppmmUEzb5vQyQ/8Vy/wxvwF3
	 lXtkpDNBKi8KvXiu8meKMHLcpZpmY+23zabalnSQhhYWi2nTxiS7nFfAwJ7oRguBsW
	 eG/4tXwAH3szA==
Date: Thu, 24 Sep 2026 17:12:43 +0100
From: Mark Brown <broonie@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] spi: use dmaengine_get_dma_device() for DMA mapping
Message-ID: <fb9f84f1-15cc-44d5-93bc-dd19e6ab9690@sirena.org.uk>
References: <20260916-spi-dma-v1-1-2b30657d373d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vkjKJ3QQ54W6Njyk"
Content-Disposition: inline
In-Reply-To: <20260916-spi-dma-v1-1-2b30657d373d@nxp.com>
X-Cookie: Oh, so there you are!


--vkjKJ3QQ54W6Njyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:30:55PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Replace chan->device->dev with dmaengine_get_dma_device(chan) in the
> SPI core (spi.c) and SPI mem (spi-mem.c) DMA mapping helpers so that
> DMA mapping goes through the correct device when the DMA controller
> has per-channel IOMMU domains (chan_dma_dev=3Dtrue).

> @@ -46,9 +46,9 @@ int spi_controller_dma_map_mem_op_data(struct spi_contr=
oller *ctlr,
>  		return -EINVAL;
> =20
>  	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT && ctlr->dma_tx)
> -		dmadev =3D ctlr->dma_tx->device->dev;
> +		dmadev =3D dmaengine_get_dma_device(ctlr->dma_tx);
>  	else if (op->data.dir =3D=3D SPI_MEM_DATA_IN && ctlr->dma_rx)
> -		dmadev =3D ctlr->dma_rx->device->dev;
> +		dmadev =3D dmaengine_get_dma_device(ctlr->dma_rx);
>  	else
>  		dmadev =3D ctlr->dev.parent;
> =20

At least OMAP McSPI has different DMA channels per chip select for some
reason, that's broken either way though I think.

--vkjKJ3QQ54W6Njyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1S/sACgkQJNaLcl1U
h9Bnqwf8CxblLS9PaTmkzuS08hSXgICwi3yTPgrnu/uT09FCf3qYxGBP0TlG8v+e
yB6ZeZ3L26asRgLPVVBcTZC1Ul7ayc02Euz/pVx+yXx6A88LsF9XY+EsZ0UMBw1F
0rtM+KElBEQsO6Rrhmg9rP3WsWAlKbSQKRePV538z9t0prrT5xZL5B4xqb7umLpG
bI9DjdRtiMyM1yOpkp5OYcUyaSSW1u+4VqjEbzRsBd2C1L49/r4NurtBD9cqydPR
KW1XIeg7/XRBdYVHHk2laC6mmHZKBeRVvp0xi7e9K1NCJUE3DwWz9+NMItPGPhzr
PFvbhaLhm7LbnMH8CSf8InxqllHepA==
=XT9e
-----END PGP SIGNATURE-----

--vkjKJ3QQ54W6Njyk--
