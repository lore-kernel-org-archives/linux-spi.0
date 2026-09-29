Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F44E3236;
	Tue, 29 Sep 2026 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718252; cv=none; b=CqUZWMFazv0YBHANXsa1q/Ip7zqui7zkukiSTEpM9wiYqKKkc6gO9xgQX1KEJk1CmrAS7YWLv6sYQqDRf8uCXqhbvOu5e8L04BgpcGCholhRyw5J7/f7+HgA9DggpIiWRj36Iczhl/uxK6GLG6o96MuIBo8hVXZHiz5CI1qSLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718252; c=relaxed/simple;
	bh=PXjKLtYo3w8BNPEfuBgSC85hd0B07fniJvvus+kauY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtZ7lQu3/3iEjyGuDODEUarbJB21eL8Lp78sdBRtT8bouGpjkaqNMAU4DRMhLoWkdcG/PcszzYrFEbB/4Y60G26Xr2G6tm2F6lcpewgYumtJwCT3emGa35E+PlWpQLSid2ltK1tlgeYn0d9IyTZzSg+Cn+v0Oaj6nbv/wvdrQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI9qf0yY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI9qf0yY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412391F00893;
	Tue, 29 Sep 2026 21:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790718241;
	bh=2KEhu3d6YlE+Nz+gmiCdg+VCYUQv+IGjS0LzMmdH5hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CI9qf0yYXGBU6Acr89YrQCW2sfMzQPY5FRReCxQ6HiZpV0Is0a7X0YskUC6BzoAZR
	 73iAv/If+qQ/na/F0HbvLGU8KHAVP/W6qhjiPVRrgL2vta2SaztgmKk6jiQnZJWPo1
	 SKYh/RI3cebBr0iu1ObM/SDFCQU+T/gCK5HiavC3AAvBNWVI/+5SZHAk6OW9jUA4SG
	 rovd+fCbD8cafHQpx81eQQaS0CbFQsX0LwGd9XxvJcngQbvxcHoKJ/TlW72GL0IHVe
	 5ncObZntWs/frWOLdn5GX096bC/ZK341dhC40QgS5PVU0s/z8PKzH0uyG15mDQCXSc
	 ib/H/Gw9SAt/A==
Date: Tue, 29 Sep 2026 22:43:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>, Linus Walleij <linusw@kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE DSPI DRIVER" <imx@lists.linux.dev>,
	vkoul@kernel.org
Subject: Re: [PATCH 2/2] spi: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <a9a4fc5a-df79-47f7-b963-217439e0b020@sirena.org.uk>
References: <20260929155445.3311133-1-Frank.Li@oss.nxp.com>
 <20260929155445.3311133-2-Frank.Li@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vrrxCsum5yX0Juyp"
Content-Disposition: inline
In-Reply-To: <20260929155445.3311133-2-Frank.Li@oss.nxp.com>
X-Cookie: 1 bulls, 3 cows.


--vrrxCsum5yX0Juyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 11:54:43AM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace direct dma_chan::device::dev access with the proper
> dmaengine_get_dma_device() for consumer API

> @@ -1174,16 +1177,15 @@ static int bcm2835_spi_setup_dma(struct spi_contr=
oller *ctlr,
>  				 struct bcm2835_spi *bs,
>  				 struct bcm2835_spidev *target)
>  {
> +	struct device *rx_dev =3D dmaengine_get_dma_device(ctlr->dma_rx);
>  	int ret;
> =20
>  	if (!ctlr->dma_rx)
>  		return 0;
> =20

This moves the use of dma_rx after the NULL check.  Possibly
dmaengine_get_dma_device() will do the right thing but still there's
more updates needed.

> @@ -766,21 +769,21 @@ static int dspi_request_dma(struct fsl_dspi *dspi, =
phys_addr_t phy_addr)
>  static void dspi_release_dma(struct fsl_dspi *dspi)
>  {
>  	struct fsl_dspi_dma *dma =3D dspi->dma;
> +	struct device *tx_dev =3D dmaengine_get_dma_device(dma->chan_tx);
> +	struct device *rx_dev =3D dmaengine_get_dma_device(dma->chan_rx);
> =20
>  	if (!dma)
>  		return;

Similar issue here, though things are a bit more involved.

--vrrxCsum5yX0Juyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq8MRoACgkQJNaLcl1U
h9Cfqgf/XWp6benseGwKwZKeuaOsw1cBguwAfqDmvyDi7aHwm11SxEjrkzcrIm2x
P0g7TifMKYaCXW5j0wZEdS4bDoMzROZoh7TSc8fuWGvL9ATJqgcR/rfCjuqM46no
wO84cvU5xrXc8rK0mG99NXFqmWZE8dYzKMnTwC1aMyid3OVl/aY62R/lwHY/ouOq
jJ5Yr7oCUxSHvpe6U2BpfaP6uAbN+KFFnCBeziNzgNgGTFvf+GnamKxlF+RwgyU5
QgtaYx99v37Jkl7Ecu6F8xV4vsyPMffWhQLn5vL9BovFT/mQ9i7ol5bbNMj/SiV0
Ede1lApphqMCEsoAVYigi0mIUpfoGA==
=Qy7q
-----END PGP SIGNATURE-----

--vrrxCsum5yX0Juyp--
