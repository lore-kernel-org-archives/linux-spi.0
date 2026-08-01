Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319831355D;
	Sat,  1 Aug 2026 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785544088; cv=none; b=nbxWziBWXIQ06ejh0nwz8zWZHl3l+XnleLN7aR6fxZoMvmllaWdv61unyrVTPFweg5vXnhkE9MD1hG7vX/3m0YdBgj/59PnMSVkRxbMq76A0DRrnlyY1IDeHEc4Hb382mMt4b1PR8Fam3y8jCj1SxwA9PUv/ySh0pX9Tq9hXHRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785544088; c=relaxed/simple;
	bh=zyvsI6uwawWAwqKjSXAVw9YoGBSiHEuDHThuZ+NSeOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hzugm6g/8wcRTMpMYGXrg6t9poq6UEeTWhvB89Q9/LOLBT7aCe4xOfmm4BCvkOFC7KirPWXFW68vXmLnFkK51HiXclPHXGrC/2EZHiUHDg0PHi3/Vg0BIqOyLOKonIfhLEieEujati684qkmvRoY+fFaR3zwShWoQKVtJZQh1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+Vin6By; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+Vin6By"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581E71F00AC4;
	Sat,  1 Aug 2026 00:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785544085;
	bh=zyvsI6uwawWAwqKjSXAVw9YoGBSiHEuDHThuZ+NSeOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y+Vin6ByVZPLXW+GbCCZjaOjIVxI7ftgZf/STQv0b85G55jywIfBpD4/f030DG3Yc
	 j1FxUnGqFQid+MUdFD/a0pOS/U+PctO+DMfZr8cLh4afbZn9CacShgSR3QwdnVlCm8
	 R6rEFNNuALz7bxx3j+uBxKHOYeR2w7AkyTHkTFf1a3SxYsv1fPYBU1krj+fDWrnUrw
	 poVIYxPUhscJLk+UgaGQeHJrRBAgydkQTvaarIcADBOltxKYTVXcMOlBhkv5TKM9W5
	 LwNfLKuLdSAy2HRfBEB015uJUN6XTJ/aqvf1pqtrLB2YJ1h/sv8gu0IefRheZhtWd6
	 2+zXe2aYg/fEA==
Date: Sat, 1 Aug 2026 01:28:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: linux-spi@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: meson-spifc: fix runtime PM leak on remove
Message-ID: <ac668d52-044e-4773-a536-aee93951b408@sirena.org.uk>
References: <20260609052647.5-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tX5RgUt+OYfDuz3t"
Content-Disposition: inline
In-Reply-To: <20260609052647.5-1-ruoyuw560@gmail.com>
X-Cookie: No shirt, no shoes, no service.


--tX5RgUt+OYfDuz3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 01:26:47PM +0800, Ruoyu Wang wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even when it
> returns an error. meson_spifc_remove() uses it to resume the controller
> before disabling runtime PM, but never drops the usage counter again.

This doesn't apply against current code, please check and resend.

--tX5RgUt+OYfDuz3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmptPY8ACgkQJNaLcl1U
h9BRqQf+IrpsnI42a2rWBAeJKiqWSImUiBcS6q83yoQRO3kOZvi5o8sbchcevVTq
IvdhXV5EYlYNdzmRI24L8swk1FvKuX5ylFnd9W1D6uXzv7Ga0HqgWfn+El27e8e0
/h1NtaF3f6bzwKSCi9EFw2nRsIddiYbJaPH27kqj2Jhb0YhhaFNCYb8vN4gL7qu5
VYVfgJmroTAmLXVgdwcEkac89ixy4cH4sVELYw9c89kVTTnpv+MVEOQuggr9J5V5
4JtnvaYkHo+0hIcjFNg6Z4YJokkABi0bEN8HLxxXRHGzzUwmCE310JIEJfd8AvpC
k9F1tew+FhhK/RnvWm7nfSnWCu9HpQ==
=Q2v/
-----END PGP SIGNATURE-----

--tX5RgUt+OYfDuz3t--
