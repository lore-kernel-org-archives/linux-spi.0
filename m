Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97342C11E9;
	Mon, 16 Mar 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671947; cv=none; b=I/ELnBuRrx2DabUQUUwWxhhVFffI71I6/DJmdY/TeiGxOi0hDmyL9L5CE3m3k8u/FqCnAjuAVsN8QQePgMcLn38RZTgeHAV9h9f6fjSz6kd97l5l09WklN+4ZW6/xBtjk4HEOm6Ud6hnKVIEJTzh/TkndYt/NEu7EUpQAZkMS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671947; c=relaxed/simple;
	bh=O6Vv1Y/ilr2DB0Dw913U6D3rlQM3SHtb+Ci1FW+MTV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6uZ7R7zddPy4FoGQ1p1pRQh39TfrM6XVabgYb0udrqljaCiHeUebkdrMFd17E/nJr0/21+IAIsRsQMpKWgOx0H/CedcR2dulqNyOXjdThp9dBpASxWIMWLCFgqZQb18OfpFReaXkTRDLzCCimsaQL6Me6ARccLaj4i8FDzeZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QK2lK3fp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QK2lK3fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AF3C19421;
	Mon, 16 Mar 2026 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773671947;
	bh=O6Vv1Y/ilr2DB0Dw913U6D3rlQM3SHtb+Ci1FW+MTV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QK2lK3fpDyhxLm+3dKfM70cf3DprbKSwXEnNXVnWRhOxXKDgnGF5DzFFnQ1VTuTa9
	 xJSGgI8dMk2aPfmASN9j+5gCz+XjiLYnvGWnmDhCncwx8/WOCYubPijaCKF6ykgexf
	 CJC5U9wqIG1+3ah6O/+fEGtT9M1IqtfRuXzzQMtb5Hw9EBeaDWky5UBRyRuRY9J5dB
	 JodXbqu11xlLPo0nAzZOVkyug07nGrBR4A2mHCyBHIP/12294djMh8DDJ/KkCytAOx
	 EC+AXGbat+dZ2pSRZVzhQNXPQQqTrJEm3rvJMMipv98hvqxvxC+EYiK8uzZtrXjslx
	 D0Stt2KNbO+ew==
Date: Mon, 16 Mar 2026 14:39:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH spi-next 04/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
Message-ID: <e4c711c1-5229-4685-aadf-f88aca9fbd3d@sirena.org.uk>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
 <20260316-spi-fsl-lpspi-cleanups-v1-4-1b695607702d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qw7mWSaiamtuB4oj"
Content-Disposition: inline
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-4-1b695607702d@pengutronix.de>
X-Cookie: Not a flying toy.


--Qw7mWSaiamtuB4oj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2026 at 09:39:05AM +0100, Marc Kleine-Budde wrote:

> +#define FCR_RXWATER	GENMASK(18, 16)
> +#define FCR_TXWATER	GENMASK(2, 0)

The source of the watermark values appears to be

	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);

which suggests 4 bits of watermark not 3?  Or at least that something
isn't joined up somewhere.

--Qw7mWSaiamtuB4oj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm4FgYACgkQJNaLcl1U
h9BvKAf/aXYN1HiqbPUpZ/Ju98fBbIDNMxKhogZU855O+yv/78ICBQwUuhPT1vrY
PPqvjbLzbIuk4ul1DB/QFcq/jcdNbE7vVQyCGJWjr1Ge30SENWRAxn1SjjonVdCk
4E0rM1bmaaSswjeXgfLPBLI/PkOLGUFwcDKmXn50J4DTcenTYWFGFXg1MzwTeeoV
Gf1mrzGhUyf+WYBtlY/cI3TQgePetSWioHT58GmILO5Y9kpafDWWy9C9IEpps8YU
m89lJlJzH5asLc5HrTq5i050nZY8titjxlzDk25WkYIN7T3i3zAjl4QTtb2yLCXr
gtbyM1R9PBDCqfvBQpY60oday+Je7w==
=kgcc
-----END PGP SIGNATURE-----

--Qw7mWSaiamtuB4oj--
