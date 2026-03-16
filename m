Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947F333557D;
	Mon, 16 Mar 2026 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684965; cv=none; b=gL4Nl+JcajqxA3actKK2FUMG4nehv35F9Tg0T+y5l//8NXt5NWGtjqtMac5DkJGha78cW8Xi4pABv1+nrN6DufbTugULneJ7dn6Cb2QVgAk27/IzVfd/FhR/4kPvJi8biWWENWGJT2tbSjBnTOB0b1ZB9YjTs6UO1yu2nMUWG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684965; c=relaxed/simple;
	bh=MVWsB3ODYaEflTQJ2DMoujVRZx/+KCBS5+BP0+HSx/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnHV48JpfciOz0Geldj19oGwiDSMAsbV0Qu383MSlJJM5XU5Mr0qxaJgklCDvG6juM6FSo/lsYx+6YomO51vFmEovPQ8NZv0udCGm6A41ZIbDHP+flwsypeFfBu1PckYmwKl4HR4Qmisz5LoGJSgxWVe1BReT73NPFiedksAelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPfu1NJQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPfu1NJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51E8C19421;
	Mon, 16 Mar 2026 18:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773684965;
	bh=MVWsB3ODYaEflTQJ2DMoujVRZx/+KCBS5+BP0+HSx/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPfu1NJQ9xrhx3nG5sm2XjMl+QoL7vcpT5LdDZZL8tYfkRUntQVlj/rpOoI4hQYz+
	 an2fVdtd1OzeyjKvEYd5cAKsmUsYc+zv8TE/swBK1B1054ZaZQNMoSm/KnchI9/OPC
	 FaMIWIYwaZrZSfUdrNVGL2RPZ1n5nBEG5bb3+vIn5FLpradx1EgoK8uh4KhC2XAUGf
	 X3xN++X5Nm061UOQg90J91kDz9TBIpOfxbyG3/vpi2kyioXOXYKQPaiHubtk/dRJNN
	 gqdbtZc18HaEtiCFaT8EMDIqFyeTRTZwo3sZknYUVagqVic0xQTiISS5j399NQaVP0
	 sb1J6lUWdTraA==
Date: Mon, 16 Mar 2026 18:16:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH spi-next 04/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
Message-ID: <b6787850-11cf-4b38-a5ea-da2c5d0811f4@sirena.org.uk>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
 <20260316-spi-fsl-lpspi-cleanups-v1-4-1b695607702d@pengutronix.de>
 <e4c711c1-5229-4685-aadf-f88aca9fbd3d@sirena.org.uk>
 <20260316-original-dove-of-respect-1a6e04-mkl@pengutronix.de>
 <0f04cc7e-c960-42fd-9a45-49777e49dd4b@sirena.org.uk>
 <20260316-venerable-caracara-of-advertising-a9e9b8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qwt0low34LoDaxe3"
Content-Disposition: inline
In-Reply-To: <20260316-venerable-caracara-of-advertising-a9e9b8-mkl@pengutronix.de>
X-Cookie: Not a flying toy.


--Qwt0low34LoDaxe3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 06:59:12PM +0100, Marc Kleine-Budde wrote:
> On 16.03.2026 17:37:45, Mark Brown wrote:
> > On Mon, Mar 16, 2026 at 05:49:48PM +0100, Marc Kleine-Budde wrote:

> > > The param register's default value on the i.MX93 is:

> > > | LPSPI1=E2=80=93LPSPI3:  0002_0303h
> > > | LPSPI4:         0003_0303h
> > > | LPSPI5=E2=80=93LPSPI8:  0002_0303h

> > > This means a RX/TX-FIFO size of 1 << 3 =3D=3D 8.

> > Right, so the parsing code is using the wrong mask to extract the width
> > here but with actual values it's fine.

> No, the parsing code is correct, the width of the fields are 8 bits
> (datasheet of all supported SoCs), but the values are "2" (i.MX7ulp,
> S32G2) resp. "3" (i.MX93).

Oh, dear, so that's potentially going to go badly if there's a SoC with
a bigger FIFO that didn't also increase the watermark field width.  We
should at least warn about that, and ideally do something sensible.

> into the watermark fields. So using the 3 bit mask in FIELD_PREP should
> not be a problem, even on the IP cores with just 2 bit wide mask.

Yeah, it's not broken right now - just landmines for potential future
SoCs to trip over.

--Qwt0low34LoDaxe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm4SOAACgkQJNaLcl1U
h9BAawgAgWa7fZZzZJszUFG2NAOUivCiNytz7paqrj/jXo71mFtL183DpXmzvuxT
7aII/CDFe5u1IM3KMOJVQTo2a905zddi3PM/JOBwLnks6OfeMZraHqdfzrM3l4XH
chr3RI0ItusexoReaAh7MBxbPm9KSZcBPLgHSi+fOwcFmJlH+aBQBHQmP+8Wj2Hq
rjxn9bosOW0nv51jk0FS1KZDifPWsdMxPMSB8cBqLVBquTY+Qx+Rne/+S1U0qww1
fshiLQ9UHIIITt5TaF08jfeFaMOzVmgUEBSptJL2nXUwTLmR50U2277mjFCyiEgy
pMbM6fSUV8gy9LyM1mpZU++YCsChyQ==
=JV7K
-----END PGP SIGNATURE-----

--Qwt0low34LoDaxe3--
