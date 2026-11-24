Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527929;
	b=YMRrRvx3YFQQiHgW6LTARMg40oyVULAPspBe5MYxS1n5SQJYYibIIksi3wAUtefv8Ya4
	 AIR6TDqVOAZ4/uI9NOqkzybnNdxpCcqi7UuEArHgQ/P+MVRwbhNtFuibDJjVhRSt27eyE
	 qnyzReI+PB6oPCk5ySzXg7MTF96nAVM6ib4USoDc08zDtjnEa5VYln0s9YP9H7fJnzPA0
	 zZrVPw995PvAXffVKtWye5LsDwpdVwie1sGApODqdD6ul/8HgnvCVFyGN+7QKiLGgrZDG
	 lSr9JDnjubw/+BcwPWMqMoFw2wzT6oreJBBGbr7J9sitWIPFL4aCsT8ECRdFgOhm7Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527929;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=hveWDX3wRu+9ZTN3oYj1ZM1AyoIHQ/8kekmLbhh+wKE=;
	b=VGG+gUMFixd2IX1F0qAY/fQHKUgm1idxnWCavMurTEy6dlR92s4/KvHYEPUx3SjgWHxU
	 Ho7NnwNJ7yDa/OId8NDfgX6MiX7b1/EeLV8AtYay/Ms9SvnYtqc3njKUhFV/QpYi2b2B5
	 FJPG0vUHkIv9BSrWHzm1AjI9xgEJv44ApjWGfkQtBIgoC0XuGHhL5attY4W4ktfHWEcld
	 0/a6vGG0NIFzCODhKshnoFYpACLULZ558BaLP2lEB0C4rkMUiA2eQ7ud1kzBY8+fZYjmu
	 rUNYhCZ39V0kv6mXe944Qfhp2c+hm0Xag4m9DwvA9bJ1/sTc5bHU+688lbGsX9kdvmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcKns4C3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E8606A31E;
	Tue, 24 Nov 2026 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcKns4C3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A551F000E0;
	Tue, 24 Nov 2026 13:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527928;
	bh=hveWDX3wRu+9ZTN3oYj1ZM1AyoIHQ/8kekmLbhh+wKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KcKns4C37cDcZREkdVNnQEb8IQFMLSj4V1neI8M9mN6W5wzQUPtiytsIW5fttWDSD
	 s/slDHx2X60gCjhMGGx+JuhS3edwdlkzy6ThNKo9izuLasqbKzGndgNfqtVMoBsiJY
	 IVOC6iZ0mHunboaLEW31VMHA+cgWA1jiff+A0GUCLKbLmmiUQxuqVSdamn8dC22Qtp
	 3I2dC9YX0TIbR4TQJOyJtKT++iFDlsxmHkJ0EXl2SonlJhczMD3CqbiOMJNCeV/8vY
	 58eswUfYjmvSRWuaHZFFqyTVdrzBSq/TGz8sWZvdgkCnyUFWOF0Usd6+51+J73SM3R
	 hIsYqVV+350tA==
Date: Tue, 24 Nov 2026 13:45:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com,
	u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 00/11] mtd/spi-mem: Enable DQS control
Message-ID: <73680b0b-2c98-4ebc-bcb8-4ca144b469f7@sirena.org.uk>
References: <20261120-winbond-nand-next-phy-tuning-v4-0-8c21e1f71f41@bootlin.com>
 <164905f5-2857-4b8e-8d99-26939b45cde4@sirena.org.uk>
 <875wxmttj7.fsf@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="mS7vwsVuRtIn6CIJ"
Content-Disposition: inline
In-Reply-To: <875wxmttj7.fsf@bootlin.com>
X-Cookie: Real Users never use the Help key.


--mS7vwsVuRtIn6CIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2026 at 11:26:04AM +0100, Miquel Raynal wrote:

> What is your plan with Santhosh's series? If his series will make it
> this round I will respin once applied. Otherwise I can just respin the
> independent spi-mem bits.

I had review comments that he hasn't responded to.

--mS7vwsVuRtIn6CIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFlPEACgkQJNaLcl1U
h9A7Wwf9G5jpVxn4bfkt4gltGtnYP3Jbkb/TG05RkTtbEqfImQDwFegYXJ2dJF/E
eg4ewl0Fn8lpXuz42oKqc9x21PJ7sAU/+KWWFI+/6SALErsRfVKOKjofa11tZfRy
z7Ly2hOHSCyVebl+djzEYzvadmrAF2VEz901fTdeSorM8rfWBX7jqkcJERi9gwYm
YtDVPa/5N58DSJpjqWBtgToYSJoj0W2BiUgFNyY6uyYPQQywy0xGFJ31qB1nZxxD
CsB5zVY9w/1Vm1n5mXAOAZE6sqwTQHdRfxrYDzoQGpDnJWQQbkA375Sq3BwR1mcT
hlN8KyZcJ6B8wH34HmOFGVqpjktcRA==
=dhJf
-----END PGP SIGNATURE-----

--mS7vwsVuRtIn6CIJ--
