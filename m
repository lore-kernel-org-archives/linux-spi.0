Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52AD29CE1;
	Thu, 30 Apr 2026 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533172; cv=none; b=snYybjDCSaGHFw57Mw1dmhW5H36i4RyNalMVv5FP0PZh7Ov3c0BM0EH7gu4c6JKHsVm/0tcfxSaK8Pppf5Hp8ufC79IMlmEs9D72XBQgDP+FRsGMalpOHMIopOSOurrlqhgvFSaDlfVrjBNPU1xPn1/T28r+GPMaVMkbiTS/kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533172; c=relaxed/simple;
	bh=PFPLVVvMDCTWCSh4mG9ddnWhMunij5LbzHgbA39BEP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N98PAImc6VK8+8hffMu4OmzVMY0FEXBkI+0gun9voQkmvnU5Jh1ybDY4YT64plfX5/ONVmgOhjVUESqrAPfIHaanzPprymFtamJST5bj8d4oSVQAox0C2WpwEQSXcKpwXbgTX/36dcnFjEzOYCTOnyA7WJxkqHlLM1UxPrcbLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMi8LMJM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMi8LMJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497DBC2BCB3;
	Thu, 30 Apr 2026 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777533172;
	bh=PFPLVVvMDCTWCSh4mG9ddnWhMunij5LbzHgbA39BEP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMi8LMJM1SbkCQqA2yMAtra0glVLQQv9WRx4FWOGWCwTTyfJBarCCL7pqb32hvUPc
	 5qmGOY6mZ4wCfnLxbZj6eINAQbRwChKqfk0IGl7ELzvHUffRu0KsSYj2XhYBVEx12r
	 pEjisLXVnrAvcHEMTKXEtRo/9WCrss6QonR3VF1LTCsgmDTFJ9IfCbBAvKEgrK2G0D
	 rFMwMzA1EMtpRsGoqgf6HSIcWjS5KSWnYM0s1Xv50WZ4XuMEEpHI1tLDVTWRLIQ6dm
	 8QpCFe9HWFNhH5UBUC5iZ2FbFweN6//LQ7uu0xTIIBw0Tws/Qonabk/8dqc0vML4Ne
	 DL6eVFeEFJVog==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wILZp-00000000q3F-2kL1;
	Thu, 30 Apr 2026 09:12:49 +0200
Date: Thu, 30 Apr 2026 09:12:49 +0200
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
Message-ID: <afMA8buX6EP3pKhs@hovoldconsulting.com>
References: <20260429091333.165363-1-johan@kernel.org>
 <20260429091333.165363-19-johan@kernel.org>
 <afKisC-NX9YZhaEv@sirena.co.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m1faODX6zMeza0FV"
Content-Disposition: inline
In-Reply-To: <afKisC-NX9YZhaEv@sirena.co.uk>


--m1faODX6zMeza0FV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 09:30:40AM +0900, Mark Brown wrote:
> On Wed, Apr 29, 2026 at 11:13:32AM +0200, Johan Hovold wrote:
> > Switch to device managed controller allocation to simplify error
> > handling and to avoid having to take another reference during
> > deregistration.
>=20
> > @@ -1556,7 +1553,7 @@ static int omap2_mcspi_probe(struct platform_devi=
ce *pdev)
> >  		status =3D omap2_mcspi_request_dma(mcspi,
> >  						 &mcspi->dma_channels[i]);
> >  		if (status =3D=3D -EPROBE_DEFER)
> > -			goto free_ctlr;
> > +			return status;
> >  	}
>=20
> Here we return directly...
>=20
> > @@ -1604,7 +1601,7 @@ static int omap2_mcspi_probe(struct platform_devi=
ce *pdev)
> >  	pm_runtime_disable(&pdev->dev);
> >  free_ctlr:
> >  	omap2_mcspi_release_dma(ctlr);
> > -	spi_controller_put(ctlr);
>=20
> ...which skips the _release_dma() as well as the put - I think the label
> needs a rename and the goto keeping (or some more refactoring to also
> use devm for the DMA, but that's more work).

This works as intended since omap2_mcspi_request_dma() cleans up after
itself on failure.

I can send a follow-up renaming the error label as this is arguably not
an issue introduced by this patch even if it makes it more noticeable.

Or do you prefer a v2 (posted separately from the series)?

Johan

--m1faODX6zMeza0FV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCafMA7hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQC8XNwux9ZQiWAQEAxoGRCdgyxMPGOr0BsJUR
oLyNl43ZP3PEgowPO6LiwUoA/2tDKRubS3qi1lkSmwA8TFJ1IziBUsseVjSxu3ow
MkEC
=mX13
-----END PGP SIGNATURE-----

--m1faODX6zMeza0FV--
