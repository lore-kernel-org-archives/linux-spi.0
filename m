Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2A429033;
	Thu, 13 Aug 2026 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786656840; cv=none; b=s38leq7t4LEDxaydmaQHRLRy8ma+NsmLBOxLiQUtEpnQqv5rgtED0PfXfmzqkAMsduKhCWT92AQnrg98/ckjXH3UR1eYIyxtFnRpNd1wkbRoBtXI8djZbdD/uvAU9xpQ4xeObslXeTyUofnlC887FbW4SRHYWOTrCjKcNVb9Z4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786656840; c=relaxed/simple;
	bh=/2V7wfkgJYiDLYrlGutVJW2ZTX+HTrZ1vU4KW79aw28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gw0GFgNsS/ZPUB+lIovdqeZXKK/FB0idvTcxa1kwhthWvXvWfY5bY8KTHQvL841MVO3zH08aI1mKO9yQL9ZVB75bb6ZT4pzjJpUIWia8Yw/ywq/OJwq5JnZWEsSFgYR3vz9uCTLqk8KFOR+Gu+PtqxiAoLs+LWrNRYaRFHif4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS0moFFF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS0moFFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F621F000E9;
	Thu, 13 Aug 2026 21:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786656839;
	bh=RJmCPul9jOqQ/QdYG0814B9QmndHxDgtfe+WTkVwZeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KS0moFFF0rJITVVbOktfgUKvpVxgrVDDBPYx1NnyUMIWpFA2fym+YrnoXEcAFEC+z
	 Pf6qZgmB1SojQqV3DbqFeyXjVm3MCCfEJc22VTTnCuvZYZlOuCZLCVt2jb8lXEmgn8
	 K0yzSb0lb8xZoJd/DBgG7za2GgvLuiVbnYzA8EGHQfeuFCJ8PN5IJuMiyneA1lrJDv
	 frsXSzCGRjghvcb0q2rCwHNAxPcyzlqCzlkc1mWEvLJyvwTtIpObfbxDQwvPlkC+wk
	 E+O9ST1kdCy8HpOptKG2YW8U3Izp3sprT8kEfqMoDK3FU9a8AbMUwnaogYxRAKykFd
	 35TIr6ysbh9WQ==
Date: Thu, 13 Aug 2026 22:33:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <STLin2@winbond.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: ma35d1-qspi: Add DTR support
Message-ID: <09c3928f-4b58-4ac6-8e1a-84dfe3ff6b92@sirena.org.uk>
References: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
 <20260813-perso-ma35d1-upstream-qspi-v1-4-b217b9870eb1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ofwh2gFKdI85BSw4"
Content-Disposition: inline
In-Reply-To: <20260813-perso-ma35d1-upstream-qspi-v1-4-b217b9870eb1@bootlin.com>
X-Cookie: Immanuel doesn't pun, he Kant.


--Ofwh2gFKdI85BSw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:00:24AM +0200, Miquel Raynal wrote:
> The controller has DTR support, a bit must be set for it. The behaviour
> is interesting though, as the speed won't improve when enabled. This is
> because there seems to be an internal divisor (/2) which keeps the rate
> equal when DTR is enabled. As a result, this commit also doubles the
> target bus speed, which in practice does not happen. This way, there is
> a real gain:

> @@ -567,7 +577,8 @@ static int nuvoton_qspi_transfer_one(struct spi_contr=
oller *ctlr,
>  			buswidth =3D 2;
>  	}
> =20
> -	ret =3D nuvoton_qspi_configure_bus(spi, buswidth, dir, xfer->speed_hz);
> +	ret =3D nuvoton_qspi_configure_bus(spi, buswidth, dir, xfer->speed_hz,
> +					 xfer->dtr_mode);
>  	if (ret)
>  		return ret;

This needs ctlr->dtr_caps configuring, otherwise the validation will
block it - only the _mem_caps were updated.

--Ofwh2gFKdI85BSw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp+OEIACgkQJNaLcl1U
h9DZ2Af+Nhsdzbp64ywAW88mtOuZ/FvF8klN/5pJZjRQzBM9u/Xw6tkIa1wfMTEa
rubL4TJK2bNU7LG3vghKhkFZ9Z9E1GPYNHOPzQ42E0BWI/T+sCeMQdQKcCHWpiFq
tADVc3oMY8vjymgRSzDU53flhddz6GREVOgoPy+LrRrjktCu84481I8YbMVjZqqh
BXc4yo15EgqxKK/qckLVqpq1bNS133PJrA1xPT5gQSsPfr19uHRs22AGot0Vdd2y
mSchqod0ciOlSQBQ+k9YfiYwpacrPZ9qIm9HJgULjKyk8vu2YZ9m8sK7BVAPSeAE
cH4Wwpf6YPp6rElv0Wzo4CDGbtmTEA==
=mY/B
-----END PGP SIGNATURE-----

--Ofwh2gFKdI85BSw4--
