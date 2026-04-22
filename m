Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0231B838;
	Wed, 22 Apr 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869827; cv=none; b=qJlO7uR6Kw8g9InIdycI/Eg679VFUm/lJZeF8yO2GyaUUKEV4019Y5Kd4cQ+MQ4fVK429WFjPzwcKd2K7QA6C9zGpV0Vpap8KjvI4yGfW8Z/Lv4RSVOH0lgcrffKPXmqtd+1pg4FysWZWeoVxUzR2J4L+yAKGiMLWCikxaJyFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869827; c=relaxed/simple;
	bh=U7K2QAfNkxfrOrOoAR5/bJnJnEMsRVeWUSWDvn0eC4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOEQS/3TgZWqFi78fYgVMPSixWfheEvZcCzXGpDLUnAdow1ltzLu6Rx70fvmV6lrpfsAizsg59Zz9ZZM0h9MxS0gegZ/WNckFzcuQ7goxC6Qksr3PVWNkAPVLFR5g7g8QWsqLCy2ZyL1jBrN2yZwrpu8+pTGk3o9pUccun6AVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8zIYnXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8zIYnXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA9DC19425;
	Wed, 22 Apr 2026 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869826;
	bh=U7K2QAfNkxfrOrOoAR5/bJnJnEMsRVeWUSWDvn0eC4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8zIYnXqB4exHC3F0lWnq4YrUp412dFlNTa471sejPAAaib2sozTnEWsKLFG8xzc8
	 O6drvbLDo/33vvRJ25SD69hkyFXpFveJreYj+EMgZiXSpxraoMIdlJwV9weNVgf3sD
	 uSMpDUUzuccrY7rlx0EEUbmN6l0JZ9Lud4ogmIj7Yz71LrFJWDU/0h3oYBBDFiymcd
	 iCt8vMShvPq8qVgSuU3d1/MQkAhmkIHC58hY1IauwiNOZeHFagUJ9GYlATjfHUUaoh
	 9p2vMj9lKx3qS6ANzZWHOPUlOsZp7jIeriDvmj0tF3l6l04/+ns2Fe744JBI4eMaEt
	 KwOdHUTZEg52Q==
Date: Wed, 22 Apr 2026 15:57:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Kevin Mehall <km@kevinmehall.net>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Mirko Vogt <mirko-dev|linux@nanl.de>,
	Ralf Schlatterbeck <rsc@runtux.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: sun6i: Set SPI mode in prepare_message
Message-ID: <66909301-ed23-4b36-8955-a69b64eed9a1@sirena.org.uk>
References: <20260420164755.1131645-1-km@kevinmehall.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Iahe586F9WozlOdH"
Content-Disposition: inline
In-Reply-To: <20260420164755.1131645-1-km@kevinmehall.net>
X-Cookie: I'm definitely not in Omaha!


--Iahe586F9WozlOdH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2026 at 10:46:04AM -0600, Kevin Mehall wrote:

> With a GPIO chip select, CS is asserted before entering transfer_one.
> The spi-sun6i driver previously configured the SPI mode (including clock
> polarity) and enabled the bus in transfer_one, which can cause an
> extraneous SCK transition with CS asserted, corrupting the transferred
> data.

> This patch moves the SPI mode configuration and bus enable to the
> spi_prepare_message callback, ensuring that SCK is driven to the correct
> level prior to asserting CS.

> +	/* We want to control the chip select manually */
> +	reg |= SUN6I_TFR_CTL_CS_MANUAL;
> +
> +	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);

Might this cause the native chip select to get asserted, we didn't set
up values so it'll have defaults if it wasn't previously configured?

--Iahe586F9WozlOdH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmno4b0ACgkQJNaLcl1U
h9Ae3gf8DdM01ZWjlXH76yDmuyz6xhrdHq7cc8WLh4FWwUbviuZ3Tkfs3DPg+IZq
45tDrBu0yXCxiVN9ejLHMR7mI1aFF8aO/3OU13o849g6suL+O6P8Hw/eGWKnQ3z/
RIK/Q/CrdAsosbv9oxwA4QmJ/C4RkIcOcyjfB6jnp8uc8CVCZpyy1zke5iRGiKeX
Ys+egdMfPJRaehp23q5vhCWu4n6ObdRs6foZ3hP+ZfixLkWPZ0iJScfUmf0klPTH
JW+az9ccEZcQYE71xIvlH4Ahn7NhqEKe8mq2ERoFa3IN8rGHFKNCqD07/eTX2L9w
T0j4AZFhYf2my8B1QPo3/OO97qpz4w==
=xnVK
-----END PGP SIGNATURE-----

--Iahe586F9WozlOdH--
