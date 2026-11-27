Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795755;
	b=ESBl/8IRwiCwgUUEFJDCR7VtJF/ils95FT49EGG3c1O8vMyIwKRgQJwcf0gR7k5yn2NA
	 z2I8Tt00vxCMYappWDciANsmrSG2Qym7NgSYRGsj9C34F/888aXdPz10RbHUu+Mzl6mhs
	 JSsZGhBxJAYtPoJc/nkE8YhZr7oadgT3xXJGuXEqWcOYmiik383tc8xlosGrsUMnzzRju
	 lpUBBdRsSoMm2KOQy3SOcicd60dUPHTkeho9uNrlKJaUxh2meeI0CeJiFJ5DzWI0aYdBp
	 bYgmZrhOESjjmYd/ZedTVM79qzg/Kgr91qWAVh+fPevDmR4FQREi2CvUKeZQMrRqcHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795755;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=Ml4VwIKGOiE8YCDXqiSrrOhJQR4Oh8LsFKsQo4KwMkY=;
	b=F5RzbJ/G4gBohs4AOKRSLGg2Z5FYkS5lJ+uK3c/0R61uy+a1D3k0tT0aYMTxOW2zITOy
	 Vjxf27n640gMfRI2EdY7XBY//LInsWbvx8ECw5XhKaNqwaJvc0EfmEuHKSh171LYhrx3s
	 P5EDDrhk22Abj0wNf6KkYgLpxdZ1JDspGueVQWvZhzIgHAw+bMULrzu2fOCh11gCTBhCD
	 zydAlWYCgTVHKMq8xysCHx+WTXrEshyCw/odsOi9dojef5UNsZEQZxUyOYH4vS1pqospt
	 8AVsPICEE7Kdz+L9FYYWICcdjWSZn5iwTuVBiofnjneL4cjvjTmPaDeJRCRQQdSrCaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AsI/YOK0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDA606A31C;
	Fri, 27 Nov 2026 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsI/YOK0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541091F00893;
	Fri, 27 Nov 2026 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795755;
	bh=Ml4VwIKGOiE8YCDXqiSrrOhJQR4Oh8LsFKsQo4KwMkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AsI/YOK0+WknOqRvkJOgFIYqtv+F9m7F62C0CF5HywY9/EFulnmy4nLPBuyGHQTDz
	 vhFU3i+9JCn5HvL8qNKc6QZ0SPHlXmzIbZvasyZizyuKZRZGTHo97hWTMy8jc8a7ln
	 NbEZPQFk0vxYlhQ5g7K4uKioYC0ewRjVvcDD2yTo5/VZ2fMxBf6/LiyQ7qrkZRYxjS
	 41hbMTDH5W3/3UvFQ97vIEafQw3J5WXWWnhtILcUzOutw1nCGMx4IK2RPuq0c4EYaW
	 8QB76M1eK+CXppMH6qCHzz211qAVOLR12AKFrRZVdoXKPKMq1VDRMkGDbdeOc/eN0x
	 lFw98SBur0Mfg==
Date: Fri, 27 Nov 2026 16:09:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	George Cherian <gcherian@marvell.com>,
	Witold Sadowski <wsadowski@marvell.com>
Subject: Re: [PATCH v6 0/1] spi: cadence-xspi: Fixes and ACPI changes
Message-ID: <ff6d6dde-65d8-4673-82ab-020e4cdea50f@sirena.org.uk>
References: <20261127160759.249979-1-paul.cercueil@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q1Q0f2FUQlODdKPM"
Content-Disposition: inline
In-Reply-To: <20261127160759.249979-1-paul.cercueil@bootlin.com>
X-Cookie: Sank heaven for leetle curls.


--Q1Q0f2FUQlODdKPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 05:07:58PM +0100, Paul Cercueil wrote:
> Hi Mark,
>=20
> This v6 fixes the remaining patch of my "Fixes and ACPI changes"
> patchset [1].

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--Q1Q0f2FUQlODdKPM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsJqyUACgkQJNaLcl1U
h9A+NQf+LpMvjphDksURME/FU9wSeARpnqlX8tKDb52jj3P0wnz6OPP7foOwdRLt
NePI2NijniFollDhSvHpQ1uYhv/ucj8p3Si4jia50dr4TE0QRe1wrbr/8LJoPa3C
yUBGx4sX7WewKccRB0W3HwOsQ++luXvk/4hGLf0KsFm3lIfs+qP0+nEE2xbJt+sq
E9FAajq1qlkr5bj6+1qf7qXnj2GEoQ2JUnnxTjWghWqol0XxqEyFLE/3vur23CZk
L3UO/xlGSMnBv5D66u4ScRWxUirf6Y3MNmK7lM2uwfy2BgTUqw8alpilq9l9u3XT
DT2fhZtDsdst4fVTRA0WRiZk65jgNg==
=xQ8A
-----END PGP SIGNATURE-----

--Q1Q0f2FUQlODdKPM--
