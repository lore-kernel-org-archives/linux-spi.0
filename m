Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF963F8259;
	Thu, 11 Jun 2026 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181507; cv=none; b=K4AYnwopCG4s4ypzxYsG88Kpgm+7Ol3ecvypfDT8r3TCNPVjSBl4/ZbVmaEUg8iAprikFuT68u5+aCKZ/kkDD7wpv5UQKmZXbOQZBVn+FAZdGlfXVKaUr2EDO0Bh4eNj5UTBj8WF/XaifxPwl9P4YPSy341woBNBX+nYJgVBvRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181507; c=relaxed/simple;
	bh=JUdOpN+Ja2gfpQItzo6Jr4RkfZ1mhWS1VBmUcFBiVTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUbAdxNCYHYkUCwv2f/LTzO+3pAnSu48VoebB8fkBHyhqL0LPeDfq2mMwoePnyd1uVjdjQ2udTZhU0QuCteq/vwzXWK6NBTZ2Glduz0eX7e2cNHhNbwtuW6RVMkA4DPINhAqSOiV1FiUjbqUWWnBXgYUZ9lcIpVvrTmKQCY3Ct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyRtAqhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyRtAqhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C7C1F0089A;
	Thu, 11 Jun 2026 12:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781181505;
	bh=JUdOpN+Ja2gfpQItzo6Jr4RkfZ1mhWS1VBmUcFBiVTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SyRtAqhrsWQk0woUsGurZF9vMGK0XEJ1Hcn03RVyT+8THSH2k/JRPBYMy63G/gi4g
	 wPAehDWrHwTVwt3KP6H+dhdgrReNp7J8oBU1QLf1D3/WDuAG2m3uttpTP+SlvB0vVN
	 x5qcDZNcQ+WBjZybtFUEAr2GV1ckk1asuSvJNpmquYheiNNgAWMTRWXSloykaciQb/
	 QKYmzTgzzbDfm3PAxDUNBhInxMLAxS61397gts08LOncI4AENO72g/qfcrkTCyYSZF
	 5Z4DNMse93St2H0lhRrROhXfiUcM38x+WAqptztoHo5upxbvZIoYti/5S0tnoFwO+g
	 gD0VvCmhS72Aw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id A62671AC56C6; Thu, 11 Jun 2026 13:38:22 +0100 (BST)
Date: Thu, 11 Jun 2026 13:38:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Diogo Pimenta <diogo2003pimenta@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Diogo Pimenta <diogo2003.pimenta@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Documentation: spi: fix SPDX directive formatting
Message-ID: <aiqsPsypCKzVlIg_@sirena.co.uk>
References: <20260611110603.2768-1-diogo2003.pimenta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zn/BShtAQosTy4FI"
Content-Disposition: inline
In-Reply-To: <20260611110603.2768-1-diogo2003.pimenta@gmail.com>
X-Cookie: Leave no stone unturned.


--zn/BShtAQosTy4FI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2026 at 11:06:03AM +0000, Diogo Pimenta wrote:
> Add a blank line after the SPDX directive to satisfy
> reStructuredText parsing requirements and avoid
> documentation build warnings reported by the kernel
> test robot.

You've sent three different similarly titled patches in the past 12
hours or so, what's going on here?

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--zn/BShtAQosTy4FI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoqrD0ACgkQJNaLcl1U
h9BLCwf/TSCypIcWd6J9Ey0dv0awgqngo0kqP37gtUoP9NCisNZQLie84H0M+X3S
7x49fWLcEpJyGMZ2IY48HJUVeUYn80loTqCm4+2iNT2JLRCG+d8qavapgew/GGAN
hlOB54ZDWwGVr2nWlJEJ+1YEZIonz74KpIcEP66PEEc60evDKR4rnOse5ifg551x
HArmCk94bQVvrlQMnN8gqrc0rvvnK1hiwcvQa/Mo1+N068F+c/ZImDRphRi0X9BS
+M1I65xoUSK/3fEe+ov+9vaIltYOGHi9kH3qp3m+B1LOre6tnkU/XAWvku0ISeE/
7ZOqZyHO4zTpDyUr0YAK5bmOuK+BQw==
=sBM5
-----END PGP SIGNATURE-----

--zn/BShtAQosTy4FI--
