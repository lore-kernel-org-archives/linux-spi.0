Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B23DA7F3;
	Tue,  9 Jun 2026 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040532; cv=none; b=iTTq036WSbFuDrU64QxIAbAPUTuubEA119jKjB0w5XYk/5ZpBmK+J3rhMQInPqxaEnWqF1U78bVyN8KbJzuZY1NDQug2Vt/c21XtJ3obBDNsB/Vsqjn1yc1OH8hNOv6DgpljItXjtMDWRGyP92HPM90ElD3r8CFPB0z6OqrNm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040532; c=relaxed/simple;
	bh=yyPTVSS0azhWf5S1OAFcYT5EqgU1olAzHiPuzSokF2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd1PlFxF0Gi+jK8h5mF7Jdi8QUOqJ2V/42UA9M8dxIj57LtVytri7uYpgn7D3b0TaHsBdhBaSvSaz81iTu3EjhXY1Ow6+dOw0OLyQ5kipHWN+pnwicheK+9PtoZRayBKWeljWd0KaHKEljOwKxy6i7e5xgr6FHGDEJiOLT9TBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5BW5lMX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5BW5lMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B171F00893;
	Tue,  9 Jun 2026 21:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781040531;
	bh=yyPTVSS0azhWf5S1OAFcYT5EqgU1olAzHiPuzSokF2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e5BW5lMXTkch2uJhkwoG02f4clGsMeutkUOQYefebqigNmi+Pw76Z5Zo+0wvHa9RB
	 jYE+j2PoiCb0BRDq1XtvwhW7DXJLiJPUM02w3c+yv2XOgc3usGenSPLqzHgndToodA
	 XCq13uwqzdW6splmUzQElcP6XIGMK9UwRKtAYqjVtH6xo0w6XyfAw5BXKdnfGI9m9l
	 6us81wpI72W/54/JOPT+1Zw5IT/fYXWFzpgLwUFT0/ORBq/NKYjr0BXfoVqzkr+2Fq
	 doAeYkmVhV/BkrSoBCkdmSsCVhjizsQ+WK0mPA0gWeWpLtRjqpp7Z5TKM5JWg7pKa4
	 HaTmTa1wmnZEw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id C72D51AC56B9; Tue, 09 Jun 2026 22:28:41 +0100 (BST)
Date: Tue, 9 Jun 2026 22:28:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Peng Yang <pyangyyd@gmail.com>
Cc: Serge Semin <fancer.lansen@gmail.com>,
	Jonathan Chocron <jonnyc@amazon.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, pyangyyd@amazon.com
Subject: Re: [PATCH v2] spi: dw: fix race between transfer IRQ handler and
 timeout handler
Message-ID: <aiiFiRhec7a3B6Yx@sirena.co.uk>
References: <20260609102956.2811-1-pyangyyd@amazon.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ba+4Ppegdz71e9L"
Content-Disposition: inline
In-Reply-To: <20260609102956.2811-1-pyangyyd@amazon.com>
X-Cookie: Leave no stone unturned.


--4ba+4Ppegdz71e9L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 06:29:55PM +0800, Peng Yang wrote:

> Fixes: 0b6bfad4cee4 ("spi: spi-dw: Remove extraneous locking")
> Signed-off-by: Peng Yang <pyangyyd@amazon.com>
> Suggested-by: Jonathan Chocron <jonnyc@amazon.com>

Your signoff doesn't match your email address here,
please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--4ba+4Ppegdz71e9L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoohYYACgkQJNaLcl1U
h9C41Qf6Aw+TWGzKpQGe/peaOMLa3iqtO42BW+V4gI8FhS9JHsCbFTbRjxpzq69t
HOmrD/cdHG8MHfG/wdbGxGFcOES9AGA7PQgke3igz0RBcZYJ4v6ccrWMfvbbO2+M
Wwvb9IXdHcuVcIm46QApAiItP1c6hQX8k1hxWtmBazfjlu13l2WK3vgbNM8Dx7TY
ZIR5RTWVqfF23DfYPc6L5uljYGVDOowvUBuvm35OgS4VJzdPWetPgRmazrLt4nTI
pjeYyohKJyy1pI+XeXJm61A0en9/+BtwwJAtinly9tfAiE0AxvBnB6ul+/XbXXFc
iiW8i6M1uMX/WnUVhAcMuRu0hz2/2g==
=1Jur
-----END PGP SIGNATURE-----

--4ba+4Ppegdz71e9L--
