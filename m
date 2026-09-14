Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739244606D;
	Mon, 14 Sep 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406574; cv=none; b=muW8Lf+UK7r6gJ9RpLjd94Ji04DZki9kVBsmZp59vqE5/Hvg7cGNQFM5TgM5+ryddJKP3u9yNqiUMSg32DkCjGAfMmCM2KYL9kOT8FbSzm5THZwmEkB5mJtXKk+nJ2sZNya941MQ1V0ZAF19RR5GVT/M8WIedbwv4A31PRv+NXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406574; c=relaxed/simple;
	bh=tkK3oEHCMDNVrfHGO8+Se4dEEcyyTN9BmOr6L1RzZoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOj2reCr75ldJ4NadSDTqQer0rldbO+YXv9gu4l9pBrhySHlBcFvxwqScNuS6+i6xpJ/MWN6auoqq6cOZWzoh9P2vtYtxt5Ed6kq8fu0LY43GkHwcMXG0Z2P7fFvC5tMjwqFNNvCUrkjKrgpovr8fHvpwLRc0Afocy2tUagwz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu1cfZ72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu1cfZ72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C631F000FF;
	Mon, 14 Sep 2026 17:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789406572;
	bh=mD9Dk5lDE7Cg9Mh6MEyQso0I973cfk9S0LN6iUL2v18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bu1cfZ7206PHRy6x+II+a8SYRs2RvpccmYBCX6LLoRJBCeP2xupXalfz6rQVnUhBK
	 tRs83hZCxSkxZqQcCAddzyQxL6qWBaFoNaJn+3Gy5cqSvRHAk2goeI7rEMvYqrgWU1
	 6UkE3IoR8qpQ/8iYEMZ7XOW/1Y0oF3H2c0ELtQwVKqBjC9qFsjCAnavoaAgA6lu/6/
	 U6/hEP1tg+uiWUV0Uft5d3UtmxqK4XCx4MIOSFjlirxuaGSdL9T6p1IBJ0na/qcgRB
	 f1b3MudXKCxyRH7Flhugz/PhogAm03fAMcVh6UOxJU60bHwvDWtpXNKSdsUZPn+gLY
	 YQcqpM6S6biYQ==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id A6C1DFDA2EA; Mon, 14 Sep 2026 18:22:40 +0100 (BST)
Date: Mon, 14 Sep 2026 18:22:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH 4/7] spi: spidev_test: don't send 0x0 or 0xff
Message-ID: <aqgtYLlgBzlY87uZ@sirena.org.uk>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
 <20260914-spi-sun4i-spidev_test-v1-4-72d6a3b38cee@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2hUmIXH7fM4BMCfB"
Content-Disposition: inline
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-4-72d6a3b38cee@pengutronix.de>
X-Cookie: Orders subject to approval.


--2hUmIXH7fM4BMCfB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2026 at 04:50:43PM +0200, Jonas Rebmann wrote:

> -		for (i = 0; i < len; i++)
> -			tx[i] = random();
> +		for (i = 0; i < len; i++) {
> +			do
> +				tx[i] = random();
> +			while (nonzero && (tx[i] == 0x0 || tx[i] == 0xff));
> +		}

Keep {} at all levels to help with legibiity please.

--2hUmIXH7fM4BMCfB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqoLV8ACgkQJNaLcl1U
h9A/Ygf9H1r0RFIqcd53/Npm+mAvD4GRU49RaoPTFTOaaWK8dEI4NanIZf3LjcTM
omCcvqfCY+a0rNGSbiHcCYHgYmYvxyK2U6TmEl07OPIdY5jUiM20Hxl8PGWhGgVA
OOgdMdVsLLcMlB88FnUquX9hTnMEm9aDyR4NhmNU7aZ+hHkq8clNgqg42vO9XGVV
Nh4IPk+1JTBiffxM+xgO3bEmlsAuTtGHrnsTEwsPdRbXuDoDpGRO0LOfwq1wkqOT
MwKiLuKYbNyn/ecg0XKh0ZExtBlO1qhgTn3OLgKvu1X10Aoe6qwXxb7sG1Ey01qz
yvdtc3z0oasnNLQKxbDAOMN4pQpKww==
=2iJI
-----END PGP SIGNATURE-----

--2hUmIXH7fM4BMCfB--
