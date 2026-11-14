Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617469;
	b=z1SnXBUHECGDyqd+SrBOFxhGweWBe27gvC1aHf3xlz0qMgBoXdlfIUYuMocrVuFKlgyB
	 Tj7HRN2csh/zJZl1iEVSb6/BFC95p9erFCHxnufJFMwDk8kdW4CO3bE/RviK67Cd8ocDc
	 2SMr8bAVA5wEswB/1uYYCLkjv1Yf5OwRfRYA3aQEh4Z5Iug2VrldzzudzRqnnM5BimF0e
	 YFp3PkI7pLT5OtHzGdBhRucut0LQERlZKpujTCaxXKiGE75jNCuLmkbdyAUZFRxpw47TU
	 S0kiqkTf+b9BRQbfzHYk0AZkCEsWQuPJ1EEqV+IUJ7HYtKaBL60Fz8jASyg3baioE6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617469;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=4P7DMRpzI67L+ckc1ZBMVeAzQ4J+BH4io4JBuf9M6QI=;
	b=xXlxOGvY6oiJCyljDVN04msb7VjGTYBe1jJeVM0QM7QuFU/V6DJFZ4+B6RSlOhtwn+ak
	 3dJowcZ6hnh6zStGCKA2pA6JJXjbZx3p9572NFnfFOSR10e0e1P60ugbHiHzg4jwc01T9
	 XutyCWy4YTs3UJh/KUSg+3I1py+KqSWH5S0nKrljV/yJ1wWW7e8FP4fqy+S8rXDZHcLDP
	 ZGvXEwg0ctdxiWon3Qa/pszXWsht2nA8exhj4NIFO5XloiugOQCD+gzliazuOqFrOUcZ0
	 mKeImHyOImugewBNlw8J9ATpXpVLyRBhy9zImgm/Rcswt7TC2qTL8heCCvU13i69JMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVMcLii0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE0606A32D;
	Sat, 14 Nov 2026 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVMcLii0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560D81F000C4;
	Sat, 14 Nov 2026 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617468;
	bh=4P7DMRpzI67L+ckc1ZBMVeAzQ4J+BH4io4JBuf9M6QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oVMcLii0dUHW5lJ0aO2FOmzV+DtpO2BAO3mNVRP0i0LIE6D5kLt6SrgDhXsucm8mC
	 C8ZQpUMueJXSpnm7ywh3lwmbIMgUwhyXiAAfrus8oblsQmbj0zZCRx0MfWCawJGdDa
	 EefuKEHnAmO6bpzC8yMwOuUfyQSeK5FtDKXYNT4eduq0M3/iHfMDpUCgQUOM1dJoiF
	 Sqbplwg5b3TwtDDG/NEY3JqGAqMM9xSxxoJ4Dy7xxpu9dhxQ1hJP7vvENFbql46WqB
	 CXreMYZzU80aPeCqlP634fGxyAOCYtEuGDKtqDac3RsNQF8BdP16XOxkOkI3lmUP51
	 C/CJ9RPPV57Lw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 8D99C32AA096; Sat, 14 Nov 2026 00:51:06 +0000 (GMT)
Date: Sat, 14 Nov 2026 00:51:06 +0000
From: Mark Brown <broonie@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: william.zhang@broadcom.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	pjw@kernel.org, samuel.holland@sifive.com, kursad.oney@broadcom.com,
	jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
	anand.gore@broadcom.com, florian.fainelli@broadcom.com,
	rafal@milecki.pl, linux-arm-kernel@lists.infradead.org,
	sven@kernel.org, j@jannau.net, neal@gompa.dev,
	asahi@lists.linux.dev, ryan.wanner@microchip.com,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Subject: Re: [PATCH v2 3/5] spi: bcmbca-hsspi: fix division by zero for
 devices without a max speed
Message-ID: <1d8b7784-f217-45ef-8f09-658044e441ea@sirena.org.uk>
References: <CAHi4H7GHGO27Q=O8Upfds8jk-ujSHU5h91hCZw6qjftNX7a2Ng@mail.gmail.com>
 <20261111173637687ugnRPRBKJkF0zihl662i2@zte.com.cn>
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
	protocol="application/pgp-signature"; boundary="D7xosyWN3K0hIeX/"
Content-Disposition: inline
In-Reply-To: <20261111173637687ugnRPRBKJkF0zihl662i2@zte.com.cn>
X-Cookie: I'm wet!  I'm wild!


--D7xosyWN3K0hIeX/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2026 at 05:36:37PM +0800, shao.mingyin@zte.com.cn wrote:

> > IMHO the upper layer should fail ... rather than having the controller
> > driver to override with a risky 1Hz clock.

> Agreed; the fix belongs upstream of the driver, not in ->set_clk().
> Mark, which do you prefer: reject max_speed_hz == 0 in spi core, or
> have these two drivers clamp FCW >= 1?  I'll wait for your call and
> won't spin a v3 meanwhile.

Ideally the core should do this but that's quite hard to do due to knock
on effects of handling 0 as a default everywhere, together with having a
bunch of existing drivers that don't provide any information.

--D7xosyWN3K0hIeX/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavewegAKCRAv73Ows9A4
iWN2AQClR5sOK8gylXjPGozoKNkL8che7F9VYkofFkYIAbamjwD/ReYiG72diC+8
NHMu21kmTY9APQadD0105SE1A4OM0wg=
=FhG5
-----END PGP SIGNATURE-----

--D7xosyWN3K0hIeX/--
