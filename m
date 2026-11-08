Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146386;
	b=fQKc8cvXEv8BGeXA+vXh74AgnW9lnpLjcGRaEMxAi2CNKG+7+fW4OxKnYfRMCZMcVfIU
	 EMiXoRCE9ch4JNJJKzMdBXlJMjpIzB3K1f2UgY6UX9PsGebCg4uSDfKoQhDE/+9H9zgpW
	 62ZtCNTvHd8RAN+O+OjVWZxkuk4LUuK/BL50ZM9RCtf2Lo5ceVE36fnq87da7VnWr1WEu
	 Ibqshj9kLz3HNrXMCE6XXicKGIhNDnL6f7sU1RE/gVVbh/ADvs7lYEvhCNuFx3upH20Jg
	 dZAJU36c6I53vSitfNZzGbtXjXhQPJ2bUfQxECFntN/VcdmNv0fA0E8eb6iBEOFUohw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146386;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=mQSfBX6F6IHjE1O06a2cOPP9axg3OgBc5PG1BzdydBI=;
	b=j18C2kFkHOzq80KZPvVD0jTOnZi9p8BvumHUccxez9TIehPtQ1ferHAkZ/mjvkQpHd2N
	 ihbJDcFjRAZ/+zGrL6QyaoRcTCoYn+HNCJ1os4ajB3x199hRfNDsPjMHJn+A4T6kI2ASy
	 dOBCWzol3kBHVCmwuD2xR6SL248Oo2Ee5EPCEQQhJVr0ojBuwPT/kwFW0RfD2frm7nnhD
	 swqrp0iVs/c4FbIskxrEiIDyecD+WEfzK2V+DvfPM7M72VQ3QIdt4YFtKeXQ98bl8K0AB
	 uXIF88FgtnmRxg59NDtk2J5YCZ+OmJi3hqbiZosUQPdM7YRomkNcovl/GX8R/JBsMZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjW6J9wb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C00606A31C;
	Sun,  8 Nov 2026 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjW6J9wb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3551D1F0089F;
	Sun,  8 Nov 2026 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794146385;
	bh=mQSfBX6F6IHjE1O06a2cOPP9axg3OgBc5PG1BzdydBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OjW6J9wb2MdiJnNMCuBB3FrXbCI/KhyyWNY0hHupBPvoY2zZjfH4x3oOyhl0Ga4j7
	 e6v7gBDhhevfExFqIEKZMFgsbxAS/0F0w7QejcCChd4sZfP1MJQXdu1GG4judk/57V
	 3/jTl2jRdugXaE5ekSpbjgWmcJxRqBT8j8DKf9Mdiv3bFV3hb8YtyM5mXFZEBq3t2L
	 qB6x7ODLnuZUpjzULTGJQ4jyCEoZ89Y7bpnNFIYpD8SjmwFZfucIuSrQRGlfaY7ZXK
	 m6GZIuObS1e+QpET34WVSlZIvm/iJmDHPVlGY2zIdoliy/uDYmLp4Jl6vFnupwoVGB
	 IdLRaWH77w99A==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 0DD792C79621; Sun, 08 Nov 2026 13:59:41 +0000 (GMT)
Date: Sun, 8 Nov 2026 13:59:40 +0000
From: Mark Brown <broonie@kernel.org>
To: zhang san <shunsheng1218@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] spi: handling a stuck queue worker during controller
 unregister
Message-ID: <03d73980-f558-4dd4-8ec1-a8d40bd2474d@sirena.org.uk>
References: <CAGTEBTY2EhOHwmWhB0_YdnP-nMyGzzhnwH+ta9yeynHD-Y0JyQ@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="W+KQ+QYjTE5dSzuu"
Content-Disposition: inline
In-Reply-To: <CAGTEBTY2EhOHwmWhB0_YdnP-nMyGzzhnwH+ta9yeynHD-Y0JyQ@mail.gmail.com>
X-Cookie: Whoever dies with the most toys wins.


--W+KQ+QYjTE5dSzuu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2026 at 12:57:12PM +0800, zhang san wrote:

> Would it be preferable to ensure per-message ownership of the
> controller and child device until the pump has definitely terminated,
> or is there a safer failure policy already used elsewhere in the SPI
> core?

I don't think this is something anyone has really worried about,
removing SPI controllers is very unusual in pactical systems and there's
liable to be plenty of other issues if the hardware vanishes.  Your
suggestion above seems reasonable enough on a first pass, if you post
the patches I can review properly.

--W+KQ+QYjTE5dSzuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavCASQAKCRAv73Ows9A4
iY0QAP9FCtH15yQYxNWIefgxeXd23d8ZwA7s6cIyXLHbGGtHuwEAkUnqxZWWyR+C
hdsJOfNhomumq16CCgzwNvph9CEO0QE=
=bEIN
-----END PGP SIGNATURE-----

--W+KQ+QYjTE5dSzuu--
