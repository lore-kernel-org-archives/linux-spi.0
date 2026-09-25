Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02E3AD52D;
	Fri, 25 Sep 2026 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338052; cv=none; b=m/XtC+KEsIE8HztjbSs1fWWyEuU/1SlDDOf01bx3f+mkJDRXMJxuyS1sVnvJf46nxUXNs3P3oFZIgLRIMLKY7tLZit9SpHaHSHPk2Uz0aTiYSvDcWwcZVhgY/gohfync3Ljtnr72LfNSw3ZUrVTe8Mk/yAV8xeLjBEFDcQE/DmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338052; c=relaxed/simple;
	bh=O41vtfaLSRixaR8PfVlUg7uQNoto3OUMePtldGEc9KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfD9GydqhH9RDipXaRKLg0VsW3qVv/khrE41u97yRyUAG0cilSj+DANwPEq/NZQ9FGzcQWumxjR2E8HjS6q0X5/fdZ9z2QcVESZzx64N2DqNHMjj+TFJSWVBZRbrX4ficUXbcdBdigrX/Jy4EAXichJI0DN6BB6pWflH2GvBFx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6UuV0Dw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6UuV0Dw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA121F000FF;
	Fri, 25 Sep 2026 12:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790338050;
	bh=O41vtfaLSRixaR8PfVlUg7uQNoto3OUMePtldGEc9KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G6UuV0DwTmtLg4VyP4p5QIqq8X7KMRhkXoaV4+5BvspNG0QFu61CnDxuzksHwTop2
	 utKGTuP0+HBTxIaz4lTi9X6E9oMAlkBXi5MHiJ9FxAjCIwgZkUJK3WkVCdYzfVtZgF
	 v8lvxVm0p+KMINxLVritekjJtfashOvz5H8gu571B6u+Gx2s/HR42x4Ne3nNrUQtg/
	 8xtL/GiRSP7aQ6wzW5Nau7J4R6fUL6eNhn/mC3NzihiCLZCdakSpRu8rMLPe7z/V57
	 v98qnWn2HsuWwsPBWKLSDGca96Ioe9YhD8LYyEHepUz1I9ROnfiF6mozspyb9zaiUi
	 eSe9fZFUonpgg==
Date: Fri, 25 Sep 2026 13:07:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH v7 00/13] spi: spidev_test: new features
Message-ID: <16b43cba-15b9-499f-a65c-7b0bd16ef27d@sirena.org.uk>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
 <179028361909.149798.4722443728698354015.b4-ty@b4>
 <039e13d9-05bc-47fc-8d6c-83bc39578e30@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="70UIowTZtoWnOlHZ"
Content-Disposition: inline
In-Reply-To: <039e13d9-05bc-47fc-8d6c-83bc39578e30@pengutronix.de>
X-Cookie: Love America -- or give it back.


--70UIowTZtoWnOlHZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2026 at 12:51:38PM +0200, Jonas Rebmann wrote:

> Thank you! Have you managed to take a look at my other series from last
> week for sun4i yet?

> https://patch.msgid.link/20260914-spi-sun4i-fixes-v3-0-9fe919d5cecf@pengutronix.de

Typically there's review from the people who work on Allwinner, though
it's not usually super fast.

--70UIowTZtoWnOlHZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq2Y/0ACgkQJNaLcl1U
h9CTOAf9Gp53pkdbvKbvW0Rjrw2h86uvZwiBwVX/jOg9qd/kUA82g54XoCC1g7w0
qzC+93LHKNLIIoc7JXpAKomRMgfAlZd8Wc4oDNMfpS582975cphiDHhKSBsVArVy
8nx3ChpJ10ddNFkJe03M7yX0JmdsgC1UWNZchrSi4g3KAUOVsciwL/pCZ3PL16ja
4mGt0yKEA0tPLnEN1hNUWLDAIg98ziAM8Mc4johgG1BCYXVh56TOMIt1qXblxW1S
9Yx77D1zyfHq0f3VxXmygqKXvozqxrrdTYBt499KrOmxcBk2TvtVHQxAIDYO3Gbb
8wG/rcBqcMJqBBQPyE4NFZbC7WR0cA==
=aWUq
-----END PGP SIGNATURE-----

--70UIowTZtoWnOlHZ--
