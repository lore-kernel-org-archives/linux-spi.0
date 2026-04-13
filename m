Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA13CB2C1;
	Mon, 13 Apr 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776088886; cv=none; b=DW6bcm1WuNFreTeVYqWxBG9EaekqlIbkjVTTmel9rGeawcAOGRfw4WDMNBnCiEH6OyUi890Y7Pq/q0KWP/kbA7RbjzVsXNe6oqx5C12JO4dbcwylF6OpqqexdLDx/pJeMei8I9r59lKAW2GDSFvQ1jy8eUymUtQbqW2EuhAhPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776088886; c=relaxed/simple;
	bh=bs1HgUKnMx71fMXMcSruYQeb51hkTW349t8XInj6qNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMhL922fv4nvJls1OFVjIooPUXikMvlRPWwvn9CNB1aL6pJwh6KCpZK+cDi+T9cXd2UbeAP2lbWnWQ2xTiryYxOyibI7IALZcIWaRoKgjOyB56/Ta36Mr40lMiOZue0VQQaBHnhnSoeGVsfKfB7W2koScfGfVOYH8YMYQFxJroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRrOB6y0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRrOB6y0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88A8C2BCAF;
	Mon, 13 Apr 2026 14:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776088886;
	bh=bs1HgUKnMx71fMXMcSruYQeb51hkTW349t8XInj6qNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRrOB6y08XiGBKGWMyuJzK1dFC065elVRDPLqf9UArKkLwkeARYUVATxDJAvy3EEF
	 ikR4saHhDk/VVTbmy5TfBS7JxWm03/2CaeRvdokEmqmK63tv23QIhHiS8YVqSBAmVP
	 86mQZc3PFB/TJAYj+qw3Dn082N1X+liXaw59KzI65tmjX8KeID9yMnnTfB89Lj70r/
	 5TDKJUZxZhYaoiYbELldkdIucRZBGj+iVZ10WqBoHab0O6FFLvYelMftdRzbCggIR1
	 REIrsVA64eXMfr7AoB3yLdc6pXGgT7xp54QPQSY968cusx3pBspbav4yl1Gmv0KO05
	 i1dk8PqR/odnA==
Date: Mon, 13 Apr 2026 15:01:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Khalil <khalilst@gmail.com>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
	rf@opensource.cirrus.com, linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>
Subject: Re: [PATCH v2 1/3] spi: Preserve preset cs_gpiod in
 __spi_add_device()
Message-ID: <f6ca4665-ecb8-40fe-943f-d80b77f16089@sirena.org.uk>
References: <20260413100530.580649-1-khalil@rentman.nl>
 <20260413100530.580649-2-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sThPLmbfX26n37mQ"
Content-Disposition: inline
In-Reply-To: <20260413100530.580649-2-khalil@rentman.nl>
X-Cookie: Love thy neighbor, tune thy piano.


--sThPLmbfX26n37mQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 12:05:28PM +0200, Khalil wrote:
> __spi_add_device() unconditionally overwrites spi->cs_gpiod[] from
> ctlr->cs_gpiods[cs], even if the caller has already set a GPIO
> descriptor on the device. This prevents drivers like
> serial-multi-instantiate from pre-configuring a GPIO chip select
> acquired from ACPI before adding the device.
>=20
> Skip the overwrite when the device already has a cs_gpiod set for
> the given index, allowing callers to preset GPIO chip selects that
> aren't described in the controller's cs-gpios property.

This seems like it's almost certainly going to break something since we
just silently discard whatever the controller had set.  We at the very
least want to warn about collisions here, and ideally teach the
controller about bindings so we don't get two bits of software fighting.

--sThPLmbfX26n37mQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnc9zEACgkQJNaLcl1U
h9AVswf9HylTM/RQVvRdCX+AGtQEAP4z6i2mcZ80WcAXNyGAtB0lWKFLzC6gSrBm
uUg0YHlX/Z7n65+uJPeg+uxv+V6aPypwNvqbFyuLw8CuUleCvmZRYEbXiuwHC/+E
AFA0bK0TkkxsuzhGq70UVsrgT12rs7ZT/ZaMSWlU3GARJ1p10xYU7nCzTJauT3H5
2hbEIff4O8Wc1vTvC018UuCrEiCnZQRnqzKTnfe+Y2nDuWthzGhYQoB4+HOMvDda
w2o8YfIaSW7skaO3/AQ+iG3AG5LB2MMJLjMxIlZRQrGcYQoXuMCohzQgJ1EGblFC
VXTe5b9tlC0evfs63L8P/Kgo/w1rkw==
=yE9E
-----END PGP SIGNATURE-----

--sThPLmbfX26n37mQ--
