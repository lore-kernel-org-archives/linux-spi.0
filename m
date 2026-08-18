Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53F3346A8;
	Tue, 18 Aug 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058887; cv=none; b=YbCRsfWFgyvzgG7Y3K044cImlgSjbvgVzJng5NOrDi5l3JQ6cvVLR3D9goRFY0u56kMyldzXLu3o9+LySLS9SY5fkuFSWGhcp2ovjqQotRFjoG1yfl++uMYZt7cdVuG+c2lCQgTTbV1hw2rC29E4IjYbyXTFh12ogiXptZd9YW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058887; c=relaxed/simple;
	bh=yo8ikXsQN3snpu67JtKmAbi55HP0/87Ih/FPamOhafI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVG/JRGBqO8Acc7kKfhQlpHJZ5L04YwgySi2wcouk6RP7c3zHA535RGeYy1VVyNIjOaQE5UlZCEtTHaTTCxQ9fUZa8/NLNi2f+PoTa7rLMUlFKVBtoGF+wFgNY79etv26G87/H6BeAkXg6mCwEJInZPwtVJpyKv0wqESezgML0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6Mz5JON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6Mz5JON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8736A1F000E9;
	Tue, 18 Aug 2026 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058885;
	bh=yo8ikXsQN3snpu67JtKmAbi55HP0/87Ih/FPamOhafI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S6Mz5JONNto/xpitSy88eKC0uTEtFdl+6RNAZwsNO8omAP5c8dNy2D9pcEi1ffSDA
	 HXbebYthVY2YjH8ea4kR9zGo/3J7xx7/+C6s0HdMIUgWPpR0p6q35p9Oguj+yBcyHu
	 OZCihV+KLVj1MCIZEA0PZanhSZ3jz8ybVYSSS3zpJBTGWTgLBLvVQstwYuH4gXcGoi
	 YLWwHmOcNrX0L1h/5+yt7gKhPwXpYp8cmo3lMEebZBPt6mMx/1VSG0dhhGYir4b9lh
	 MzBysWOdPKrR6BxFYOBfV//iUbNKtCjfftap4doatdKz2c09whJlvr4faMH3FmuGYB
	 dCmowvTWVEkzQ==
Date: Tue, 18 Aug 2026 14:14:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiawen Liu <1298662399@qq.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: rockchip-sfc: disable runtime PM in remove
Message-ID: <3bf4d561-d98f-465f-9aff-68cabc6f1f80@sirena.org.uk>
References: <tencent_DD16C0EEDFEF4ACAFAB5A23EC8235D462707@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K96lpHhbSl2dZtMX"
Content-Disposition: inline
In-Reply-To: <tencent_DD16C0EEDFEF4ACAFAB5A23EC8235D462707@qq.com>
X-Cookie: Smile!  You're on Candid Camera.


--K96lpHhbSl2dZtMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 05:05:50PM +0400, Jiawen Liu wrote:
> rockchip_sfc_probe enables runtime PM and leaves the device active with
> a usage count held by pm_runtime_get_noresume(). The remove callback
> only disables the clocks and does not disable runtime PM, leaving the
> device in an inconsistent state and leaking the runtime PM reference.
> Add the missing runtime PM teardown in rockchip_sfc_remove to balance
> the probe's enable and get_noresume calls.
>=20
> Signed-off-by: jiawen <1298662399@qq.com>

Your name here doesn't match the name you're using in the From: of your
mail, that's going to make tooling think you've not provided a signoff.

--K96lpHhbSl2dZtMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqEWsEACgkQJNaLcl1U
h9DMCAf+KcCcyXPo7j8LdqOXlUjWViQgcLzlmsM2eiKWlA3fQ7dvKJYXlqc7iE2t
rpeNy1XfD3fIpkYn2C7OgC8brc6H7LjOVR86ItweCHS4hldCjxf5Ck1tZ5tZHSoW
dDXoTwq+o9DJTo56rKHnbEYAKieI1xA9V7HhXd8ltA2UkNav/ePbj6vqlUk6IzPb
xoW1UFzJi5dor+Ui3yJWDSp/ZeexJp5Vy9WnNvgM71wosY1egcB/aqTH+6oqIxxx
buLjQcCdE2KrCy42lsJ6Y5FjaO/sTZKCvr6JKPEo7hyYTmUQTvFeSUW+nsIYNIeO
qhNAS545Pr0mjAangiK+8zqqVrP2KQ==
=6fzB
-----END PGP SIGNATURE-----

--K96lpHhbSl2dZtMX--
