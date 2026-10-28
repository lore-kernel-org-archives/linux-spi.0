Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192368;
	b=V1FIdIiX1dIS6B03HphKM5ZTGOXcxBM0SLTTWSEXmz/dLH7w+i4dgeCbJctr7wFpplAU
	 MLuOpqCluKT+TF0RB82pTSbjK+fKDrkJpEleHfF7pUWy1Yb3zwupARdpzr6hiWP7eykgX
	 PXafEr0gQsnPKRlZ3AjJmi+Nx+rBHKmAqkXO+4OJGlKeVrswdnpB5XgXaABaePOm4FB5r
	 nQ8Ezj1/ygf66avdCwY1jzG4MazSVI2ydfuKT5sLT275+9zaABo6PrA6Iv7r3pHgehrkJ
	 f3Hz/HuTEB1vpkh8829PnRpbr00DO/JjNSRoiFKz0RJ9fw480sSAQHRw6PdnL3ZKoxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192368;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=7Ukhz+foZbHEWrgGjP8lji/Ry9Af0ETpCcrE+aHg+Uw=;
	b=bAtI8oUFmJFLt59A8tvOwVmroZ+OIMI6AU1e9dzBWcv/k/iA1QhBmJm8iYME397LNaFT
	 sxRirSk1gbmnh61gb7SmswDJi33Yi0b2vpn4WDFvvGDSn3wNJhS0tKXu/ySL48trALYxJ
	 Kn+kZLH80wMtfYIdQqsaEp+gqETIJhqq4Sx6FzbOezzzch8QKAc6UmOuslOtbwm/qtAHi
	 LUUglz85EDTdarJwmqARfZykichvY2LV/F93bZ4qFqMC2LdrT0jlNoRssZFbGPJfgRAjt
	 lHT9Jo64PDn++8czhMgYMhD2M9gTzf1h1WFdyTa6yPjT2TRuemJGRjwm9ZCiGrKXeGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hod/CvcS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15D606A320;
	Wed, 28 Oct 2026 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hod/CvcS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDF41F01828;
	Wed, 28 Oct 2026 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793192367;
	bh=7Ukhz+foZbHEWrgGjP8lji/Ry9Af0ETpCcrE+aHg+Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hod/CvcSGKGYWD7DlrMUfQbAQ5i6F6ec+swq+EgZt0PCWFrl4yOFUwI4CfFCfSYvq
	 IIhwCOrBRQisOzfUtWt6dLP540Hyk0zhrmjZQrlbl2kd+9u5IRXCOsXg9IqNVVZQYb
	 9UupWr6FNl+VjykdMdaqZJIh9SYeuJaDNaUWIuFNuDxxNPXsb2lGf5DhAschHBmaeT
	 WSHwEWM8FZ0EO5nDLbFq1anGvhZOOi9wqy4jM2TReYqNXUwrPSjC6SK6B0AfbPq8yI
	 MqHAKBVFnCQWWu+ka1ynionzWB6+5i9nDvyVA8YFx6nzc3agIlsFiMxWgFC2icaRyR
	 SQbnl+kt4pWVw==
Date: Wed, 28 Oct 2026 12:59:21 +0000
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
Message-ID: <8979e4ad-5209-4fb0-bd3e-95919849d2fa@sirena.org.uk>
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
 <fdc79c99e3045635841f68c89fec3b9d9e2f7233.camel@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="OsA/JmV6B8s4J2aS"
Content-Disposition: inline
In-Reply-To: <fdc79c99e3045635841f68c89fec3b9d9e2f7233.camel@bootlin.com>
X-Cookie: Pushing 30 is exercise enough.


--OsA/JmV6B8s4J2aS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 11:42:33AM +0100, Paul Cercueil wrote:
>=20
> I have a second patchset for spi-cadence-xspi pending (unrelated to this =
one)
> that happens to have some Fixes: tags, and those fixes conflict slightly =
with
> the changes here.

> I'm thinking that in order to make it easier to backport those fixes to o=
lder
> kernels, my other patchset should be merged first. So I guess I'll v5 thi=
s one
> with a rebase once the other one is in.

I have no idea what that other patch set is, sorry.

> @Mark, do you want me to wait for -rc1 to send it to you?

Please resend any new feature work after -rc1.  Please also do not
misspell my name.

--OsA/JmV6B8s4J2aS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrh8agACgkQJNaLcl1U
h9Ag0Af+J7jCK4vlB9pOTozhxgQrWlUhmjH9P6zCrUmUF1SImas2es1OELwnFMfK
kDvcvJKBdWMSZACbwCjP8+EBWY7bV9axlwuxMDx2DIuBQd4dDW7tHpIZgFqVeo0Z
RPkv0RS/kuOOb7upFxyYo4psGACYAS2GjGvbqTFysbG/gag9bEUb+utfUeWlX0xL
k5a+RzFVAtJi6wq+sk0t6pRlAWPugAJcMe084lDmKgFfMCGUDV8B6fL8Pw1tF7c6
/kWfzjPva9EJeKBedhraTEpZvIc45pdAfit0jKZoJDNPUPtOi9W8B+8HjPbfzF0+
6SNPZd4HkQV8rXHNVy/+C5JziS82Dg==
=IIp6
-----END PGP SIGNATURE-----

--OsA/JmV6B8s4J2aS--
