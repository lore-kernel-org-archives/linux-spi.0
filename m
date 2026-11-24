Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534135;
	b=tqQCnl3peu1j4GDYJ7wGTlh/4FQSu/poBhle7K5o6f4is+Pppzcke7YAC0gEEu+USGW2
	 iwObk30f++BkHVC+SSZ9KyWYLdoQ4cT+bSqOGGzS7U0my6fePB807/0ZjHdJGhrk6nbuE
	 NAuOuZRyR16xyIKTta8rnIoUD6ddTvFB7YrqDVrJlvuJ7kgrCTub8LpmFxaieq4wXtW1l
	 wqIidBHFceq6lhfs6eWeE8fVk1gbzXwMj9YDjfVShHGtVDzTqwG24v8RNUi13snG2+9bR
	 bE25zHA0XOqUQMIl9N5MLqk0fJ47h1O066O9H7mg9uaHs1wkJOYgEV9mwuB1eV1YwxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534135;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=woN7dX42/QEfdHkXNoIkI+sOdH5SgWjgz+68nCPxUF0=;
	b=4ObbJG1t9dKvUHmGolqFrGQL7oQeQpvNS94yL0PgZorSZJS2MRLk+s3Q19rQBnZvsyVR
	 vfdlGvXIMlOfEVRknlWzxrWAn3rwaxNGNWrb57Rzl2sa0Cv+dM0U95K8VK/8y6EGMC4Nd
	 wAmJYGXiBkhV2wcW3iqzrBQRI4VW9rrOuOEUNz8XFvA9qom27v2NX1Cgt+OMtl8Kkfcdw
	 IzF8tQSyMNukY8lwxPhVlLm1LhI19b1yWsxz6eGD6u/7DvaGDnNTp2J9R3fdWyHX+DXU9
	 VjQ1+LmGpx2jxIBw/ZU8csSC+S2t6eEhbeD2kwr/aTt4fCRs/RpjQ8RJdJPtFFdvoxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N23fKN+U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58657606A323;
	Tue, 24 Nov 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N23fKN+U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD241F000D8;
	Tue, 24 Nov 2026 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534134;
	bh=woN7dX42/QEfdHkXNoIkI+sOdH5SgWjgz+68nCPxUF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N23fKN+UzfLec8SkLRYPloYVrCpUpgQDmrteL/rHwsXMg5ePevTG9rFJAyCjzpJdM
	 ko34az+IIQKOPrrg4I3XddletoDrTQzOto5FdKS1kBVNhoNHWVZS030hkgAAL6skOA
	 ceN8wsSb+BWU+go6T79jTVaWh48TL6gzi5L3Ht7N0Ah7exHeFj6yIFTf+QVbb0OBhy
	 8+9zgucJBvBS9vFoqR2pwq12Ue6dLM4mcrEIvCUlvvzt52/nVz0WyXfsuXyElU/szH
	 D7YUqECRpg2opFv0dMkxhc9o19DYqiSeshFpJ6FxuI+nZC3C06NPzuxpRllTHWfxaI
	 d70nKxM/yk9+A==
Date: Tue, 24 Nov 2026 15:28:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com,
	u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/6] dt-bindings: spi: Document the spi-dqs-not-wired
 property
Message-ID: <815ecaec-7bf6-4ba4-9869-f54f1c85a7e1@sirena.org.uk>
References: <20261124-winbond-nand-next-phy-tuning-v5-0-261e0e712857@bootlin.com>
 <20261124-winbond-nand-next-phy-tuning-v5-3-261e0e712857@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="axoJEjM2GoVi6XeC"
Content-Disposition: inline
In-Reply-To: <20261124-winbond-nand-next-phy-tuning-v5-3-261e0e712857@bootlin.com>
X-Cookie: If you can read this, you're too close.


--axoJEjM2GoVi6XeC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2026 at 03:43:04PM +0100, Miquel Raynal wrote:
> The DQS line is a data strobe line that is typically driven by flash
> memories (NOR and NAND) when the data flows from the peripheral to the
> host controller when running at high frequencies in order for the data
> bits to be sampled by the host at the right moment. The SPI bus already
> features a clock but this clock is driven by the host, which means it is
> not accounting for any chip internal delay.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--axoJEjM2GoVi6XeC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFrS8ACgkQJNaLcl1U
h9AAwgf9HaTs4e2f/UrGLH8UQ9/Led6UPT1G6vWCeWG/AZe7BGOlHv50yqXp63CB
Js0Xzt0NyXgDTeAcRxJpZxb/p452QHyO+WMdkt6rBpvj96wgdCOjzNSDoGmVl4fL
CYom+nMAVJOtZhcanmuPCjgVoDAosfm/WIc04Io6XXfp248irSd/bhABH5pSRIrf
UN3n/BZILy5VaG7rFcb2RRC/IYETPnNZ3fFFeurH5j6XXi21IQwpibLxcF7yAMag
DWKaEElYsF7cTHqu+zmbvRpaj3kOsMschPqwNPoGxxM3QxZl1p0CkTwBEwrr/HSq
s3Q8w87hREg8NskKRUEl/d0EIzEg4w==
=el/G
-----END PGP SIGNATURE-----

--axoJEjM2GoVi6XeC--
