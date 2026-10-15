Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6C2116F4;
	Thu, 15 Oct 2026 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066265; cv=none; b=snn+bg2/7x30Ep0NtPKFYO4mT4rI2LoOxEeQeRDwm+CDdeb7cZ3hDIVgk9artIsFGmND0Ny8FBt/fBGm+7KLYE8EEOoBVUK6n/dx3kNTWDpH9velra89EsqZocCpn4DvzcfqY3JQ+IDFE+BTVtXYnhROiSZU40VFX3vqRL6n6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066265; c=relaxed/simple;
	bh=xPEBbowCt3IaHzqS44ong/lLBmm4mdsMq7qJtNS2/rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euZe/SB94rEgUbxEfGfMcGwx+izh2K2DwDUBIIhqeHcDJSID3b/M5ZLnRXgmLT+MS5dSFrLQB+aVBiaXUb3YZpfQYUx2n6tgL9VpDxld9CzWbysrCWSTBpOMEH3hFWoXBbpXV96c+F7TfSteJRchPUo+6PsN/UCEEKflZPCs3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLXo5pne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLXo5pne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03E01F000C4;
	Thu, 15 Oct 2026 12:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792066264;
	bh=1woIpcqPxRIa5ueRrQVCv21ZA8veGBbKfrPvaOAzZZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GLXo5pne5wuStSnH/uiHY8Akr6i0ZPVSAby8JmSwNmcaxRCi9t9F+Zxq16CHBS3g1
	 bpI1ILFaj01BjrMLIXo3D05N4PIMMRcS7aGJ/QMSYzPFQ9l3kPD332inF96eYsmW/H
	 LfEIdMbmu02rNXYD5xR1C6L35s7OVygHczqDktD5C8YN+dABhwC1Bptm1x3VUHO6Ab
	 FwVFEg6zdZffvkwQ2fpS7+SaDx4pjOe1okCgVqiKxq45Rro2cszAGptt4uFYu6568/
	 G3LZcFu79u+oTmZ6OrJTQnPIi9jLBizJiO7tloy5iFV/LyZNWRpES1w4iAX9SqRtI+
	 9M8qmq1tXvNMg==
Date: Thu, 15 Oct 2026 13:10:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [PATCH v3 2/7] mtd: spi-nor: Wait for NOR ready with
 poll_timeout_us()
Message-ID: <2feb1fd3-bf16-4351-af81-6147864b75e3@sirena.org.uk>
References: <20261014154301.157755-1-paul.cercueil@bootlin.com>
 <20261014154301.157755-3-paul.cercueil@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b6iKUdWCnCdvOrdz"
Content-Disposition: inline
In-Reply-To: <20261014154301.157755-3-paul.cercueil@bootlin.com>
X-Cookie: Tax and title extra.


--b6iKUdWCnCdvOrdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2026 at 05:42:56PM +0200, Paul Cercueil wrote:
> @@ -711,30 +712,21 @@ static int spi_nor_ready(struct spi_nor *nor)
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
> -						unsigned long timeout_jiffies)
> +static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor, u64 timeout_ms)
>  {

The parameter is renamed but the kerneldoc isn't updated to reflect
that.

--b6iKUdWCnCdvOrdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrQwtEACgkQJNaLcl1U
h9CuoAf/Tw7pRrSYO/PSfTPC4gBHGycF8EA91WDNbutq+Q2TSbutlzP1sUX0S2/4
PRYrTXV1xpmNQAczcTJZo+PtT1TH+UNOfZAVP2dffjMA/G5a5rPXbsNE1oGygcQF
0GbSAMUp+B7N4arGpwp2y8vB2sb8YMDW7XqlCHThgXPVO9vhBkhmPFLm2200pHoS
PplpwDU+iGzIwSHrqlLYItqbJT4/fVdTVvOerR3dt3IigS7lu4N43SScNL/cpAGN
N9Bwc3SBZyis4duDNxXNOY1Aw72/Um35L6FX50gVF0pmpEvuYPbAzfpV/3M28cb9
eD1vIT+p6gP4CDjVOmCsASFD5d5u3w==
=bIpx
-----END PGP SIGNATURE-----

--b6iKUdWCnCdvOrdz--
