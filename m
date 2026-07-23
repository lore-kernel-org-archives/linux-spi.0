Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418C25F984;
	Thu, 23 Jul 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816492; cv=none; b=oG7zyeyNyIPsA/L3hDITvVizzLuCo/D28sSi/e1s1Ha3wFwLzhF1IGF+qoap1czkgdmJgtURoM5GNfaQzRyh1DONKB4w1kbbMrGKSRpVRwJZ0/Wwm7beng5bpUYZZtMGR33UgmLa+DR5NqZf0cYVnliGZtdM/Ao3s4Xzzv3pQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816492; c=relaxed/simple;
	bh=L5xBPCkP8R8WGWQFmNw1G3BmcfHsJSsxFMQumnfQ9nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyIE39wfosJEsrlEZ38REefYoOoPScPwrJqy0Zva0RHyalIN6mu5QqnP41FtcVMtLfv33279nPSd1bVL1Eb+Wzf1zo0u9VuKqVBYeAmwRwFU4sWZ3YRRiz+ZiV8eV24ZDRvh5jwKNpA67Lh3OrMX9NCt+iy1BnPAXwMkVCOhOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8QdiKPK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8QdiKPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258431F000E9;
	Thu, 23 Jul 2026 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784816491;
	bh=rA0O4ClmUVEoh3f94Y+vEhegRimMiCmv23Q9yV4+wRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M8QdiKPKfruE5fG2RaIwODjw+vgzXq2cH/x6I+b/3itmT9HeryfA90xu4Kg5h4Vmh
	 P89TfBY0fRsg4qwOYh83utM7xE6SvZSV+vp7Z52ZkefW5k2nbcO3I+cchvRyt7+jak
	 ium1U2QO9a/IXO4HEWCFOlgggKZjHf9toTKBUMeW9ADzMWhhJrtycpjRJqUY1Iyw2N
	 S/uExPb1dsnq6LQ1G/xEEo0Ywec9fRrzRPq9wS0SUtZL3lsAUuGi+mvrysqq/CR8Jv
	 efzOiz0ygSBuvlm7Xrf46pEynF1T1yHC892P3QmVWR/ayNSI8441jzHol7wTZsr7EN
	 vZ9hBnzWZguNw==
Date: Thu, 23 Jul 2026 15:21:25 +0100
From: Mark Brown <broonie@kernel.org>
To: han.xu@oss.nxp.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH v3 2/3] spi: nxp-xspi: Improve AHB read performance with
 DMA
Message-ID: <5a437693-21a5-4a32-aa17-a1e36fe564d0@sirena.org.uk>
References: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
 <20260722-xspi_dma_upstream-v3-2-6b7ff50cae8e@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Jg1gxkaRhzjWA0C"
Content-Disposition: inline
In-Reply-To: <20260722-xspi_dma_upstream-v3-2-6b7ff50cae8e@nxp.com>
X-Cookie: (null cookie


--9Jg1gxkaRhzjWA0C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 22, 2026 at 05:00:43PM -0500, han.xu@oss.nxp.com wrote:

> +	timeout = wait_for_completion_timeout(&xspi->dma_rx_c, NXP_XSPI_DMA_TOUT);
> +	if (!timeout) {

I'll apply this since the issues are getting a bit theoretical but a
fixed timeout will have scaling issues - you can configure a very large
transfer on a slow bus (eg, 1M at 1MHz) and have a bad time.  I'm not
sure that would be a good idea in the first place.

--9Jg1gxkaRhzjWA0C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpiI2QACgkQJNaLcl1U
h9ALoQf/eRd5XC9B+m+uk8SVMqVagA9x4UsMBkV4SrRH2mY37diQ5bpB9cr79tFi
wjf794ZOWhcmtsQQZgv2DEtj4wq3WJbRQ32NsvLc+eFp8I/MX+Ljp2C83ajdZ1yG
KIpsaBYlCzBxDlz8Ykzf3002eqavi9rpzUvdMLok/J1S3HX8O0Ovvb94L6IR19No
Z+GqxtJFnURhgx/2IkD3HnT/ZE30O5BcLLhEtiBfRT+D3frfWEG9Ezem0ud/V5yx
TlR0F+Rw7kUs5SlVnR64uQ55C1v/MLzb6zr3gSjE761Yz+D0v5LOHWITDb+22yf0
IVDAmUGHDZw1d0kuWZ4EBaDz8HhzYg==
=DILC
-----END PGP SIGNATURE-----

--9Jg1gxkaRhzjWA0C--
