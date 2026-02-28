Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB32773E5;
	Sat, 28 Feb 2026 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772287580; cv=none; b=UuJA5ucsQv2FzkAj02eYOItfvvBeRnPtVBzeELoG66VRlZ+vdjeKhBkkXKYF+Nezv+HvVmsNk6Z8SCvOVuW81e0wjssy0868RFb78WeBcEB40/G0+SGcjU0rQy3izciRcajW5/1rRVSMr9ASIRYzwwxbmZD05hY8xu1BdKrgIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772287580; c=relaxed/simple;
	bh=OuFpW7GoYGTResxLjAuhGe5ht2LqnEjTTjg2Wm355z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv7kGZ9o5aVyc8PTG3s7z9SwPQlzq5ozQ9fUu47JdRfOzf87nhkTEK+09zFsNUH6MMhwCH59rXpz60toYOMyjElPSzCQXv7JDXh9XmGGlP3s16hnrbEnA6ivEx9PfS4I0pkGfy1o4muSop6bt//MMVMMysrWAkWkAq+Rxi7U0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC1HyZPZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC1HyZPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D03FC116D0;
	Sat, 28 Feb 2026 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772287580;
	bh=OuFpW7GoYGTResxLjAuhGe5ht2LqnEjTTjg2Wm355z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UC1HyZPZ6K81+9o2WbodhgeeZgbiP5jYg2ezeKlI9Ad/06eCbBOiOsab4ujyebXmX
	 E8uxvwXTntA94y6B80mdKygAKY7FOKh+1Iww7EEc5I16PNJ/O3HmehP8dxUF/Vmws3
	 VPgELYmQDr9phquflqG4h2kxpYzg4KMjEC+pwM4eCwf6Oxc9TGoFHK5UBMt3xtLPIP
	 QlLbIPDBaXmKY0FPghbiHlYl+7C8VlffH039ErvGuvl+gp/a7nww8eP2k4ONdq3SBa
	 8Fp7tKzAery8zHt787jJF91m/7ENAGaxEp8nl/lW1tdHJENCCqseU5qJHNUV4vUEc3
	 xLpwpXIy8lRhw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 899191AC58E7; Sat, 28 Feb 2026 14:06:17 +0000 (GMT)
Date: Sat, 28 Feb 2026 14:06:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Ron Economos <re@w6rz.net>
Cc: miquel.raynal@bootlin.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	wsa+renesas@sang-engineering.com
Subject: Re: spi: Regression with v7.0-rc1 on VisionFive 2
Message-ID: <aaL2WVO_7bl6vNp5@sirena.co.uk>
References: <a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1QHX/mME2VFCCv5m"
Content-Disposition: inline
In-Reply-To: <a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net>
X-Cookie: Think big.  Pollute the Mississippi.


--1QHX/mME2VFCCv5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 28, 2026 at 05:54:06AM -0800, Ron Economos wrote:

> I'm getting an SPI failure with Linux v7.0-rc1 on the VisionFive 2 RISC-V board.

> Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is still busy after 500ms timeout.
> Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: detected FIFO depth (1) different from config (256)
> Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is still busy after 500ms timeout.
> Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is still busy after 500ms timeout.
> Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: operation failed with -110
> Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: probe with driver spi-nor failed with error -110

FWIW confirmed on my system:

   https://lava.sirena.org.uk/scheduler/job/2504026#L715

(which I didn't notice as that was just buildroot and not running
kselftest-dt...).

--1QHX/mME2VFCCv5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmi9lgACgkQJNaLcl1U
h9Cahwf/X2lWZ02gUZqBzCRlGgqNNOrt3hhesJOQcaCTKwNfhs0mVUNOpqMJcyrp
dZO/ehDwr4ofNwYqVa2qr/zbs7CMFqJTnaTbJTp5n5AHVX8WIy0ZHa1JQ2Z39iVP
MjjE4TNPfZ/ht7r44Isttib+S98V+JOvKHO8vXfqcqeqiLQ0ARIVbHKzTL1gAoeK
z3TftTfqmZuLPQgzu5zPRzoaiMuXWtzYwgkgC3QnyWK5RM13K+kXRMFcG42kNnqk
O+b/YICZI1uhBq8I2rxzsXg194+Znqq9k0Q6xNDG0CzJboQielUBeTdm+mb5BVO8
pHvPrFtV9RPaymjIl4Bb2jYklAai+w==
=MOC1
-----END PGP SIGNATURE-----

--1QHX/mME2VFCCv5m--
