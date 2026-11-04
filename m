Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803621;
	b=yvYh9DAumAW21MXSsmb2/Ukrp8W2ZRYYbXnGx46iEyzcJAhp1tFxSEO4q6mXDLkZoi2X
	 pMwdjr1NuYMuWdEHLahbIfEWpR7H3gIaJTTFBFU+32YGkB7HfJ4rpAwtsJTUIVh8uoIUq
	 jmCQArEl6Sp6rsd/icE+UhSLmqhIDgmlm71HiQSRUckBSXHaFKL99RN2206uPYLcM+lzc
	 3lq6Kj01Od7okL/uKp10l0LUU3Ud4Vw+sV0tzf5dOTGXf0AxfKFdElASuFDWMWrF7oU52
	 VJH5hybPp6hsMoKwzQdRkyhAm5CvaHwSfokwx6TtkpS3qNJo5oK0g8OosPnVoZ8slqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803621;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=0tQD2Md0LpkGl0AEi1U9OONGtGKDQv+PdOIwCUfO/zY=;
	b=ZYSlI44cbsAdWXLckb8ffE+WeITM7Fkq685+79+Y8HaavPr4n9LltzFT+4ulRpK6Oxra
	 AiFJ01WJHn1Pewbji5bRky0fni74KDdfi37r40+mFQRU1tT4EEp5czeNNy1O9Z6/KhyI3
	 LpKWCROjD05Q7nRmg4CsJZYNQICidNpFkxj8fEkDpWkiGaIZE++op/5+4797nwZlVFHb8
	 LOt1BxCTClA3feuz/KQ8zBBGciGUCt+qUWhMXHLehjZhRss4J2E62bjIf5psIwPAdC542
	 JLSIO+vS51zDkp2/SAyzNBCwBOkpvVcHRgllvjJmF3/QKisj9ZmLQzbT6j73MeKx4ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7x6+Ozf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE11606A31B
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7x6+Ozf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBFD1F000C1;
	Wed,  4 Nov 2026 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803620;
	bh=0tQD2Md0LpkGl0AEi1U9OONGtGKDQv+PdOIwCUfO/zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y7x6+OzfciKu80EYWXVaKKMG1GJK1R5ZE4kzv1+2sWp3c/Tiqf8z5dvcuNHI5N6DW
	 llXbnkJMCnaxVr5BwZEcQp7Dr6ySFEMdYDjgL4byHrTekwXoDvCtW2a3UnuXawhKhD
	 Ud8WD1fFDDOEDs3htG3VVfE8A0gAgQ5R6RgI3eh/qUdXwUZARD9uGZFN3QwPUBbmpz
	 q3O9L0FuT+Jo4cRdEaVPz5hxABRISg1fm0ZXHQ8WTZlGvyPCN/AgFSrbwFkO/TGm2l
	 aQIi921ObQ1Id71XFzZp4cQDN9e9XiHldD+0e3w+fxj77qiZ7kTkN9TuzYVyn0wB9/
	 bGQERS8YwV9Xw==
Date: Wed, 4 Nov 2026 14:46:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Joseph CT Chan <jctchan@gmail.com>
Cc: linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Joseph CT Chan <josephctchan@google.com>
Subject: Re: [PATCH v2 0/5] spi: lock context annotations
Message-ID: <fbdbb9e6-40f5-45bd-bf96-acbb90acdc40@sirena.org.uk>
References: <20261103225522.3643901-1-jctchan@gmail.com>
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
	protocol="application/pgp-signature"; boundary="U6c5Q/a3MuHGwwJk"
Content-Disposition: inline
In-Reply-To: <20261103225522.3643901-1-jctchan@gmail.com>
X-Cookie: All rights reserved.


--U6c5Q/a3MuHGwwJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 10:55:17PM +0000, Joseph CT Chan wrote:
> From: Joseph CT Chan <josephctchan@google.com>
>=20
> Hi Mark,
>=20
> These are Bart Van Assche's patches, which I am carrying for him. They
> add Clang lock context annotations for the SPI bus_lock_mutex, spi-mem

This doesn't apply against current code, please check and resend.

--U6c5Q/a3MuHGwwJk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrrRWAACgkQJNaLcl1U
h9D7rAf+NNNQYVYzVy1QbbdDw/nLEPfYZJs9+bWq6Wof/U/kjgeROcsSdAXb5+zG
YW1DdfWKy/s1wka3HuHjIzcArklaXRfLvw7KenlPQOqVXtwBq3cmS0g8B+ZyqE4G
RlNDbkDb1c7bm6xiAniUxgdRuP4B5R5R8lgI1ZdkNem/N6jSr0eVLK2Y5AQ+BsrW
jj9501gT5yzOXDoWdJ4wFzhaHCB7PlVN3MhIKiHD/TMlo/0hXzWPOcFC2vMLiy9j
Q1lW69mGfK2le5UHmCOODL+bGbLjOCeF3o49CUQvbhnbQ4ZOtv9hBXybroYEOUJ6
qq3RdsVt1Fn5yL8OusygFS4AiZ6yTw==
=6fDX
-----END PGP SIGNATURE-----

--U6c5Q/a3MuHGwwJk--
