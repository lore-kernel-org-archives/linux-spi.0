Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D9327BF8;
	Fri, 31 Jul 2026 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518314; cv=none; b=Qv2peNUhIppk4+uUJUQjZmz7fs6HDWLKGyJQoyKlmo0J7sVkeGMxKwMJ4H2pwCWia/VOvL8dfGnkUDcf5f2flJXry9+MJ4tj5mM1gR6z0tl+Dio4RAb2bVVOiKRyXgh4Tq/4dFzFaTvhm8bHDl4V3Nv+YfNZt9Bz3pU7e3YIkzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518314; c=relaxed/simple;
	bh=RNjBGiq5S/gVR+7e2xm3VIYoq9fVXmbsU1u5Lha2ekI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD/+43j1y9GgBPpv+B/SYImWY+ELjBBSyeWQmhJ0H+Zl+eDuNxQZEfr2Leh+ozeanx48J5FDZPZRc0JiX1E5BKL13V3iI3HxPrdy5CtJWhm+4xmk2yHr2OKQsVw3KS/esfPfvS2nKub7NzzXC6/f9DH2StpmtrHbTADTwwfYiy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqQaXWxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqQaXWxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FAF1F00AC4;
	Fri, 31 Jul 2026 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785518313;
	bh=RNjBGiq5S/gVR+7e2xm3VIYoq9fVXmbsU1u5Lha2ekI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jqQaXWxBLsFNFak9qi+cJkw6O/kVrV3Ig1IRicBEfhMyAkVxfEMOQhtx7BwxL57K8
	 HlihiopqhmuUPIwKyq/ghj9PtY/5Qwaz5mLl4lZkYTcbaNK9CM9cQg4B+Ik9GGM8SY
	 lKYVdGpv9SnGpwAAVCj2XA8IByWcnrt12+meIynDfuOGc5wwEssTUHazsJkBmsiSKh
	 RzPQzxCxAwVX21o7crI/nVCRxrcLNfqwlwuBweEcKtOuMoJJbp/xz9Nh4+Hx7zvsgW
	 BKtqGON0dZtf2YfKzWTOIVxE0pPwyvClEs4a25CSMksdrBe2fOjFw/0xtSOsvlfyBz
	 QpDrflvftoIuw==
Date: Fri, 31 Jul 2026 18:18:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: linux-spi@vger.kernel.org, jonathanh@nvidia.com,
	thierry.reding@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
	smangipudi@nvidia.com
Subject: Re: [PATCH v8 1/2] spi: add new_device/delete_device sysfs interface
Message-ID: <db0c0aea-af0b-4f0e-a9f0-08d6e0d72c34@sirena.org.uk>
References: <20260728191056.2337791-1-va@nvidia.com>
 <20260728191056.2337791-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y80LgV6xSDQeQgvo"
Content-Disposition: inline
In-Reply-To: <20260728191056.2337791-2-va@nvidia.com>
X-Cookie: No shirt, no shoes, no service.


--Y80LgV6xSDQeQgvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 28, 2026 at 07:10:55PM +0000, Vishwaroop A wrote:
> Development boards such as the Jetson AGX Orin expose SPI buses
> on expansion headers (e.g. the 40-pin header) so that users can
> connect and interact with SPI peripherals from userspace. The
> standard way to get /dev/spidevB.C character device nodes for
> this purpose is to register spi_device instances backed by the
> spidev driver.

I think we're almost there here, but this does need to be restricted to
host controllers.

--Y80LgV6xSDQeQgvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmps2OQACgkQJNaLcl1U
h9AtBwf/U1Zq0nzBHuvEMS/592GY7mjNZ5VH36pYaDZEe9mHyA8+Ls/GLo1QJtQE
UVQDOpLBt06V9mf68gl1bKGQPViFZJwhg9uwjX1gt2gvwSPKTW3Fcq0BXjImfsrV
LmfDWN60hvF34jdaGMZcu+pVRKUjvQuO9bcRlePaapaXeTeLNqCcpOnevMhU5jow
bXmsFFOnbdMnD5pgGVamCIMS4Wfba68GYC82tz+8A53W8j/sEwMphaUbhj9WWmQb
rt2z/wcxu5767ouJ9FL2/5wh8Y9chlwU+UIQicli41bXLya90izd29wWTYZ1Wl24
Wiqg1VrWGV2nzsWA79Y1iM35OpqmDA==
=eE1A
-----END PGP SIGNATURE-----

--Y80LgV6xSDQeQgvo--
