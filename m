Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617859;
	b=3CXnbOwM9Ka46chn9UJIpwWpEA06L18PE+CP9yW54dSNdq6Gn7k1Lrn6GwcowvVqXReQ
	 yxzpVjjiVXM3xGBIOHGLXG9kV/SxJq4yMFlxWh439A6FMkYa3zphmKCI9sjMX1S2O3/d9
	 1W6JBNKEyFn/OqdK/gOD6rIws+2DsFiCt5rQRt7EbC+rqwPkjElmJeBFLsaEhFblqQKUz
	 mR9mq7ZuPh0Tdi9qYo8MIStyIiO/3SvwWxnhxddcHDq7rsvtYVxtwyFrts3rMJki89xMC
	 8Ln8WAdTSO0+TVRJxw40F5KzRXVmXyuExGhN++AdC+J0SFlO6IxJ+a5wnRS4fNk980w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617859;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=lAezh5mnef6rba6MZBj2wsMthABud2NmCB2DtTrRKdg=;
	b=mXu/ZN3ktYOU6T7YpD9aUwS3EyhseYyFinPmNU0uFMCaOrSkc05fw5QgTRmVeZdfoSMP
	 JbvWwX1g+tshtEAARM6Bz3QnedZJuwy4abEcQSgp5/AQYxzipBZpOed+T3FTnCsJFZwUF
	 NeRm4/H/r+EpLCtoqZ8V9svrKno0+xbnxvnwZ2RurgPMn3sIyy89s4U3QIEJsxPrcpCX9
	 okL8B95caDkXsT8gUFdxZXVkyknKTz6X/7Agj8PCz+RWpCZiULm2/fG6a7K//NvmfepDZ
	 sR5NyC5V0kGYWf5fAalZsnn8S3WkMesDNOd+6gn6pGduHj3UuxwZKlkciuaNgL+uAbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CecBg1Cd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235E606A327;
	Sat, 14 Nov 2026 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CecBg1Cd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2594A1F000C5;
	Sat, 14 Nov 2026 00:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617859;
	bh=lAezh5mnef6rba6MZBj2wsMthABud2NmCB2DtTrRKdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CecBg1Cd3qXQJrxLnt8ysgW7jGiA+dkeJPFgatdCew6s7dyDUQCyH+0RikWU7S8Sh
	 FCSBgxQFrfBs0kakUg7kX5knQbwJeLa/EW7xk3iAM1TYGE/USmsxfAHqGlpHD09zZ+
	 p4RLXv/iGtD/hoQWo4VbWwhhXO4yOJVdvaPbhU7YZrX4oxCzAR1hb5ZmCkMPlBy02U
	 50i38kc8VihebyiOg4mp3SbbpVaUE9A7J3fOUvN7Qmx+/aPdRk1CA/dYx+VBaPMusq
	 +j4x5DMCaAJbjz0ek/Q47G1i6hJRNsHxuGV/XZmmflBAmbEJjb2W8QjeeySkimgVTL
	 TULQ/npSW3SVw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id C595032AEA60; Sat, 14 Nov 2026 00:57:36 +0000 (GMT)
Date: Sat, 14 Nov 2026 00:57:36 +0000
From: Mark Brown <broonie@kernel.org>
To: William Zhang <william.zhang@broadcom.com>
Cc: linux-spi@vger.kernel.org, shao.mingyin@zte.com.cn,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	pjw@kernel.org, samuel.holland@sifive.com, kursad.oney@broadcom.com,
	jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
	anand.gore@broadcom.com, florian.fainelli@broadcom.com,
	rafal@milecki.pl, linux-arm-kernel@lists.infradead.org,
	sven@kernel.org, j@jannau.net, neal@gompa.dev,
	asahi@lists.linux.dev, ryan.wanner@microchip.com,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Subject: Re: [PATCH v2 0/5] spi: fix division by zero with a zero transfer
 speed
Message-ID: <7730027d-d89c-4b7b-b8d8-07bb19e95061@sirena.org.uk>
References: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn>
 <179460764342.448985.18219249061160291658.b4-ty@b4>
 <CAHi4H7GnDJPcJ2_DD8GGuFjN8mZsGPVWRCYzfCwywQeh26-=Fw@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="xoZP66/tINM/gAZZ"
Content-Disposition: inline
In-Reply-To: <CAHi4H7GnDJPcJ2_DD8GGuFjN8mZsGPVWRCYzfCwywQeh26-=Fw@mail.gmail.com>
X-Cookie: Earth is a beta site.


--xoZP66/tINM/gAZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2026 at 04:39:38PM -0800, William Zhang wrote:

> There are still open disucssion in [PATCH v2 3/5].   If we want to add
> a clamp in the controller driver,  patch 2 and 3 require extra fix as
> discussed in that thread.

Ah, I'd missed that subthread sorry.  It does seem like something that
can be dealt with incrementally, none of this should be triggering
unless the system is already pretty confused.  We could do something
like have the driver round the rate up to whatever it's minimum is?
We could also have a min_speed_hz in the core which would help, I
could've sworn we had something already but I'm not immediately finding
it.

--xoZP66/tINM/gAZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCaveyAAAKCRAv73Ows9A4
ifbFAP0SON2H7y/CJFWdK8kc1nz9gkXWut/M+KwIZnLTiO2HNQEAkMkTi5Jgnxqv
d68HY96IysarOApAVEJVLdzNrRQwzgs=
=9eWL
-----END PGP SIGNATURE-----

--xoZP66/tINM/gAZZ--
