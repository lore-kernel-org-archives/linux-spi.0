Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16245A286;
	Fri, 14 Aug 2026 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712176; cv=none; b=rsRJaExb6WbILPhYEFTivhWAnBwF1k+ZfuKgHF7kv3Ufea8QVKvH4SmgVV7OasaYjZDKiCyvY4kVhyk5HZGsCh2NnpqWIOf+W1sssAUIcn6tQ7nFvqHTQrFUBa2RLdNotYUv5IdyN3r9yTE3sK47Gv20X1wFDTuDMyj2eIlHNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712176; c=relaxed/simple;
	bh=alS2YydTNEyTI30Jdjv6ERlLUUBMeqn6gyqXW1xiStI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nulgWQuVh45edY24ENflfx+0EWxLZfNjX2l/q/sOtDAs/ltPx5UxnXfrGhi6RGLCJrQWlgSuM+hI25G9vvNPWwlk00Jd08EtNsVTFVsXhY2WJ50v1YvXqTtmU82lwNtxI5TO9CgL7oWqcAyIVVeuOtR5LZ/tUkqI04ZgDW7U0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPabFxzk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPabFxzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E990E1F000E9;
	Fri, 14 Aug 2026 12:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712174;
	bh=alS2YydTNEyTI30Jdjv6ERlLUUBMeqn6gyqXW1xiStI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jPabFxzkvoVOiIOPpefynquGg2E057KJapjJgd/6sQCiKOHFkIP6B9Myd4WxUpViH
	 b8mfjh5aBvI5WN4P9Pugivf0PFSrTdNoVWqzCoIpkIm7ZIutJEjUuB0BF6s7qMsnfC
	 Q4NoSX65zanATUzGfU+GlUPn5xYcWW+lMw/QrGG9ni8TYdJBKUZqOpIdKukVxoGdLb
	 62mURXFjZplls1+7e3NuMDybE7tKRtFvSoQ8PMuQEIQzhg3k+VD6axwblLYpvRvyY9
	 lW06Api4fFpX29/s5LVUvl+IkDxgb584/rRubdXfhSsusDMJcqGePoJaRj0snRLNeW
	 5gru6vQ1byINw==
Date: Fri, 14 Aug 2026 13:56:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <STLin2@winbond.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: ma35d1-qspi: Add DTR support
Message-ID: <34412d10-cea1-42ef-a53c-ef515b452793@sirena.org.uk>
References: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
 <20260813-perso-ma35d1-upstream-qspi-v1-4-b217b9870eb1@bootlin.com>
 <09c3928f-4b58-4ac6-8e1a-84dfe3ff6b92@sirena.org.uk>
 <87ik5ckh2j.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1MaZfmoaBHarMF2m"
Content-Disposition: inline
In-Reply-To: <87ik5ckh2j.fsf@bootlin.com>
X-Cookie: Body by Nautilus, Brain by Mattel.


--1MaZfmoaBHarMF2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 14, 2026 at 02:44:04PM +0200, Miquel Raynal wrote:

> > This needs ctlr->dtr_caps configuring, otherwise the validation will
> > block it - only the _mem_caps were updated.

> Ok, thanks!

I've queued the existing stuff for CI since it all looks good and we're
almost at the merge window - please send an incremental change for this.

--1MaZfmoaBHarMF2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp/EGkACgkQJNaLcl1U
h9DimAf+N+eY2OkutKjODCreckb50OMMtInbw8eyFbrin7FL+EcAfU9TxMq0G3jG
0wd1MOhs8Jrnbs3G7g0R31rh0dxq6ygGv/M4mMbTP28D/gpU5G1fbSozEnbvAMIR
EA4qmz4ILhq7DXaWZGW7qqg5TRDmTRN5+cGOFIlQKo5Udq+RmhpXleoV69xnbf2W
v9Rd/R2kqR3vTyHdTydFSv/jXhAmW1HgCWiNDh498w49uRP42bRBir6gp12VeLKb
AtJR+yiqRLzqHt7u3xxfsikV5AFAE0O4pwU9fIN8HxKICL8Mz9xqCngDKR9+eK4E
hWaM/GdSlouGolgZbvyY/ShdibVZ3A==
=2jD8
-----END PGP SIGNATURE-----

--1MaZfmoaBHarMF2m--
