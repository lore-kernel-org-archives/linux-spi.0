Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBB41CB31;
	Fri, 25 Sep 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331888; cv=none; b=dulkMSAidjO44c5pjQH4hy3PlADOUCHNKPM3YcKfOKkunWkoFwM3cJgKJcDEhFae1NO5bfgTPFrYNvDWx5dx8fv1aMZBdS5kcLDG1mUjcfG7j36+iPyvKtby6Pds4WAguAE1MK15BMfg5H0mcV+66I/3Yk5xxkEMYdp2oJi+YZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331888; c=relaxed/simple;
	bh=nXG3iCkjmV4ZdDKhTQkKQC4GacU0eJ/TG+nndqZOgxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnNkJReMjdJeFDIW2sMDr0gHPT+MxNDMWqhWof0sGjEOEYWe3VkJLcr3k2dsIUvMjXKK9/4autp/4zJnaDI+/8gZHSoUTNo6P5dM8eo+m7F4D9ZSBWShMZKBQCkFiS+VebnTnswcjf5eePjndQMvisOO02ThBPmcL5XDoU9Ilw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxqtJg8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxqtJg8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D161F00893;
	Fri, 25 Sep 2026 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331887;
	bh=nXG3iCkjmV4ZdDKhTQkKQC4GacU0eJ/TG+nndqZOgxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BxqtJg8QnE/hDkMAHEGccyVQlB1ybkzeguXqroxkx9gWz8It9AzwR03zFol3IxsZG
	 bPJLKW3jb+VcyDPZuusp35hvG0/7Hou4D31iPHynsFXbr6itopWxTNJaz7cw6/zl0F
	 dpJDDZKwrVi+DbpQcEMyTTuxARsn9d8Jws81zIZFmSxPPUB7GzcKzr9IT9tA24RgqA
	 TkU0LirofthI4rE5ZvUhY8HBb50vuqxBpNS0cQeti5tLgNEUwJ/MoW9opPWJg8ZIxz
	 K0Q7ASaYwVbanoYyFwjp11u+ID6P+Az41/cVE5KLNyGaMNLWS8DaTzgYOlxzt9vHCt
	 Wl93r4CzYmXeQ==
Date: Fri, 25 Sep 2026 11:24:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH] spi: spidev_test: don't mix up rx_rate and tx_rate
Message-ID: <2b7e4105-913d-461d-8d41-5abef82f27c6@sirena.org.uk>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
 <20260924-spi-sun4i-spidev_test-v7-8-126e31a07fdc@pengutronix.de>
 <dcb8c604-b394-4126-bfc0-81ce23603d26@sirena.org.uk>
 <a834ff79-bc22-4a9f-8e37-ddfb4fba124b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6kggTpr9YW948ioc"
Content-Disposition: inline
In-Reply-To: <a834ff79-bc22-4a9f-8e37-ddfb4fba124b@pengutronix.de>
X-Cookie: Love America -- or give it back.


--6kggTpr9YW948ioc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2026 at 09:12:12AM +0200, Jonas Rebmann wrote:

> Good catch! Should I add this to v8?

No, this is fine - v7 is in CI already.

--6kggTpr9YW948ioc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq2S+oACgkQJNaLcl1U
h9ADLQf+L2CP0xL/tStmusfT7dv9Jb2j1knZBDncVQrGHVEKJNb1wDK2YB9NbdB3
p/P6YxGJ910yAgmej7wKkSiQRCNw87xVoMlpoeJmKQiEx/Xrofy2OonsM8Cd1FzB
rkoKiKfj38zbkKrYnoar85lIdHMfN+4GtF2YTTZr0JGU5QkI8+uVJXOycpFr0FTK
yphxRG55dLizc5D8ie28jBjkY9LIlnO6vPSR+mLqgz9PXm0A8MqoVbwhWAzS8ZRw
UITRKQCNzA+qeKAUycsepww/NHGySEW3KPWLECkQCN6A+znEa3AG0eHNDwwxSZlj
hxbEho10gYl3EbLFTje0s4Jpt9tz5A==
=s/Oz
-----END PGP SIGNATURE-----

--6kggTpr9YW948ioc--
