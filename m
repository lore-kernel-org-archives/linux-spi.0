Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198106;
	b=DZjrS9hlfGJUFOHdS1NTRe62viC77z0MXIL9z9dGcAtAVqYZqRMJQ4OKHp2g0C4aSZAH
	 VGEMNPCMDYhpkZHE+o9+r3BaynlVjgYM4x81m3QTrEsFaJKUKqbYCinu1qUDpeoNuc1Me
	 lQRgt0TOR2EOkKs9fmC6qo+v4P9E64oa5wUoW4aPAxYa8HvpbCqn/BZunWne8sijvBc+R
	 FaM6CVH/owOZkl4cEX6gamABFPFV4RYmU5k8F83RCqPjhRHW+856YWEON64NPv3lu8w/J
	 ubRwxWci93QQksX4v9N20kufPs9oIdrO6q9HVReiMR6bX0v4cwujuqAw9bP/nYCmvcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198106;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=bnNJbpqduWQXQiwHAnkGgrFtEfEJIJp2I+OMZwtwzic=;
	b=h1TVEpNbtTeCUQl4m2/vGTKA5UQ21qfkcv5vU1LLLM6qV8fJy9816e8DDdYerhiYIiDP
	 xBO1BQkLMgZxSfCMQ+10eYu8+lzE6a2jQ9RRSvS6ibtQ6OIsFTfjp1hfNKVx/NqqFQucX
	 pEYz2YGVCjdrqLtDfR/Y17H0xY/UKoUKhRiJqtxBfsWRXShwuJMrWOEFoD+/TfB4U8YgJ
	 9txqoEyeukgcNDyyx6s8qVHmAvaB+6KVlWCA2l2WJ3znsvGo4vyXe2GblPo6XRA8yDypH
	 15yCfxHbrhY7o4zXhs1/MkcX/7pDNwEBgC+6UIwnnuUDQ0Su4AnFj6h+SArlogZMSlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0YgkuBs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB92606A31A;
	Wed, 28 Oct 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0YgkuBs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8817C1F01829;
	Wed, 28 Oct 2026 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793198105;
	bh=bnNJbpqduWQXQiwHAnkGgrFtEfEJIJp2I+OMZwtwzic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T0YgkuBsdR804jUsWJpj2B/zsCd9n3tZvgdKCNt5UYd9zgMDJ8c0FqB4w27Z+AKP1
	 rtVTs2lw0z1WnDGaNJRAZ1zRS0LT38h2XwJka46b2ciG/oNWTJDeZWP8jQ4DFWh6zQ
	 1OFyb+c3OR1cg6moqRPExet86ph3aqIGacSBvtini3BuxgEIV9hyFgQAGYV2J40d/9
	 A6pFzAToEh4Q7m5QXiBhlaB590ccPrcLdf8O/ScvtwkbPVGXHH0gBUfZ7x6UbAXidD
	 yqbyXIhEsBxLJfWvG6LbrBxiEdvnaQxJynAWWG0RCYvS/u40CF43TJdS3MY5mQvhZk
	 eDxqJIIpWecgQ==
Date: Wed, 28 Oct 2026 14:34:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [PATCH v4 0/7] spi: Add support for panic mem writes
Message-ID: <15640a01-ac6e-499e-a5f4-37860c701f49@sirena.org.uk>
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
 <fdc79c99e3045635841f68c89fec3b9d9e2f7233.camel@bootlin.com>
 <8979e4ad-5209-4fb0-bd3e-95919849d2fa@sirena.org.uk>
 <cf96edf1cba37b775817d4df5f759b10e71c73da.camel@bootlin.com>
 <8c8cf14d-954f-4b33-a0e7-8524b1596845@sirena.org.uk>
 <7f27a8b7624ddbd0f7d32c27fe3f58df48a08c0d.camel@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="7NfKPAq3m99Mfz6P"
Content-Disposition: inline
In-Reply-To: <7f27a8b7624ddbd0f7d32c27fe3f58df48a08c0d.camel@bootlin.com>
X-Cookie: Pushing 30 is exercise enough.


--7NfKPAq3m99Mfz6P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 02:59:03PM +0100, Paul Cercueil wrote:
> Le mercredi 28 octobre 2026 =E0 13:25 +0000, Mark Brown a =E9crit=A0:
> > On Wed, Oct 28, 2026 at 02:15:00PM +0100, Paul Cercueil wrote:

> > > Your name is not Mark? Or where did I misspell it?

> > You added a random @ to it.

> I do that when addressing people in emails, I thought it was universally
> understood. I'll refrain from doing that from now on.

That's not a thing with email, it's something that some services use to
format usernames.  It just makes it harder to read due to the
misspelling.

--7NfKPAq3m99Mfz6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmriCBMACgkQJNaLcl1U
h9BK6gf8DMFrIAc6ZaxY5bDWI3hF9E+0urLGgv3mbK0FYpZDofbv+dUr89BC74zv
vdbtYfCaUxYNEVwkhZwUZIDiVDuII6d1LQtzMPOBz1OyBNTzaZRHN/UAeRXskMFw
FeGZ5fxTjlBLQY22jQsJrG9RnoUj89Zf+gqHQMKW5qwo8Ryu+8ES/93C6TmVxdvt
7IT2FzX/miZxFQ11GFG7cKNBsLUJ5F1oiRUE90KyoMv1B7NsKu9mj+ruoxvDWE1r
/jx4zQ5p8EM4GeWR3v9LXVjEKxIuJ2psj2wYiIJXdtL9AZrfgNUtoHfTbmB0htDA
2fuPw3hXq1tep0hGX/m8LicZTqGCtw==
=rvPu
-----END PGP SIGNATURE-----

--7NfKPAq3m99Mfz6P--
