Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE494963C3;
	Mon, 14 Sep 2026 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406439; cv=none; b=SD7H5LwImuL4/9XaN41FGB2AAclSy4+4Q6oj0N7SlvjSq/d34hCReBk/T2/8AHvCglyabEarktfaVZEMviAd/QOEVpqdaYaYBBDFgXB3R9YWA4ENUCfUscAFFH88nvn5jrJkAmYXo0usxrKkd5aK+glHAwZgUF/sECj0sd8JLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406439; c=relaxed/simple;
	bh=9xwrz5yZXw4lViweMwSmwa/SnJxp3k80Yh/ohFT88Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ2ylWJ68+3QsFWsqCQOG7/gHpLlO0o/d8Kc9nuuo4f2cjnaJFWWDboQjMtv0qLJx9mBtKX0fAreE/37f+4Rb0zvIEUWTiEN1zGKYXuKIH3AkIvf2/KUn8dZr+CeIwGaDoRDyLn0fufrWPuTL8lsLwu357CJAbz+dAQ7RndVt+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ/2c4fi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ/2c4fi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309631F000FF;
	Mon, 14 Sep 2026 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789406437;
	bh=F1g9lZTPzCachxv5YvIFPjNYYDe+tqcZKDTKjMSNfVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bJ/2c4figti7rCZHNZQLI1114bzpyO5aNteR/hNV3SoWlijFB8mLq2ItMjmLsBPUh
	 ltASMkBAy0/sb7XyD5ANzTXruVdC0ObuiWFUKkPq513YBpMqK0c9C9mwUvGorVjXPy
	 5xQjQgqAMoLYD4BHlNLAD2VkemPgZTaB36lscjUVat7SHIz5wd7hM/1n0t0xOmkF2G
	 WwinRxyK0+XZRUEAvV/NH1CdCIf66tL3k56pUyjiEF5GS4K5hHIhYbchMQ6XvN2+kx
	 jARhQJdU+5XlPFzXtppDmwLFSNEwzdegmBBx2bG3HhjCt9inzDQA6cTnRIG/nBVwCR
	 MZ/pzGbrtGTXw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 35209FDA270; Mon, 14 Sep 2026 18:20:18 +0100 (BST)
Date: Mon, 14 Sep 2026 18:20:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH 3/7] spi: spidev_test: allow disabling rx or tx buffers
Message-ID: <aqgs0s5bbFDyJAo8@sirena.org.uk>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
 <20260914-spi-sun4i-spidev_test-v1-3-72d6a3b38cee@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mH8P7XRrIkP/9ADW"
Content-Disposition: inline
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-3-72d6a3b38cee@pengutronix.de>
X-Cookie: Orders subject to approval.


--mH8P7XRrIkP/9ADW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 04:50:42PM +0200, Jonas Rebmann wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Allow not providing rx or tx buffers. This is useful to check if drivers
> that don't use SPI_CONTROLLER_MUST_RX (or -TX respectively) handle their
> operations correctly without a buffer.

> -	if (output_file) {
> +	if (rx && output_file) {
>  		out_fd =3D open(output_file, O_WRONLY | O_CREAT | O_TRUNC, 0666);
>  		if (out_fd < 0)
>  			pabort("could not open output file");

It'd be nice to complain if the user asks for output and no RX
simultaneously, but OTOH I'm sure the target audience can cope.

> -	if (input_tx && input_file)
> -		pabort("only one of -p and --input may be selected");
> +	if (!!input_tx + !!input_file + !do_tx > 0)
> +		pabort("only one of -p, -i (--input), -t (--no-tx) may be selected");

This logic is probably a bit *too* cute; it's far too hard to read.

--mH8P7XRrIkP/9ADW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqoLMwACgkQJNaLcl1U
h9BAoQf9Fh8BwOgslhEX4Fr92xNkdhaSs/qKIvtlijuvjpUlvC72u9F8NWxz79zv
ODwTct5A4fmq1tZcrhqiHRGbVsxAZXSpga+hjha/KpUtiE/Np4VUMcu0edQ9dSWt
j/jC8rzee3rosRXuAjJm0eqF0tajH1M+yrspJCYglDVOJF4kyXj31iTf2Mcvgf+x
bCTwU1NLxTspAh3960+uaNf4iLwvPFgNpbJm7qRsnsZXm4snZVY37dXymU/u4v3l
i/Q4pmHYrq6urvtJoR3mbQ6x8uSLQ4gNR5NeL5UvLhHGDS9nGgH781FShVCL0Zrv
J9oV4t0QdTRJ3Pi3RWGzOqlWiD0N5Q==
=EuEL
-----END PGP SIGNATURE-----

--mH8P7XRrIkP/9ADW--
