Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460565;
	b=YrZH5LVYIM/B7Yz497DaRpOSsI5lvFOD4g68Qs8YrW0AC+k/dLHaNTjcauhc1x6GLRP2
	 QpkWGKpK1gkCkzNsS/uKhaElAWCUGYTqCJxZN2fbPLVHBlfV5L3eE2JWRTdeTQzRxoTb5
	 1Gf39Y7MipttOBkkiVsK5Q5N56KDNAzp8rrnJZ1SbkBfk8dpWb18rtf75Y35rWoX2Tjui
	 EUag3cnms62ZRIqmRRb+u5ZyumbEn+GBwZ95LAtFWynrS+c85Bui+7n/EfCuDN2PmM3PB
	 gndG245QC0UtqDKF6QPKZRKzXrd0D8jk23KupL6nFRUTA7vL5caGKXkm5DwYpQHXRpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460565;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=pMYyHbi9eCJzjPEu1qvig5S1oDRcjMPdMcr+B+NapPM=;
	b=ZQiTr3TSbbz+eB/UinB41c6Xk4NOCPsdLZeTu8kWMSwSEpck+X7H7VgVwWGlFV6YU9HD
	 czparCCs+wxcZZEaFH89+45kSbJABDU4RpUQWyaSQTxupiE5ALOjS/JVFm7SZ+z+FlvG4
	 UekMprAi1u9Le9nTd4pYq4uaHC53A+8RLWaCEfkxKyBs+nUSthDCfx4601i2x4TQGqIvB
	 qoB39NCt1B6RsqsKn+myqhFzrrgf0DT13NxdwcAZg7ySUXvMFux0MNK8Rs8WvlhPQV35S
	 4fFXN59YpttYyG216MwUJyl4fuPkTVO1Id9AQQorURCdEyJOoBG9pCgF183g2BWm7RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxTuS4xi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB846606A31A;
	Mon, 23 Nov 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxTuS4xi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909141F000D0;
	Mon, 23 Nov 2026 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460564;
	bh=pMYyHbi9eCJzjPEu1qvig5S1oDRcjMPdMcr+B+NapPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LxTuS4xiqOoIBv8dupRuSkFB/HTVYl0VmdGCAo7J00S/kLyOGbWqCJTgsava+mdn3
	 UB9/F/eHOS/OQe+kJ6ZN4OnR6Idiw7IZtROwXb97YLikpicLIL+2WtcBgLUtxvMLbT
	 9Raza+6Raz/KyUMOsFY7Y7nlE45K/oOo6WOWbosSJeP3KYV/m0fqyNz0/nH31KDto7
	 EhAIIbGfdWjLWZVr0egXO2f0WNJ+prvk491ULznEeOzMVAV9rIpjcBSQA59CsL6KH8
	 NsujtJr/nltw7g5wd/+f8vvJpyg5PcZajX5VLRA6OxlS7CAgaqMWD6Pz5GAJGTwTS5
	 7zpl1Dn5zekeA==
Date: Mon, 23 Nov 2026 19:02:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, imx@lists.linux.dev,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Johan Hovold <johan@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: spi: imx: Use devm_clk_get_enabled() calls in spi_imx_probe()
Message-ID: <1292bc63-f689-4e93-bf90-aa495431cb0d@sirena.org.uk>
References: <895d50a6-3a42-44d2-8625-3b8cba8fbfff@web.de>
 <awR3jGcH97PrYNqc@ashevche-desk.local>
 <797d8f02-2e16-4ca6-bfda-8b6e40742a84@web.de>
 <awSKzgNGzuxl2OXO@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="Fl4BbqkuRdkA06KY"
Content-Disposition: inline
In-Reply-To: <awSKzgNGzuxl2OXO@ashevche-desk.local>
X-Cookie: Truth is free, but information costs.


--Fl4BbqkuRdkA06KY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 08:49:50PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 23, 2026 at 07:24:21PM +0100, Markus Elfring wrote:
> > >> * Reuse existing functionality from devm_clk_get_enabled() instead of
> > >>   keeping duplicate source code.
> > >>
> > >> * Delete clk_disable_unprepare() calls on error handling paths.
> > >>
> > >> * Omit the label =E2=80=9Cout_put_per=E2=80=9D.
> > >>
> > >> This issue was detected by using the Coccinelle software.
> > >=20
> > > This now messes up with the PM callbacks at remove stage.
> > > It's not trivial how to make it correct.
> > Is there a need to adjust and extend devres programming interfaces any =
more?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/driver-api/driver-model/devres.rst?h=3Dv7.4-rc4#n242
>=20
> I guess you did get my point. You can't simply do what you have done in t=
his
> patch, because the devm*() will do something with clock reference countin=
g on
> remove stage _after_ the driver.

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--Fl4BbqkuRdkA06KY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsEjc4ACgkQJNaLcl1U
h9CuLgf/cGEyPOu9TiGIzr7JDZkRffvHTkXx4PPFRoaFr84CqMwwlFdeIxO5cxn3
p67Q7PrjWTgoWsLkBHwL02bg+9NWkaqXGh3YxB2PTeY5PwaZtqaSf3D2aWbk2juS
GW6MoeDmhbQMCO6LqEr0LWKNkRDPU1jN55xWco+FNEnMqcixrer3cgGrs3DoW4FT
mpfisWt27N3iAbWmLo7Au+RclhP+G0PIpOxbaZzWu68QcbZr7pt1Qp+kD7R8fF/u
rc4gPU2nqbE4/r/moyo5JJ2q6mPZjGncznlhvLWM0clAOaK0IwUIJgaNF5M72MHd
rIHDa8Pz5cs/ycb9asfj3FgK4w03/g==
=7gtm
-----END PGP SIGNATURE-----

--Fl4BbqkuRdkA06KY--
