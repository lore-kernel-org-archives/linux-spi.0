Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAD3AA502;
	Thu, 30 Apr 2026 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543938; cv=none; b=AZIfuAAQzgqrecVcqBa8oX1vjAl0AFO7En8WzIdXbKOsi1qLceRrnfCsK/rkrMJ/AAWFn3uh+/9iNVY5dBMTxVyFJGYivyC+g0ENk88iVVM7WJ5+TKp6KycQaIthhWvuZFaDCjN1mtXLXY+LyRKpF+cFdeiIpQ/0aMnTmmWoWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543938; c=relaxed/simple;
	bh=hTRxTf3TeVSDrQCgz/ysE97G71Jo2g+siJnubg4Qaxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGO5xRE8Zz2P0nOaR54klMCNEOF/vnUvKIDM0s/kYDqFC6iVs7GzfK90YAatosDIUBRK8XqcI7NPawGDP3D+Z4ZVETovSdd8RXSsMRIO2wU/qqL2nJQBXDAGANXn6BfhohhFztr4qIwPULakGm0n/I/G6aS20LfgvQiJnCnbddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGOLS5d0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGOLS5d0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A5DC2BCB3;
	Thu, 30 Apr 2026 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777543938;
	bh=hTRxTf3TeVSDrQCgz/ysE97G71Jo2g+siJnubg4Qaxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGOLS5d0s4AHmUGyXOexXKpuXYDAez3wiQcyer1aXAG6CROFSkT1YwLrsWcI78Six
	 zyaRaIfd3aZmKCCHLuoOZos0QK7WUeI2XTKLlftAs3twV1ZqQFXTdm3he3xjwdXDUX
	 9rJkgNq+wJwSO1ZtTeyWE+YeOAsS+iiPNkjNopTtA1nVw7Py9Fz4QFmW/Yp/WldQG5
	 GPeRdD94T4IWeRTqES+h62Y4DMS4o6IzndiupJaCvOp71TJnvYBmXF+PzY7K5vnUBq
	 xlb+MUgGMBKZ5eTgekymkDhGM2VJsuAMrTEhzkVTjWUFb9IOU36Um19k83mhicVuJr
	 gwwTihY5s1V/Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wIONU-00000000yeg-0Osm;
	Thu, 30 Apr 2026 12:12:16 +0200
Date: Thu, 30 Apr 2026 12:12:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] spi: omap2-mcspi: switch to managed controller
 allocation
Message-ID: <afMrAF1i63-pqb5A@hovoldconsulting.com>
References: <20260429091333.165363-1-johan@kernel.org>
 <20260429091333.165363-19-johan@kernel.org>
 <afKisC-NX9YZhaEv@sirena.co.uk>
 <afMA8buX6EP3pKhs@hovoldconsulting.com>
 <afMpV6V79oCzIZSh@sirena.co.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aIoEjmUEPhk9LT0K"
Content-Disposition: inline
In-Reply-To: <afMpV6V79oCzIZSh@sirena.co.uk>


--aIoEjmUEPhk9LT0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 07:05:11PM +0900, Mark Brown wrote:
> On Thu, Apr 30, 2026 at 09:12:49AM +0200, Johan Hovold wrote:
> > On Thu, Apr 30, 2026 at 09:30:40AM +0900, Mark Brown wrote:
> > > On Wed, Apr 29, 2026 at 11:13:32AM +0200, Johan Hovold wrote:
> > > > @@ -1556,7 +1553,7 @@ static int omap2_mcspi_probe(struct platform_=
device *pdev)
> > > >  		status =3D omap2_mcspi_request_dma(mcspi,
> > > >  						 &mcspi->dma_channels[i]);
> > > >  		if (status =3D=3D -EPROBE_DEFER)
> > > > -			goto free_ctlr;
> > > > +			return status;
> > > >  	}
>=20
> > > Here we return directly...
>=20
> > > ...which skips the _release_dma() as well as the put - I think the la=
bel
> > > needs a rename and the goto keeping (or some more refactoring to also
> > > use devm for the DMA, but that's more work).
>=20
> > This works as intended since omap2_mcspi_request_dma() cleans up after
> > itself on failure.
>=20
> This is in a loop so there might be previous calls that succeeded and
> need unwinding.

Ah, sorry, I missed that. I'll send a v2 separate from the rest of
series.

Johan

--aIoEjmUEPhk9LT0K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCafMq/BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQC8XNwux9ZQjAzQD+NoQLjLUK02k7TE7URqL4
y9Q7iLcFuIIWpNxo1VVchAMBAK523quooWma7FnrKA4qqU7KqHR6jbBYw9FtDtL/
dlQN
=KUUQ
-----END PGP SIGNATURE-----

--aIoEjmUEPhk9LT0K--
