Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25F34BA5A;
	Wed, 22 Apr 2026 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871549; cv=none; b=qeiW7j+7AdDCfGPXxtW6DoYKxKgRH1BBPA6JZG/WbfK377cIlacEa9+RGN+WFdKJ6RGWT9NXpuJD9A3CLkwg+RTNVkdD1oEq6vGOG8p97wOdyCHkrrfdn0LiJNS1wmewK+85bGQGe0xcLegbtPfoOJrdeHkjDDKZPQD78jjTPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871549; c=relaxed/simple;
	bh=aMlrrUyOX0cvuGWjVkklmW7RDBv8g+60XkATJKTZ6Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAL0m8cbvorzz4oOqU9yMR2MKYPrjWrxMb4vJItrY03We6R/9mpmrvH8QNwi+HPGlZzWZFFo3WHCQfhzejcKoEOJhJS3G04uJjS2M+ktJnh6nQNSn4f/YmUfbnAR2aLTkgYScV6ZgbC7me6FuKyU4VdtISARpanj0wl5NFfJwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNfmcNy/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNfmcNy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC580C19425;
	Wed, 22 Apr 2026 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871547;
	bh=aMlrrUyOX0cvuGWjVkklmW7RDBv8g+60XkATJKTZ6Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNfmcNy/FDFpxfymrcrND0xXYR9gtNJ/9j9fb50DzWC5/6WuqjSeu9z6WX4ZsLPrS
	 9lCXsBSXowSNXq9GEY0mPVh7tT3Di+OJ1r9ZZz/rCJpMbmqVgCCLqCCWazAb1hJLG+
	 YurNPTy7KyxkD+kSahAe8FcXwVjystMTEpnUDWGASt5Xb4Fk8a971zWOCOjC8/bVwL
	 pGcTJJIsX28xKHDFyelqNzvU12WtmhrpKdGPixb/nfAvEYAFIAk9+ostx06Cy0v4N3
	 0HMP7QTYd7WjlNtWFy1iBzjRTdjXYmfN5oULVPh0FbVkw3yLDf3zc0vQzBbEbOa/ZF
	 Fkem21I3OL7MQ==
Date: Wed, 22 Apr 2026 16:25:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] microchip core-qspi gpio-cs fixes + cleanup
Message-ID: <8cb49ccb-5a12-4770-9c91-982d78b5f962@sirena.org.uk>
References: <20260422-foe-strength-a5d8ad650ef4@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awxln/TzuFuxsLHe"
Content-Disposition: inline
In-Reply-To: <20260422-foe-strength-a5d8ad650ef4@spud>
X-Cookie: I'm definitely not in Omaha!


--awxln/TzuFuxsLHe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2026 at 04:15:41PM +0100, Conor Dooley wrote:

> Got a couple of patches here, the first two deal with an issue that a
> customer reported where using a mixed configuration of the built-in chip
> select and a gpio lead to data corruption. Turned out, the built-in chip
> select always gets activated at the moment even if a gpio-cs is being
> used. With that fixed, I noticed that any read with multiple data lines
> was not working properly, so patch two changes how the driver deals with
> emulating mem-ops. The remaining patches are things I consider fixes but
> not meaningful enough to get a Fixes tag. LMK if you want em split out
> to be put on for-next rather than for-current.

I don't know what for-current is but they certainly don't apply against
for-7.1 which is the only active branch given that v7.0 released (and he
same content as for-linus and for-next as a result).  It would be
convenient to split the fixes and cleanups, unless there's actul
dependencies.

--awxln/TzuFuxsLHe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmno6HYACgkQJNaLcl1U
h9B86Qf/V9GcW6oanTDK17DKwmwH+tLOxf0nGVwAAVGO9jCTJmYyo6m8c7/S+btu
WXdafAl6ZQ1UOJ8MzDxH1t9JRlLX4RnvTOmQrO2FaIGLPbiRx7Kdw5zX7B4ryTbg
4181Bk0uQhb9KzqLM3SbVNfEtfxzsRNon9bDGjE61oD6cD9AZMsXwrXMIUitom8s
PiYM/CDRBzNQtC04X/aZAopDFXVTrDZypMfKKP7S1egHc+kh882XRr3q7iqVoc7Z
y2OpxW2qsztgQA3IT0++6RXZFeESx8GsetUWYZhjNGna8JiY6wYsx0ZskMRlhpxn
w2de4FtpDWoJW0OMyG9Fc3OsM+CdYQ==
=7M4C
-----END PGP SIGNATURE-----

--awxln/TzuFuxsLHe--
