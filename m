Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200EF2EEE75;
	Sun,  4 Oct 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121055; cv=none; b=kfMHJTMUAItOCEsEb/ehJwj4Ch3zrom8/4yfnGDsd/ZqFkwqfD5Z2/DfZSWTQYf72DNSHJwU8pKamDenUIXjncuAVCf6UCwL5pIhDQCOER6MPTVt2sZ/H46P9Ds7Tszdeh6uoJYWOudS2I5qhOblxfpQcl+5W/74jSdDOKGTMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121055; c=relaxed/simple;
	bh=mtbHayPObhYfgY69k1rblqQ/9CPWpYRtVK6wj/OQJPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpOE5JAk4EVRWVXUfcJCW3B9C6uCUvE9y4pByxzcjbvJXbFGZUzoOf546fDca3sb/thkDjjl4a2PgVoe4sVp/NVFzhTUP3MegoliLCxOHh5o7ewiDNHNGX9/X3OBe781tgE/e72cv/9KEKJARVIBYfI7Viq6z0X1C1ciqN/WyVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmrPEE8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmrPEE8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B641F000FF;
	Sun,  4 Oct 2026 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791121053;
	bh=Pl46IOZhk40Hybov4sG5iF5x9sqFwGsbh8WtArPBWqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hmrPEE8Oj0RN7uFUmMI6LL0KiZaGkJtuRDKzbVwA0mpw74vvu8DRXsJNmVeoWFwfp
	 5i4SN/TBILjisEC2rU4rCz7aZIxUVwvAraSFJsvp7CdPNcQ2EP4Akew7rpvQDb6pd4
	 TKrnbYGmSdx9QA337CaF3tls527wOgKdOVjU0EX6JgMhr0fsO9aCxvcpg3a6+OIPTD
	 OkVkYDXQFYnps0MzDwu7HUbdi0sEisCx7gJrTZOr28cSJX12Pp21q1G5EAqB2AGP4P
	 pEG/ED2Rqq5U74vJAk4h/5gVFNAwKxcHJCHTyC5FnxcVmMIoAUkzLvzUBVJ+yTZVnR
	 D3hylO+KsLqAw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 4FA3B13546A2; Sun, 04 Oct 2026 14:37:30 +0100 (BST)
Date: Sun, 4 Oct 2026 15:37:30 +0200
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>
Subject: Re: [PATCH 0/4] spi: spi-mem/mtd: spinand: Prevent SPI NAND
 continuous reads on am65/am62
Message-ID: <asJWmi_Yim-jsdin@sirena.org.uk>
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
 <878qa7dzke.fsf@bootlin.com>
 <87mrt177km.fsf@bootlin.com>
 <38290328-a562-4813-a9e0-2fafaa3874c7@sirena.org.uk>
 <87cxttml2j.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Le09z8KgXx1luYP"
Content-Disposition: inline
In-Reply-To: <87cxttml2j.fsf@bootlin.com>
X-Cookie: Orders subject to approval.


--9Le09z8KgXx1luYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2026 at 06:39:48PM +0200, Miquel Raynal wrote:

> > No, they don't apply to even v7.3-rc1.  I didn't see the immutable
> > branch mentioned in:

> >    https://lore.kernel.org/r/1FyLxEwWqNFzX@sirena.co.uk

> > yet?

> In theory you should have received a request to merge
> the immutable mtd/spi-mem-cont-read-for-7.2 tag some time ago:

> Subject: [GIT PULL] spi-nand/spi-mem changes for 7.2
> Date: Tue, 05 May 2026 17:17:42 +0200

Ah, that wasn't in reply to the thread so didn't find it when looking.
I'd have expected anything there to have landed in mainline by now
anyway.

> But that's not a big deal, I will rebase the remaining SPI and resend ;)

Thanks!

--9Le09z8KgXx1luYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrCVnwACgkQJNaLcl1U
h9AH2wf6A9I5Gjx9ErZA95l6pvSSI3DO/Cn+deMkTuHSICHdD3Mp53sbC1lu1a8R
OeQiC22eTnPQhlKyqR0rVupYb8JJRfTtNKNasJJDCghUMp2nq3U6AhJRlQZO0QPy
2uUNkQPivpufMzknAVBUUrVI3ZnDJYGhvUiQJNc6rmpwO5EiKV6gX8r/pBSW2WYL
vfmKTHWQz34iYFkaIcFmtFFona/6d1ihudtn3mNrbx/p5a3EJZPWKJBiskdI7GJl
Uwutj7ZpMyocFfxiZcdLi2qEd3W9H7x7RUUfouVUx7vWwmUwy1CE5d6hLbPWs/Zq
9ASaMSICNxpMg86HC7PmTDPDILQ0/w==
=69MY
-----END PGP SIGNATURE-----

--9Le09z8KgXx1luYP--
