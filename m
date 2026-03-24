Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94A3DA5B0;
	Tue, 24 Mar 2026 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366962; cv=none; b=FsVnYCJ4qE0uAnhLNHk554MvQPAhA41ODYUCj1DsEfVEiwF3OfSy3rij/92BHODgn4YRkorFEiV1Z80G+HYU+++8EXJxJqbQd16/mBQUYiAF2jLLr/anYQjUGPOZQtraN1ISvcBI2PlG7IMxviQUpKCrV6BBZO5Z/d1SwZc28e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366962; c=relaxed/simple;
	bh=Co/d2NDkbaQXI361U9Sc2MPF55Vr1okW3xEKdK1jJTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpTQG438sBE3ugKNImHiz30Tg3a+hgPoUD7ARrox7aNvj66dVYRFLf9YEuMgwFU3lynKp4bpfG+oUldaenriV5OQBzS8ySS06Xbd/HjSUJqvics76q6D7JvjsSjxsrDn6zpRC9rKI38BaoAvtduu5OdJ5eDEsMliYpRfa+XfPMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8LxwvCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8LxwvCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA30C2BC87;
	Tue, 24 Mar 2026 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774366962;
	bh=Co/d2NDkbaQXI361U9Sc2MPF55Vr1okW3xEKdK1jJTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8LxwvCweAs9jESn+YD1k/K6y+xJwetx0yMYGG3jtso20FUY8ms+iV8K2yEdece6c
	 m2zggM/BQ3zUm5KtpAl+Mh+RuLGFxUADdIFVYuQT48UMqYMz73f9cJRMJ6Z/CSR8Ja
	 XXYAnaIzoWRZa/U+tmfDnIArN7QPV+R9+aDQOZUBvHCF1idtSYBJ3tzBlL82lM0f7q
	 mCXBTOGaWSl+J7hLtNlA+z7hEEnnP3tF7VIeTzYtw6ROIdK7jK7FamKoOdVpaprmoP
	 cDNuX2cUwCtU40rCk7ZM6Q5SJ3BCYVyggy/N5y4SoDqmCzu0wvJYAcqC/towzMlRXu
	 94jXvaZqZa9GA==
Date: Tue, 24 Mar 2026 15:42:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev,
	Gao Pan <pandy.gao@nxp.com>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH spi] spi: spi-fsl-lpspi: fix teardown order issue (UAF)
Message-ID: <14f61443-f332-4f24-9d8d-4ecb8ed9138a@sirena.org.uk>
References: <20260319-spi-fsl-lpspi-fixes-v1-1-b433e435b2d8@pengutronix.de>
 <acKoJ3Ca_q40baDS@lizhi-Precision-Tower-5810>
 <20260324-wooden-rattlesnake-from-avalon-2bc1ed-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PhMS7nNQeaZ4550i"
Content-Disposition: inline
In-Reply-To: <20260324-wooden-rattlesnake-from-avalon-2bc1ed-mkl@pengutronix.de>
X-Cookie: Forest fires cause Smokey Bears.


--PhMS7nNQeaZ4550i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2026 at 04:22:30PM +0100, Marc Kleine-Budde wrote:
> On 24.03.2026 11:05:11, Frank Li wrote:
> > On Thu, Mar 19, 2026 at 07:38:12PM +0100, Marc Kleine-Budde wrote:

> > > fsl_lpspi_probe() and add the corresponding spi_unregister_controller() in
> > > fsl_lpspi_remove().

> > Feel like it is not correct's fix. devm_spi_register_controller() is quite
> > common, other SPI controller should have similar problem.

...

> The patch unregisters the SPI controller prior the tearing down thee DMA
> support.

> Another options would be to push everything in the fsl_lpspi_remove() to
> devm, too.

Right, this is the thing with using devm_ for the controller - either
the driver needs to fully use devm_ or it can't use it for registering
the controller itself since you get unwind ordering issues.

--PhMS7nNQeaZ4550i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnCsO0ACgkQJNaLcl1U
h9Bjxgf+OIiwDUL32BatKquysmM4BEwdXkmJUWg4CYuLrhIT9X7IBJ0IYsA/V1yD
ulaAC+wGEcZhXtnoFv2/OOKqpnYYBHvv56RYU7cH33CTl32vAX4oIpDn36mMQbsb
2mZ+ESBxqFcf35YesMIhpEYZrNJjV/FRxlrVQQEudEQhag4ZOxXqmmACQoZg277Y
+M+NgDRezh+ghu26PcwqJhTrOn/AB3xstTUto+bw2+Mox2MchHdpjC7+4gZ4KqZ5
09wFsD9I4xgP22fHWCThNPEKlgBZO+AGhTsvHjUpEtH9A4oWVlfHFJ3kf2+L/G5W
oBq252CPrdLh/mqnTVCp6BnXYOybQw==
=mWg2
-----END PGP SIGNATURE-----

--PhMS7nNQeaZ4550i--
