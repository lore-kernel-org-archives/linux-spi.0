Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3A405C39;
	Mon, 20 Jul 2026 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548276; cv=none; b=fKGwLmmBjXVa4171JzJePV9DgUtcwO68UN1k9VFer8AGWkF963N9yIQHVRT30YziLchhRrL2TFe/Hx7Q2gY4Imk9JElJkoVm3P/as+maJB6Q80zEFYZ7K1MvFSXN6mLZddLk5cBT47KYTMfV8m805Yy1vSYUWXxn6KivZBcqaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548276; c=relaxed/simple;
	bh=bmfV0wi/YJ5NM9kBF0AkHPqJ4wgU4QAbO8fKxugQudE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxG3O4iNyBVUp7lepZfrDINyf4NHGEZdP2cmFyk7WrS3w/gB/go9NfyzIMWsRCiCFYmz6Zn6j3GmTfT2+g6ZtpSYuzeKPjCqiFHttIRPw6xwBHPyvc4HDB50+r1SKCTNaFgTlgs9jkLPCqi1fl/BQuV4EVmpsmUPqUbWPo5niLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8NjpRha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8NjpRha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87141F00A3D;
	Mon, 20 Jul 2026 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784548275;
	bh=bmfV0wi/YJ5NM9kBF0AkHPqJ4wgU4QAbO8fKxugQudE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y8NjpRha37WMTxu5w8m9w/qLX00ZHY025G83j0rOoouYhiNriX1x2CWLfWrvfyFUD
	 U+GueNa/GimlUmi99t3Ph4YZL7kz1NpjyymFdejTZsTmGhGCK7RT9rhDb7/6WyJzEo
	 QRKR7WB/kOTAhGhzgB2w3VmZZo+jm58UVW1Vx7h4JQQrPOM0IukVfXf5sMgmdAZaMD
	 d+eqvyTRXPhcsT286zBmGzvHogaYyTPbDsAbpvd5TtxtXi9mjb8RdsiPcV33Guu6ZI
	 Uhd/mLp6kdGTsr2TBObJ1ayMVAdhHeyXByly0RJc5+QWns0szR+8yqQF+3jqpaUUXi
	 Za+ycZA98znHA==
Date: Mon, 20 Jul 2026 12:51:10 +0100
From: Mark Brown <broonie@kernel.org>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6/7] spi: spi-rpc-if: Implement 200ms runtime PM
 autosuspend delay
Message-ID: <0c5248e0-4141-498a-ba01-e6c4225b28ac@sirena.org.uk>
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715222417.2997712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2a5439f1-11e3-4194-a1b8-f00d0a8333b5@sirena.org.uk>
 <CA+V-a8vdrhnZs+1WyVxWJ7Vr+2A2_3zsw1z6bNUqvGi4OGHH0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TS5FRL/l45qdh++g"
Content-Disposition: inline
In-Reply-To: <CA+V-a8vdrhnZs+1WyVxWJ7Vr+2A2_3zsw1z6bNUqvGi4OGHH0g@mail.gmail.com>
X-Cookie: Caution: Keep out of reach of children.


--TS5FRL/l45qdh++g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 12:45:29PM +0100, Lad, Prabhakar wrote:
> On Sat, Jul 18, 2026 at 2:14=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > On Wed, Jul 15, 2026 at 11:24:16PM +0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > > Enable and configure the runtime PM autosuspend infrastructure during
> > > the controller probe sequence to safeguard chunked flash operations.

> > Acked-by: Mark Brown <broonie@kernel.org>

> Since there is no strict dependency between the rpc-if core driver and
> spi-rpc-if patches, Krzysztof asked about the patch order/routing.

> Is it OK with you if this SPI patch goes via the memory subsystem tree
> along with the rest of the series?

That's what an ack menas, though if there's no actual dependency I could
just take it.

--TS5FRL/l45qdh++g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpeC64ACgkQJNaLcl1U
h9ACqwf+PCUo75JJAoOU0oMvEOSKl56A3xmBWFMjDREsHazutxHImf8QZA5nXiBY
qTPEaznGek/vnIUk9CQD4veSMp3JvVb/vs/9OvrDzsLkAYB2db3j+N0rL4rZp0ZJ
kkprcJynkY/R4kk56yu/v25vfp4nbGb1LwGFFhEeAq/Xr43GlXuGaJpHCus+6xIw
IEq/S8ty3vj9zWOD/mUv1dZ5pLpcyj82v1K9RYQCKvST/KQnIFWivUjAx4YxWGBN
XxLJ/UbFrfRm93lrHz4F97PzbNWj0P3q0Hsg4XCCRW1HIJ+juA5q8mUHm1tqdu6p
d0rVVtjD2vFUxQ/7IjeEHqGsje4EGA==
=jyqa
-----END PGP SIGNATURE-----

--TS5FRL/l45qdh++g--
