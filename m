Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D42F3C07;
	Sat, 19 Sep 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789836365; cv=none; b=fxG2fddF1Li7MXvcwRyS5O/7shh76x57N0R6wfVv4lziLaAn/ki+jFbwbxYioxQ16EpZ4f2Id1hD4Qwl/81/zsWBtv487dlRLr7itOOlHSnbGe7bO8IZezXYWhUtJqIrsknf9S+GuBt/dQHC7wx1hF67jE9BAtcTvt8anBchbAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789836365; c=relaxed/simple;
	bh=3+uLc48yFgLnTRtPrEEqEnwykLb4ELIaYi6gc8zraeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7c6eElTWDiWUvFeF/3Msa4uZ0sjjjr0FN8bPWWW0PTNZwlEMF9DpyiGF2GkxyvKe9zfBXZX3Qu/ILXI7Pr86C9miFDHKzEUYoRrJ9qoEdP7iJphjwJQelCSsoCQByfVzM8fTdVDONg1rdrb6JoGnrKSamlHNfhn2TAucjHFKtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUVuzpLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUVuzpLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88781F000FF;
	Sat, 19 Sep 2026 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789836363;
	bh=1vU2iB7RD8dDbMfB1GvD3uTof2Znp0IqKpYBTvRssuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mUVuzpLVkdHzF6zh8aFmUFCPliOPl+PUz/FuDn0TQLznRsWBWK8WgI3zm6lNi9dgP
	 Yt0BIV6p7HlrrXi+63hu6Nx2pDqtEAerr4HRtNqXSjrpida0oYNztJtvd2wNrk3GMW
	 wcsR13fcNhJuBKloEakd8DxS9aPfUITOgkOqbHX0ayE7ltQrffsK1WiBWnssuAlwuK
	 zoIgu+i2YV+M5nNzXVr7V3vfohigbJ89BlxMdy8ZMBIA3lCptzOmGxB5smJFsLaoZA
	 c/JqtUNBdcJbXmjiRpwXjImDVISIupaVdezaoE8IENne26ljJaQLrAhPv6DQLYt8YZ
	 jwIO0SJL2mL2A==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 7260811D14FF; Sat, 19 Sep 2026 17:46:00 +0100 (BST)
Date: Sat, 19 Sep 2026 18:46:00 +0200
From: Mark Brown <broonie@kernel.org>
To: Jonas Jelonek <jonas@jonasjelonek.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: realtek-rtl: add support for second CS
Message-ID: <aq68SNTdUKzIm0K5@sirena.org.uk>
References: <20260918214740.3963349-1-jonas@jonasjelonek.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C1FzGOWoV4yFJyPB"
Content-Disposition: inline
In-Reply-To: <20260918214740.3963349-1-jonas@jonasjelonek.de>
X-Cookie: Orders subject to approval.


--C1FzGOWoV4yFJyPB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2026 at 09:47:40PM +0000, Jonas Jelonek wrote:
> The initial driver assumed that the controller's second chip select was
> vestigial because none of the devices examined at the time used it. This
> does not hold for all hardware: there are devices with a peripheral
> connected to CS1. Since the controller only advertises one chip select
> and keeps CS1 permanently deasserted, those peripherals cannot be used.

> +	/* CSB0/CSB1 are active low: deassert both. */
>  	value = __raw_readl(REG(RTL_SPI_SFCSR));
> -	/* Permanently disable CS1, since it's never used */
> -	value |= RTL_SPI_SFCSR_CSB1;
> -	/* Select CS0 for use */
> -	value &= RTL_SPI_SFCSR_CS;
> +	value |= RTL_SPI_SFCSR_CSB0 | RTL_SPI_SFCSR_CSB1;
>  	__raw_writel(value, REG(RTL_SPI_SFCSR));

The original code would ensure that all bits in the register are
initialised to known values, the new code sets some bits and leaves the
rest with whatever value they happened to have previously.  Probably we
still want the initialisation of the other bits.

--C1FzGOWoV4yFJyPB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmquvD4ACgkQJNaLcl1U
h9BsUQf/a9MabdCGn4QJFJ7AEaZNHgfYUbYZlUlOZjCsiF6RJxEIW4kfc2bZBkNe
4m5y5IDZE2Y//DOW4n5DVqhFgLT60HISx66O47oDg0/fVOvYrsGkq0Ei/+7/+FHZ
kkmaQTP9xASR+xb8t6nnfDxgIVoAdVGs+sTyP0HJa0UZyYzfV3AZs5F/QsxmLziB
FhOi4Da1qIk4idhRUGmuG4Jn5DL643kbKEUbfcGuckYzwXtdPHRdbQ+lno6/cLBY
iAqNN+OZRG9x/u5FOv8d5aNtBuFJJPiFtdH2dI9SqvDSg8+2wiPqPXVrHma9qKft
Qb+GH+6Cod9wZixnwFwG+2rdhWyVxA==
=m/Fi
-----END PGP SIGNATURE-----

--C1FzGOWoV4yFJyPB--
