Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75444E67E;
	Wed, 30 Sep 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785746; cv=none; b=Y7GWgA/gkwSnZ5SYvIbSNGGn2PPABv08D18FSc19kUDpkgDC+WJWNNE+mFy76pCosRZgdlsKv7FA4rwZxBKoK0JB5XaQFmPQ4oiRbAZ09hDplBAtgxIyvFUzuAN3l70LpQgrRDjJovrJJCrsDp+Gg8QLSb3eN8DDz2CMzl/DQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785746; c=relaxed/simple;
	bh=7dPOwcn08xKftLDiabiUL5TvBC+ChKAXXf3g7J4S1vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtKU/J/G2j8rSFC/4Cpyc9T2ByCK5qdV5B963KZu65ynXsxRJdBtvRffTdklZiZ+Pg7WdCBjxIHeHZQBFben09ZKlOc//1IVP9g6BwkuKn8XOn3u1lApm1DyivTYGFIA5vmM/a3AjuIlvH1oekykVhjXBfoObASLr6dmWjtHHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6U42VbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6U42VbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822B21F00893;
	Wed, 30 Sep 2026 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790785744;
	bh=tJxxP9Mz08omtl33BnTGCPIgimt+h93qx9sFDqGs2lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k6U42VbGraokNxUOhSkS4gX5vXFSCDJILoH8/dMkod28LL7e3+4fVnpPqfiVcpWST
	 mMSFpPKEVxLg+QeefBt84uDQn8PUHND666AhDCFMckYdXYNYeI/pyydVm1ri+ZGuL6
	 ad1w1rSDgnKnfDkat51n1hY6J2MexUFw183ARPWWw8plt3Li0e07N6pkgWXAnqfsSb
	 v/k2Jl6dzsYZ4NNmjCGEV6dmZ0McRfE91nrJt3Wa9DRwZe6qpmFzdiqQ90d6ip00AA
	 2gucWkRtsgjmw94hvomW7cuGuLrbCnnFsPhZ8sBJAGYkK6Yt0SIdPFGUCn9URA8MKy
	 VWNdXHIqGbBrQ==
Date: Wed, 30 Sep 2026 17:29:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] spi: dw: Add DMA support for enhanced memory
 operations
Message-ID: <90a93f76-049a-4200-9626-7c3f4e934f45@sirena.org.uk>
References: <20260930071535.7947-1-changhuang.liang@starfivetech.com>
 <20260930071535.7947-4-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8bVQLXZkJ1Ogvdo3"
Content-Disposition: inline
In-Reply-To: <20260930071535.7947-4-changhuang.liang@starfivetech.com>
X-Cookie: (null cookie


--8bVQLXZkJ1Ogvdo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2026 at 12:15:35AM -0700, Changhuang Liang wrote:

> Implement DMA support for enhanced SPI memory operations. These
> operations are half-duplex, so they work with either one or two DMA
> channels.

> +static void dw_spi_enh_mem_dma_stop(struct dw_spi *dws)
> +{
> +	if (dws->tx_dir) {
> +		if (test_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy)) {
> +			dmaengine_terminate_sync(dws->txchan);
> +			clear_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy);
> +		}
> +	} else {
> +		if (test_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy)) {
> +			dmaengine_terminate_sync(dws->rxchan);
> +			clear_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy);
> +		}
> +	}
> +}

It would probably be safer to unconditionally stop the DMA and clear the
busy bit, we're only doing this in error cases so we shouldn't rely on
everything being in a joined up state.  Equally, I see the same pattern
in the existing code so if we're going to fix it we could fix both at
once.

--8bVQLXZkJ1Ogvdo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq9OMsACgkQJNaLcl1U
h9Dc5Qf9FoEwIGKBh/svxPs91ooCPAFQTLkbh6CfKWNtfDaLcTiPGlhoE+LxSClZ
XUVLtpeC3ELfbOgU4wGAG1aDxGGL4C/a4sdXSgzVbhRBGD3xTqjMja0RjrB3TzP7
PSbT3Wh/FfStflA9msLLfMtyUzfZatZUmcFG0ULarXsIi9dzGZM0xll4PCt913dv
HsYaxOe1XxEEaAw0gaHGmQSM5bd6K0fDSSvZRjCf4qDs2zkgJwDaycRQGIWOmvoc
OnSO7UKwQFf/3AML0291ueWvw//deQsWhtXYmQlkBGL62q+7/WuPPTMsR3kj/2kF
+GdcqgeBZTbHglMov29rORY+ZmXgjw==
=4aJB
-----END PGP SIGNATURE-----

--8bVQLXZkJ1Ogvdo3--
