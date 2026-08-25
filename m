Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D49449995;
	Tue, 25 Aug 2026 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662850; cv=none; b=gDHs3VO442xV7po2Uc7xSJ2dcjODX/azSfxtOA8KaLDpFCbIE2w7qx+qpCidYT7OSALSPbwNjZRBzAqXlH4FzdLoYdBjOoFzKrOi8GQ5PnZHUwaqv69Azt6EVP9gPSpvQAiPZvpyQMgrNE9lBLIohFftieysuzmUiuTC0Rf5anA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662850; c=relaxed/simple;
	bh=wL/N2Qiiz6hamMo/R3fJyDBoeNKohHGNKswT0wQ0CLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWZdUGTdMf8F4R1HGu1tBtnNxcgJ9B58InZPVe3Bk4lMqIz2MEjrdGQMsWM6zOz1YRVjwWbOCurYTfMS6ueGqLysXVtDmTCgiwZMfeVksaU8AyiZJOYs6xBCIojXwpt13vhSkKtakR2IRu7Pe74Sywhy4roE7E4IOjO0FNFPIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m44c7z3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m44c7z3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103081F00A3A;
	Tue, 25 Aug 2026 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662848;
	bh=xzeffKlsA0Og3JCahi4fY9iDsdZZ7DPnXWl+yIAxEYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m44c7z3stYpQr9xKGHvITihXewDGn33+j+2LeqUR3Z/yaxHzr8z6cDC2mvIc0b2nW
	 Dpvo5KQ3HqG0DP7cTcFlUTUj73SJn94jslIdMWUVJz54HqO7Mu/Jau8rkduYzOwx0h
	 xsUalOBUM29AzBO3DnTpfspkd2ulYrQdsxQfmEIKdgugK/X1pAZXievO5TgrtZXW1s
	 bpssfkJh/WGeHOKlqbE1odpYyEWryVi1dEDYwKwP9Lu08M8GEHfOsrL2yKHqt1TwO2
	 qsK4wa3uS+WGHiWT98HoLtgQfd7Mj+yCUDsZXGiNEeIqSDuf95jFku4Ai6PkRBlOKy
	 A2r8O03gnyMBw==
Date: Tue, 25 Aug 2026 14:00:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: qcom-geni: rename setup_fifo_params() to
 setup_spi_params() and make it void
Message-ID: <5c7b5f70-187e-4409-af5d-c22ff97cde8b@sirena.org.uk>
References: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
 <8e4684d0-d130-4c75-8b28-11fd98fc4a29@oss.qualcomm.com>
 <lxif5gsyfq24aq3vsiing7xufwdmhllmn3gzdm4sqopz2ttele@myvffcz72jqq>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QC6jBq6dKjmZ+BaB"
Content-Disposition: inline
In-Reply-To: <lxif5gsyfq24aq3vsiing7xufwdmhllmn3gzdm4sqopz2ttele@myvffcz72jqq>
X-Cookie: Exact change only.


--QC6jBq6dKjmZ+BaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2026 at 01:09:40PM +0300, Abel Vesa wrote:
> On 26-08-25 14:01:10, Mukesh Savaliya wrote:

> > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > ---Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

> FYI, there is a chance these might not be picked up by b4, when
> applying.

> Make sure when you reply with tags, they are actually part of the new
> message.

Never mind b4, humans like me will also struggle to see what the new
content was in the mail.  Please resend, it'll make life easier.

--QC6jBq6dKjmZ+BaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqNkfsACgkQJNaLcl1U
h9CZAwf9G6GUe5l5fBDYSQdcIeIQ+3pHduYt3nzsJLFYLqXnS2gZQ1aU3uXgtGJF
eUEcMWWSwMIbHMczUhBI/TRKcwN4cDVYrSlzYJMllBVOhGy3HcmBlQKSP7w1dUNN
PiNOw8NmjASE2xh7wCW6sM6N6Dv98cjzqw16h81qTlU9k1d0nRogGfHHLq3i9zEG
v+jQT/KNt2fPvjEwDoKKP70hZCmVLYy5LEBcSqXFyH2UTHbuBm3LuJHGVhuoFAU3
3j3ap/XUjUmoGuW8RX7Qb9wVwYCV+qnfAvqkC+22UBOOJdfyQOZRq5tFgDI4YXgE
7rFtunAHNCkRmlfTQoOB8ugLm/iRUA==
=5yf2
-----END PGP SIGNATURE-----

--QC6jBq6dKjmZ+BaB--
