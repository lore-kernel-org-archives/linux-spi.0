Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA944A7CA7;
	Thu, 17 Sep 2026 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683799; cv=none; b=PiMNh25PQE6K/j9nX/XPL28Lk1D5+z5b8sKgDK3XMa8JMyga3etGeo0hQ3T1SOUR2guuZkY2Jv4EwB6gBiIVnonriJrxVxxtK+1NmqfqvO5Z1BAzh/sWgxY9sq8Z03aBT7kUSghg59SW5I+xSxSl3U8KjzS2+d38MQmP9MEopl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683799; c=relaxed/simple;
	bh=OAHJa1o17312CYNFiD4zfuhqKr9lbf9t3naSNm1O3t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3a7hjRITQwu6QT7PCfHm5EfOWeBhAlbq53jITZfyO2USbtnE4WAXJHOHvGBa/dQ3i/zwfehY7KPQzxmkIbJMzu1GxZf2c/ehJCR3s5/Ep/mj5XNMhaGJgmUz5S0zWyhyR/qvtb5l8A2x6jcJpy7GAZBZD/plSr2QxRrwzp/XH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlyyiYMl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlyyiYMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6AC1F000FF;
	Thu, 17 Sep 2026 22:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683798;
	bh=OAHJa1o17312CYNFiD4zfuhqKr9lbf9t3naSNm1O3t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XlyyiYMlXm1DOvsqF2YQKjQL1SAZCKR8onNHWACRb49iwLZ9ZY8bJwbE0TdtC3VLA
	 uX0bBeIjSzR2VgQviYNFbAg62zND8jCpps5Deu00rOM0g5RezqBDnR3ONR/XbPXZiy
	 nweATYb/lQdJ3eMmAg36C2bND5G/vLEsea4CvXuLIAz8q8ruRjgtIuFyi4wR4/emVm
	 AGCkd8hO6LKj1Ov4M/NNa+IV0JfWN/xS4sH3Ah/dDR6CPybHnEOubENOE95T1QhEx3
	 nhgQCSZvvVLWO2G/jhk/CyX/XWY/eOuvO2FK5nKK4BPe5l1t0PiuuFwQ1wFBvfEW7b
	 fK4OSpt/+C2Lw==
Date: Thu, 17 Sep 2026 23:23:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Clarify what rx-sample-delay-ns
 describes
Message-ID: <c0c4645b-a51c-409f-82a3-a6e6bbd7962b@sirena.org.uk>
References: <20260917-spi-sample-delay-cleanup-v1-0-0e4eddbfb1ce@kontron.de>
 <20260917-spi-sample-delay-cleanup-v1-1-0e4eddbfb1ce@kontron.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L0y9QomAYqKB4qGL"
Content-Disposition: inline
In-Reply-To: <20260917-spi-sample-delay-cleanup-v1-1-0e4eddbfb1ce@kontron.de>
X-Cookie: Whip it, whip it good!


--L0y9QomAYqKB4qGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 05:37:35PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> The property is documented as an offset from the controller's default
> sampling time. That says what the value does, but not what it is meant to

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--L0y9QomAYqKB4qGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsaFAACgkQJNaLcl1U
h9DFQAf/YiZIXR/nWBD844AeGm4hNeuzDP06VgDHz/DZQv5Mt9rgoj/KVDgdXr5Q
XED0luFopb2JIiZ3kGlptpsJE/0b97GXeo6pSEXR9Q+wK5G2PpxIFxdrEq6GK7UM
bDTbtFaUA3TZ2esXyIeVl8rkr99aGsTy18baJr7U9PoX9YiPLm28BHnMSs09m+B0
oto/aP502j9+RT9V1CGLRAZ2akHfbWYmybSPSUS3tIJ/v7KlSO0QPLKQuc2KYBmZ
WM5nfYy5VLqGvJ9fYmIWUAwzb75oYs+bttATEU2qdtzU0huqntr9MBC752AqOBWH
jF1ANLwoRK3TuxJqPQ/He64Z0oOgNg==
=iAiR
-----END PGP SIGNATURE-----

--L0y9QomAYqKB4qGL--
