Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9E32E728;
	Tue, 16 Jun 2026 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631113; cv=none; b=mVEg0psHb9pEmohsAwy9+FXbxZr6xowLOMqwYDYkN+kb7I6sz/f5mUdlz9Kgylm8C3EN9X/NmhTKMLuYg75YwCgn1f9ZN/I4dGnvQQURUMmDU47KFo3wzVQdNhs6xRmL73OvAa4i5HYY/mKxB2BBC4jSUTDQMMftYJ3BmYzCZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631113; c=relaxed/simple;
	bh=lTbWSIN8WkU7qLILFckWZbByrkRB5V9iFbzpidvHsac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhJlFt5I12YArdqY+ihcc2Yb4B93jU0slFV5Wq6VxWOOBIdt6SkAb8woC9RxzFWHcReXkHjCRtu84LeSbBiMl+wbj90JUfGTL5J4cZKbmMdCrESXLxZ02czumXzWbJA6H7/cxhXdVFTy1mvHuQUYVKLN+2KaNlXgraGdF9Bo0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd9bV+vy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd9bV+vy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3ED1F000E9;
	Tue, 16 Jun 2026 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781631112;
	bh=wYW4y+vTabolZuVjOd+phVDV2clwSeHN5n1YHr8LuoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vd9bV+vyzmf6Xojfbl8SPwS6IPz5A7LGsCQVhkJ99+ZBD+R+WBoJ1iW21BYrXdEd7
	 S0Wt7WbL/1okmnf09QetRSaactzKZL8QNtJs6X2SANGdevpDvuznm8pokidj8whK0+
	 jw4CyAYOZyh3FJGhD2HHuLf/SHOqw3K+g0+94YTIQr082ZbZ0amIEDSauPc6MZqBJ6
	 //MB8pFKwexrtLFj5Kqn50E+wlnI6JazpMQu6G3FS/JE5ICf7kVob4aGOvyZ6nrYFc
	 gxqFT43AaCBTRwSf1oGibva8TzbxhEXMRJkbipTKqgzvoCgEPmvygpc1GHa+M9D25j
	 S3oN0FbdlUhMA==
Date: Tue, 16 Jun 2026 18:31:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: fix wrong BAUDR setting after resume
Message-ID: <f4599e01-8683-4323-a7b4-0beb563590f6@sirena.org.uk>
References: <20260612002835.5240-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TExgUI5h//zfubiH"
Content-Disposition: inline
In-Reply-To: <20260612002835.5240-1-jszhang@kernel.org>
X-Cookie: Happiness is the greatest good.


--TExgUI5h//zfubiH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2026 at 08:28:35AM +0800, Jisheng Zhang wrote:

> After resuming from suspend to ram, spi transfer stops working. Further
> debugging shows that the BAUDR register isn't correctly set, this is
> due to dws->current_freq doesn't match the HW BAUDR setting,
> specifically, the dws->current_freq equals to speed_hz, but BAUDR is 0.
> so the dw_spi_set_clk() in below code won't be called:

>         if (dws->current_freq != speed_hz) {
>                 dw_spi_set_clk(dws, clk_div);
>                 dws->current_freq = speed_hz;
>         }

> The mismatch comes from dw_spi_shutdown_chip() when suspending.
> Fix this mismatch by setting dws->current_freq to 0 as well when
> clearing BAUDR reg in dw_spi_shutdown_chip().

Looks like the same bug exists for rx_sample_dly, that's a separate
issue though.

--TExgUI5h//zfubiH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoxiIMACgkQJNaLcl1U
h9BPiQf/aFTCv7O0SuCv4Ryl5GXUBQv/XXk6z5U1Tht8o0FXzJrjQnbOUyw+UCqO
rgszOnTkavYd787TlqVHv/HVS+BZMX1QXXjzH00cWi8iKDwx4MIMkkr3UkdCw6Rf
knNVJsVQkoNjS70cnqiRhSbcNyigMFzCUVFrRjAO8FY0DOKr4LlC9aPj3AsT9ayH
PTDuWByr2AV8u49NeDaGAk+KfavBIFdinh8Dsb4sTOXS0atMhqllH2fyaF7AHkxo
DKYMJlF36uX91kNhV7pp+wJW5GKILAYJ+9GJOIFxdPoQ703gx+Jap4/UehBT1sMH
39BigkX1sL3h4DvvtR0o5gDFGC1QVg==
=yu3O
-----END PGP SIGNATURE-----

--TExgUI5h//zfubiH--
