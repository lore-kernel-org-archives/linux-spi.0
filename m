Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BA48E0F5;
	Mon, 14 Sep 2026 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409254; cv=none; b=gZWek3BvgST5C1NGyJKJkE4Ui0s0BElNaIgFkAPr3IH+ptTJia3xhVo3ygBoA55bCcGGpILv3cU/1INel4S/lsPyT5NeGd1oqf5400Ae8YNRUvZdVjRsYEd9QF0+BE7fgEZo2dyqqQe7GRTH9NcplzadLxFV/HmiaU6ckxYsJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409254; c=relaxed/simple;
	bh=WjgZ5sS7PFASU41GAEyepQvJrellvUJD+vnbo/dZmmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrMT1JNRXQHpF0zzeif5PHDJHwEvWUtCxKoRrbiif7T0mesKgsOWSyKVRrBDHr8d1/Nkhmih5aXEi9UWc7ewEkLGYYm/f2WuD2L3zljwxGnhu7a2zVeCwpRLacIFXbN+SQzx8tdOF6QIcqHQv6PcKefnyc9guYyV0Cvid++pQ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTvZIFwu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTvZIFwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618471F000FF;
	Mon, 14 Sep 2026 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409252;
	bh=+2LqkH1uelDs/ssC7yXt/q0DB4WBtY2PlWd9WPboDTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LTvZIFwuX2Xzox6j58mLWKAdBM5qeYZWak7HtTaWkY3vIfdixphs4/8EU+acLzCB9
	 IlXsfT1dm+Goam+SFnWwyN7kWSLuYUZYLPr7GfO1Ybkf+b/HIySkbn5RayiUX2VDY1
	 bgpt9flKd8gJOWuI6I5QSrKluZncd3t5ZBdq8xVakk6Owcc+FIL81WVgTQuruHx5DN
	 2j7DuThPKpBzowwalGCAsnZGfLTUyg+28NMIsUZwjdKcbggdkRj1TgrAXh29bq2vJ7
	 JCJLRat0lZbTjXE4JB+kzTzsuzIaQm4512VDxXQF+FWL33SwOysBdHSp/uhvghGrRS
	 7HCLabECSPwSQ==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 76B4EFDA6E9; Mon, 14 Sep 2026 19:07:17 +0100 (BST)
Date: Mon, 14 Sep 2026 19:07:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH 7/7] spi: spidev_test: print TX on error
Message-ID: <aqg31UHQ1nkNPNWJ@sirena.org.uk>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
 <20260914-spi-sun4i-spidev_test-v1-7-72d6a3b38cee@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dxKiEFZji3VOi5kA"
Content-Disposition: inline
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-7-72d6a3b38cee@pengutronix.de>
X-Cookie: Orders subject to approval.


--dxKiEFZji3VOi5kA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 04:50:46PM +0200, Jonas Rebmann wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> If sending an spi message fails, dump it to the console.

It could be very large...  possibly gate on verbosity, or limit the
length?

> -	if (ret < 1)
> +	if (ret < 1) {
> +		if (tx)
> +			hex_dump(tx, len, 32, "TX");
>  		pabort("can't send spi message");
> +	}

Writing to the console could overwrite errno here.

--dxKiEFZji3VOi5kA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqoN9QACgkQJNaLcl1U
h9A78Qf/dRoMP3vRYh+vGCDaDg6hwPv9i44v37xPSAP1FO+X8poksK/JCUshlsxN
/9EO0c4sWg/c0XDPqBjKertZrxFLP/H3hqrmjiYd0HLn5TD9bOt/Xd6DT9OaaDnK
dDobnGONKo8Jufbnabp4Hq+cI9aiQTr0R/po7xg0qOTv2FTAHnn4LkJqAEv2iYDi
AwYK1jpfcYa7G5EEjAwyE2J68JP3oFwv6BQTbpZpMZtd10FssAssaifmcF/sh7gR
UaNNnhZxgfAPX5wmFdy2RU2uN1S60Ci2mujYCHgRhhdMuTGsTCursN6LQzi2m3CA
dO9fs+rlvwSw2t7CAuv1ZIYGqyMdQA==
=mZYT
-----END PGP SIGNATURE-----

--dxKiEFZji3VOi5kA--
