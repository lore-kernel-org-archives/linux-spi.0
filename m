Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFC2192F9;
	Sat, 18 Jul 2026 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784404889; cv=none; b=jPHj9RulqqAGuW7tESl+JDhsLLxcOtkCEilET9HR8EupsbP9kk2wAYotBveB4TLzqHrcYeeK/3wsNr9H2zGwODCwUiGL39mr0kmCeVRyyanG1kEruJ1PU96JttGNJR/WbgSTuJy9PTEiMox9GF8AB2IVweVeh18Abf64D8iXWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784404889; c=relaxed/simple;
	bh=oRy7B+8o38Pazu72C8Uy2BgY6aIOGzfs83O212fF788=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T78CRey85ddjJAZG9fCwWDKSfpEw2O1kPM3dGiorBoTt3OrIHmdvn7VTZMhSWd0bJ0sV1hEHQdN6zSss1JCfFoGKXRI3Wm5aLY49+t5pFxXargRRc4Kb/tURyg6YVXzSpfPC3zJYqWDnhR0Ut1ku/eDbRmjGU4pNTzGn+OUvMOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DE31F000E9;
	Sat, 18 Jul 2026 20:01:26 +0000 (UTC)
Date: Sat, 18 Jul 2026 21:01:24 +0100
From: Mark Brown <broonie@debian.org>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <83b8893f-5e9d-42e7-aa01-6e2b825f42e5@sirena.org.uk>
References: <20260718160702.7861-1-fourdollars@debian.org>
 <20260718160702.7861-2-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vVWJXFNKP1arXLHS"
Content-Disposition: inline
In-Reply-To: <20260718160702.7861-2-fourdollars@debian.org>
X-Cookie: Do not pick the flowers.


--vVWJXFNKP1arXLHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 19, 2026 at 12:07:00AM +0800, Shih-Yuan Lee wrote:

> Move the forced PIO mode DMI quirk to spi-pxa2xx-pci.c (the LPSS host
> controller PCI glue driver) to avoid layering violations in client
> drivers (such as applespi).

> Add an explicit DMI match table for MacBook8,1 and a module parameter
> spi_pxa2xx_force_pio to allow forcing PIO mode on demand.

Note that this will mean that the runtime PM bugs fixed in patch 2 are
exposed, breaking bisection on the affected platform.  The actual change
looks fine.

--vVWJXFNKP1arXLHS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpb25MACgkQJNaLcl1U
h9BE3Qf+LtcYGE+JeAIc7fq8o9vQ0TU6Q/NkNMcHn853VmQeD+Hakv2f84vJ1HUv
mDMVFgLGMCad8o38GQP2igO01Ue7PvHsVa0mjK7VnrqDdVGeu3Xg6SPautoJRCqJ
fgx5w5ItLLKzzByLLEnkbz/e3rbtNUhaX2v4Wy243p1JqXEHgUU/BD9LhBTTOwFZ
TBpw9rBAjfsn7NlfwoJTqBgE9qvtBWuskt7YvhGy0jwap0pSsNEOPGcZOUzq+eMp
87WUrd0lHsBrJ6ePLf+vgfR/lTbw47+CpJ+d9UGQqhBBy+Y7Hp3B/9gFn8e5tzhA
ZimhuSR7pHSXJY0I8n2XZSCjYJ2SaQ==
=eQjj
-----END PGP SIGNATURE-----

--vVWJXFNKP1arXLHS--
