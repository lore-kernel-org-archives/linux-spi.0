Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804443;
	b=XxjZA3J7I08jY+aOCcjBwj3hpHZ5pEStUC2BqIxwgnbGASHT+l/Z7ADBr9wAypj3X5Se
	 vZwXCTrOukH/XqB4YrCI3uVMuAcAQk5cpHqYihtN5GsAc/QnaiOSe1OcDI5u4ChsPzDKV
	 xRwRV0p6pZBm5fDJELFozRCPNFIIPmi7Ew53dJfEVh79fsQgL0o1bcMKxCQ2dfX/SyIqx
	 xBUnLlv2V+5XRc7od73IRSzLPtumPQNbKUtsRFdg/sR73f7JViqrqVks1/AQQjJo8ajMX
	 Jy8pnIo7ff3F8CfXMCxrAoEOR8u2Z8lodgP1PbM/5z6/2OHnEvCkY51cJP2eWLbfffw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804443;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=ISk1F/0CK4vIWKtesgCAQzrICvfUnZeKZxnofXW4ce0=;
	b=Dn+mvchkOk8cA7N39ahQ1BatD7Sq1HQPs6F531L/IxL7rqb+hYU28TaKyn3Ih6cIOtEc
	 8/+M7gTjxRbru2E/DVf4rgSQJxu3rVOTYI5K9sIytteWOo4Xt7LnWlLZaBj6JTDJtWQpt
	 dAD00+eHaTxuxWZB7t/W5bUN4a2qLX27Q7/op9tKAp37R+m+BFpDMaH/Tj/DuRbcCRfGL
	 W0SAk3BkSJWHkXF1QNHrJDGdKhVe2H2ikMLITfHse+BFC8BJH9J+gFTpmCs/dqmgldPrg
	 ZCcZ5/MiDVOuW4dt5d/zv8N5lTjvbNz2AIN1vC/hq/LImSkza2TqMoLcrfyfc0I2jBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzRvCffS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC5606A329
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzRvCffS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CC01F000C1;
	Wed,  4 Nov 2026 15:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804442;
	bh=ISk1F/0CK4vIWKtesgCAQzrICvfUnZeKZxnofXW4ce0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kzRvCffSQRh7OwsKF9ghOXeLSVJ2bIkTRcRg4jSysrSAZvZRIrGfsmrRipUDEpnqw
	 GqyL1EnkDTxKTFwg+Z+FcccTJflEdBvFzRUcoctfcVZfp6Zb6PzWcyPjpcGzmqy4DR
	 sNSfc523QAHVn/urLCqLsWwz9RqBSWjkGzU7S2jHqWzcIP5nryLOVd/aL8Lan52SMn
	 Tgo3jxGjDI0xD7B7XgmAPO+t47sxXcgWwU9yM/iiK+U7cCFQUbqxkE0iUEbrl6Hx8+
	 /PfHnon5dID8i4+2AW1NjPOULv2wwfgPf0ULMm/O31yhc1G+XJR4v0VELgGj3/aj4i
	 9Yz9wfLtjezMA==
Date: Wed, 4 Nov 2026 15:00:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Joseph CT Chan <jctchan@gmail.com>
Cc: linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: Re: [PATCH v2 0/5] spi: spi-mux: error handling and delay fixes
Message-ID: <3c7775a8-c639-40c7-8ba6-3aab8f1db6d6@sirena.org.uk>
References: <20261103225308.3633046-1-jctchan@gmail.com>
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
	protocol="application/pgp-signature"; boundary="zwDfD+vDXsRfTV5i"
Content-Disposition: inline
In-Reply-To: <20261103225308.3633046-1-jctchan@gmail.com>
X-Cookie: All rights reserved.


--zwDfD+vDXsRfTV5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 10:53:03PM +0000, Joseph CT Chan wrote:

> v1: https://lore.kernel.org/all/20261102163023.2574632-1-jctchan@gmail.co=
m/
>=20
> This series depends on the SPI core series v2: without "spi: unoptimize
> message when queuing it fails", a failed spi_async() on the parent
> leaves the message optimized. It is also based on the spi-ti-qspi series
> v2, because both add lines at the end of the same KUnit Makefile and
> .kunitconfig. Patches 1-4 apply on their own.

This also does not apply against current code, please check and resend.
It is not sustainable for me to manage some stack of random
interdependencies between multiple in flight serieses, please do not
spam out stacks of things that can't even be applied without each other.
Please rate limit what you are sending and wait for things to be
applicable, or untangle the interdependencies between what appear to be
tangentially related serieses.  Some of these appear to contain fixes
for other stuff you're sending...

--zwDfD+vDXsRfTV5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrrSJYACgkQJNaLcl1U
h9Aaggf/X+Swgr7tL3xG5tI0Ykf4sqoNivi9XMqxR8hwaz7BcAWlCEfNsO9l2lCv
5Ym8DG/dYNRPv4/Zi6GEtKO2kR+znEb1ZZo//m8EP05w7jabq91BbxQ3msnb114H
/etkIgi3YQtUEB9wAo4/HYK5M75J5cEDCPJslfKPbM7F8uD5GgGDWT3/MZVXEu2x
YbRbtD7m4MoxWObsrRziu7qVkXRZMEDDtg9/6W4Uycd83zLQcSYR18xgAd5MWekZ
xtTBOYMo9qMhVIdJq/gHVoAMMX/ZR7t/XvbxCepsxnyi5SFLqSs67SLuj7I8Vx10
LYLjKzlCKl6QYBwWchADzkjfLumlTA==
=amdv
-----END PGP SIGNATURE-----

--zwDfD+vDXsRfTV5i--
