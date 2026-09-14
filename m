Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62F3C1F54;
	Mon, 14 Sep 2026 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409061; cv=none; b=RCi235+t0lGvhzPVaAogFqPvAD0Togy7xhyBNp5p6csGDJStwMkJOYcfW/tvZDI3ygCLNALUbrTbsM512vGfet4ulAY9vLm58rB0FZSS0J4bfUb0K1zev9R1/JGzhPE8imeaBRoQT2NAIm2PWlLaia7h7NdIvsYF2I3BaTgy3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409061; c=relaxed/simple;
	bh=e5EHZnJEudxj23KEVU051RrBry6GEJZlmkFjnDSbDJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC3a9ousza/DVv96OAjdCR6UvpTU9ECMuR88NqeUIhQUoC5bMnIFx2JnEmgq8xbaboSd2PLu1FIUiIV67v6kicvnaS5hVL2v4CI1EUIxDYC2lBoLc8kTyUOy1GaxrCnx0asi/Pp51XOqGCW4m98ktgIJSSdDLK5PSgZ+tx9QmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7RWN5DC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7RWN5DC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438FE1F000FF;
	Mon, 14 Sep 2026 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409060;
	bh=L3yt4SH6FG/aYpnjHKzd41eoZ6vWH95ac12xmt22LQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K7RWN5DCmCyzzkwIfh9nwocBt9pqrIFS6cMZ0ZaeITLYBO5wQRV+1Nq3Izz6ljzwd
	 SD6m/r8vwBoJpg3T/Af+PY8k0mP92XmDooTDNOaNH0OPxnFegBMElDs3n+/Z3dJRfT
	 jn/z8csddG/68TG1ZgHDQzc6QfLz/SS19klKUGHVoZQr9Uyro4Rfd2kNdxjMQ3TBD/
	 9I0imjB8lcXRg6b0ErTHTuaFjX/GPS2qCsT+70XNRpGo/S0aBPDIlhCAPxDY+XHLdb
	 vqWnAVeEP9niUD3JDz4R55d7TGQBGpA2zt+Eu9IWeG6GByhog/vkT6MWd5kWBJlLpE
	 DQHGDxDJTooiw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id C0FA8FDA61E; Mon, 14 Sep 2026 19:04:04 +0100 (BST)
Date: Mon, 14 Sep 2026 19:04:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH 6/7] spi: spidev_test: add option to split message into
 multiple transfers
Message-ID: <aqg3FFSZDLe_WI9Q@sirena.org.uk>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
 <20260914-spi-sun4i-spidev_test-v1-6-72d6a3b38cee@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mhc4C4tSAt/lUq8E"
Content-Disposition: inline
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-6-72d6a3b38cee@pengutronix.de>
X-Cookie: Orders subject to approval.


--mhc4C4tSAt/lUq8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2026 at 04:50:45PM +0200, Jonas Rebmann wrote:

> SPI_IOC_MESSAGE() submits a single SPI message containing one or more
> transfers. Introduce an option to allow splitting the message into
> multiple transfers.

> +	size_t bytes_per_word = DIV_ROUND_UP(bits, 8);
> +	int effective_transfers = min_t(int, transfers, DIV_ROUND_UP(len, bytes_per_word));

We divide by this and nothing stops us triggering a divide by 0.

> +	struct spi_ioc_transfer tr[effective_transfers];

This could easily get very big if someone decides to test lots of small
transfers, it's probably worth moving off the stack at this point.

> +	size_t len_per_transfer = ALIGN(DIV_ROUND_UP(len, effective_transfers), bytes_per_word);

The kernel's ALIGN() macro only works for powers of two.

--mhc4C4tSAt/lUq8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqoNxMACgkQJNaLcl1U
h9Auvgf/WJ8s/5tRNU0WphxKl6Mh8DpRPKc55J6F1m5hdThSFVVO+wh8A0VPZIUb
SP8aBcX9OIaShk9JmsXmpKl5vCKMFMIXg967yQmfg7/h/dKLDS7Wd2QLM3JzfmFB
8qzPFHr0juGhEGTmvsOQ/Ignky46E9qYOsq41sHdT9qmMgj8zrU/LLzzxHYsC3BG
PdeznFFwN3IwIaMlNQZbDhrJxkkfWDtTtp+WIRrg8KnX3aDVL5/c6w1IsTpTLUhG
WmeHVhoEF7dn6nI25JbtsXpvpXVwuyhebBt9wqM90TWRLMjaYCUVUJ/ASP62ENP1
S2Gb2o6pIa6JIoguAFnfme5mLzG2KQ==
=tS+k
-----END PGP SIGNATURE-----

--mhc4C4tSAt/lUq8E--
