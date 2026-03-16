Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB038301004;
	Mon, 16 Mar 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682669; cv=none; b=hs1uG5eW+6zkN4sO2AKYFZQAbBs/7dPUJz6DnO4HSQ2ErhYEpTtk537I2jfY9JvpbXyPrjWtc8/aKIeDijqC/hifh58VbvQA4ZRUBNLh9SczySo2iXHe800aLw1DZ82R4vnFeFkoVWorMMo6wbhOs+vS064neJFq/0iwBnxxpNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682669; c=relaxed/simple;
	bh=GZiWvtlfoEpiyqUodXUTMnsEGQG7ZSFGoC394LHJa6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgxxaSiUsK95CRMs+qmRff5pDaap9lGDcoGJjGIgWKTTf63c7wxnpHP40ssnXbMsgqc4T39/ysP4JkX0a3erZ90gdTxEmuqFKlPNYih6Px/iK0X/l13Jm83+VA9U9T0KdGlT9N3Y1SKuCp/wcBxw3CGYuJKLTSPxxoR/Ye491qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcfLajl1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcfLajl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D21C19421;
	Mon, 16 Mar 2026 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773682669;
	bh=GZiWvtlfoEpiyqUodXUTMnsEGQG7ZSFGoC394LHJa6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcfLajl1wEPXI2tnwPpFQOdoGfbluMQwvj5NlZfvMCJuBypyHg0fEItwqWqq+8duf
	 Z/w15pHwvL0pHTbkCGGb/Gqbk0c09CyLPl9tyh5qrYvxC8JAaTIVlQy/uwZUW6Yt74
	 bWxhK4h3zICvs0hoaL77I4WR9WFtwN/KubfFpfNaAslfsQtuHq9FJkoaoJYjhj2Epc
	 0wvXuhikOYjeT80sh8YdCpzPcp8dSjjS4ER+I/nfhl8578Zp4JwunA4tqZ6o2pqM1O
	 XchNXbt/0YTnPC5gasykt8FEqtFIxSTQ7I+hIQ4ynykGxOeeydLg7poio+RveMAEpA
	 QbIF99I7qzzTQ==
Date: Mon, 16 Mar 2026 17:37:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH spi-next 04/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
Message-ID: <0f04cc7e-c960-42fd-9a45-49777e49dd4b@sirena.org.uk>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
 <20260316-spi-fsl-lpspi-cleanups-v1-4-1b695607702d@pengutronix.de>
 <e4c711c1-5229-4685-aadf-f88aca9fbd3d@sirena.org.uk>
 <20260316-original-dove-of-respect-1a6e04-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hq3acB37fdETqgwY"
Content-Disposition: inline
In-Reply-To: <20260316-original-dove-of-respect-1a6e04-mkl@pengutronix.de>
X-Cookie: Not a flying toy.


--Hq3acB37fdETqgwY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 05:49:48PM +0100, Marc Kleine-Budde wrote:
> On 16.03.2026 14:39:03, Mark Brown wrote:
> > On Mon, Mar 16, 2026 at 09:39:05AM +0100, Marc Kleine-Budde wrote:

> > The source of the watermark values appears to be

> > 	temp =3D readl(fsl_lpspi->base + IMX7ULP_PARAM);
> > 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
> > 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);

> > which suggests 4 bits of watermark not 3?  Or at least that something
> > isn't joined up somewhere.

> The param register's default value on the i.MX93 is:

> | LPSPI1=E2=80=93LPSPI3:  0002_0303h
> | LPSPI4:         0003_0303h
> | LPSPI5=E2=80=93LPSPI8:  0002_0303h

> This means a RX/TX-FIFO size of 1 << 3 =3D=3D 8.

Right, so the parsing code is using the wrong mask to extract the width
here but with actual values it's fine.

> We can increase the the FCR_RXWATER and FCR_TXWATER to be 8 bits wide,
> the rest of the register is reserved.

It seems safer to restrict the mask used to extract the FIFO sizes, that
way we don't trample over any bits that get defined in future and people
comparing with the datasheet aren't confused.

--Hq3acB37fdETqgwY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm4P+gACgkQJNaLcl1U
h9Ccagf/YkNQMjdBwpdcdtD1xQ947lHv3rr0/8dq/sZHiHafYYVauHvIhtlJCCOl
KUMu4gBxuYzfd7n3zXKNkrDOtn+CVXd85kCkNJV573yag5iM4SlIoIMElXxr4jrJ
j/amggv4Sr3/A+rGrTSYmtnainbk8iRweFnRls8qzSEUlyImYxPGYZLNzEsYrTHk
ACADND35p99SCXY8t2cKSroUau3scEKsi/k/slAhvPHaFaxnbW7Qyl8p2WL8pmmU
XLgtwYiKeulijenfIjzHI6kTqj4ntX7D/m+AErW7mEIvadyU02Hrmh7TzFnwmZrm
tM+HQiseU2cL2ltswc6n0raEUia6gw==
=knDT
-----END PGP SIGNATURE-----

--Hq3acB37fdETqgwY--
