Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C163370E4;
	Sat, 18 Jul 2026 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784380474; cv=none; b=R9+YZGeQSPk5gS1Sa+SQPXguzhhgTR459yvN+eoc4DEzKaI39l0YWJdOiiXAvM4eNXMQU8URwNgixTvA/JbQI2+ZgfPiLMnCiSKVgWPvkdCbS2C/cxItDR0kU1DexeE0pziSntB8CrvFEaVFhBKL66un+w2rb7B/PywgS61E+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784380474; c=relaxed/simple;
	bh=slnQgl5Xul+RTPVcvZe7eiZ7QKk3Hvvsmn1VJpmKpsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A61BqnzrhypiOCTX8BVk81PesOmPssYmiI+HoWtBWfac1p04cLMZIjdpt8+mSgyZSyCCmUBZbt71alOsS7iDwNjaRRYE6Y9ii2dSvsr4yT/m9gbv0QfLayyujHXp7/SIffwLygpCn0Nly7XW5KJqkDKioDaKQi4fWj8PA14slAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrclbbNu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrclbbNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F401F000E9;
	Sat, 18 Jul 2026 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784380473;
	bh=slnQgl5Xul+RTPVcvZe7eiZ7QKk3Hvvsmn1VJpmKpsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RrclbbNuxhTiy2tgHoH0egQz+3MxDgO3m1LPBD3V8taEumVXzcbYXIGobV58LWCzw
	 v6HKuYFHcr/kUxkQGISUtl8MriSoWwf1+r09q7V//w2HOFBf0re3Bp94GjP5bfCvjk
	 6/5ARQ2JCHlkCujr8B/ccGV6aPixV20alkW2xv82qG01RMYh2ASR2z8mFiw8qYXrPQ
	 SBio7a7YBAZ+d/Rr0ceAJuVrjCEK+2dGbMMrOEUCVbnMfW5Hk3qae8FXYnZh8KKJjJ
	 DQcKQ+wiAxCnvISaxsiZXPciK2gdXDSJUAUaEhipkzOB7NUPaZgPFuBUolPnMIqXbC
	 gUrZWxz5Rrv1A==
Date: Sat, 18 Jul 2026 14:14:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
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
Message-ID: <2a5439f1-11e3-4194-a1b8-f00d0a8333b5@sirena.org.uk>
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715222417.2997712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sGBW2ufYMjVtgMpf"
Content-Disposition: inline
In-Reply-To: <20260715222417.2997712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Cookie: Do not pick the flowers.


--sGBW2ufYMjVtgMpf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 11:24:16PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Enable and configure the runtime PM autosuspend infrastructure during
> the controller probe sequence to safeguard chunked flash operations.

Acked-by: Mark Brown <broonie@kernel.org>

--sGBW2ufYMjVtgMpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpbfDMACgkQJNaLcl1U
h9AjNAf/WylOq05BOCIC/tng7hAQyeB+fuEMkg1QBvsIOQZAzyrz8SkX1P314DVF
0iqwQgHCbXjAp3/tlc5KTjchNTB7qdoFw8HLlV4RzrU3uhDQ5paO1Lj3teozxH+T
IzvIrjkB8FP1y52ZfTewzEE7hg7CH9hoC9ZHK3m/CdEETkTf1op+u6MXNnlyV7eo
cMGZ6sgNyPGW1Y7v+bbqBPUBQvCOgG4/5pZ6waIFIo63aVxLP3O342Dxhd0ZI+ZI
2VbB5Tx8raPu75U4/bs21IvrfmWiZ41/EwlPqdjqtXEDCMDZbKzY4yXGzj+HzIeN
v6x9Notm9n75dYijzitxl3i2iELGEA==
=uyBU
-----END PGP SIGNATURE-----

--sGBW2ufYMjVtgMpf--
