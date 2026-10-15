Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80A4E4C22;
	Thu, 15 Oct 2026 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066195; cv=none; b=mhrFTiLhqDDJAPElGvJ+RtgJqLAsTN/reMRlX/6+5OhdSHv41pqCpqzakdgXYpozttjglZ9JlC5p5/WZDSAamT8UopYED9GG+gKmGpxHqGDCv3obEG46y0/Mt5Mj2HoyE8tvPxbtdFaJva0piulti/3TZORCXVq4wsprgvR+wAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066195; c=relaxed/simple;
	bh=EhoxaBUS5Tb5fus1YdOeENGxRzUlDjxZqggE/fj9pvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+cLc2lhmefBM1A9s/ciTzvLO6Q5GMg+vb2tKuEgpxRTAsWTM9RlpZSouJRryiw79UUQ9fiALLoLFl08YtE104nXwODC5dHouPMhgoiDy3C6pe8ZvGAgUgfPQ+hsssgetd1QP2oKuJxSpbEOOl3vPMlqLfe8jg92KP6KwkhAV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaX3kgJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaX3kgJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91C11F000C4;
	Thu, 15 Oct 2026 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792066193;
	bh=5TFfhtEZymDVC1w0b609A5ABsMnSltfDfvXOrQD/KY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IaX3kgJHKwrzWGgsgjJnuaLDvKBB+qN3POm3oEIbf4CfYR+vIEqVpODRMwoq/AGmy
	 TdzQzIK0kCReQ7fZO85a/WPAPqfWpf5DdB9iQMijSUAMT0TWaT/TmzbMSbh8Gutk8Y
	 esIi/DK15Mc0mZBSX6PO8EYq4MoWfLL5mDoKWgf/KmGbf/Fr+Lv2xn3yK3Ykdq3qtb
	 xfQZATmrH2RxaQuDE56xel/CiLeLePygAMdIA8+jZo+2rMquKtAL20Y1tkxEXd1Nrg
	 feW9oYuq37pvJXtf0BjWp1ZuSs/0PHlaqvda5USlv2zf9v0LYfxqiMtsY0FKGwqFLb
	 BA5iDMruvYI3w==
Date: Thu, 15 Oct 2026 13:09:48 +0100
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
Subject: Re: [PATCH v3 6/7] spi: cadence-xspi: Add support for panic writes
Message-ID: <f6008943-c4cb-43ae-a791-31965f374ffd@sirena.org.uk>
References: <20261014154301.157755-1-paul.cercueil@bootlin.com>
 <20261014154301.157755-7-paul.cercueil@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R7ilFvSy7hHntzSv"
Content-Disposition: inline
In-Reply-To: <20261014154301.157755-7-paul.cercueil@bootlin.com>
X-Cookie: Tax and title extra.


--R7ilFvSy7hHntzSv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 05:43:00PM +0200, Paul Cercueil wrote:
> From: Tanmay Jagdale <tanmay@marvell.com>
>=20
> Advertise support for panic writes. When a memory op is received with
> the 'panic' flag set, the driver will then work without relying on
> interrupts and without sleeping.

We check device properties in cdns_xspi_supports_op() if the kernel is
built with ACPI support, that ends up using of_find_property() which
takes the devtree lock which means there's a possibility that we might
deadlock (eg, if we took a NMI or the CPU fell over at the wrong
moment).  This is probably thin enough it's not worth stopping the
entire series over, it could be fixed incrementally by storing the
values during probe.

--R7ilFvSy7hHntzSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrQwosACgkQJNaLcl1U
h9Cd3gf/VAYkmxCeAkm7N9qwAd30xqwGrjFYs/2mOwDPMyBcp9h/7uWn9nSot0C9
nMEPLDBJFOTtNJux/OtYP34Q0eGPYsHDNDd1IiQGe9eYYTeCvZGdhe6cDReFoTJy
qostydL1ZPFj8fyX/L7dkxpHwj4q/Wh6Hwf+xrF6L+DdGUHWwdRPb+7Yyw4vXQhY
wvYJpajlSSFVFJyLiCupa+a291bog0XIcWho6w7N3lJxwXt6arY8bbk13VeW9G3O
vtu2lWsnPJPkzn7LcpGcQrS8Z8/oNEHws/il+zsBy62NaeIBd5pewH+HF6pVzkIP
eRvH91UYtNEsMucoAyXMEauskiLWGg==
=siEH
-----END PGP SIGNATURE-----

--R7ilFvSy7hHntzSv--
