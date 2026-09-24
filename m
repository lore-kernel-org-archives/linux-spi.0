Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C608439354;
	Thu, 24 Sep 2026 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282923; cv=none; b=iT8t7kElYsA0GDibw+0s7EvBt+A//8V0SJFD8QH1At+XoiraiyE8IB0PZf1/7ROUuVajD3kISfu0r3FNPpTQocRDOGRUWqH0/HqBDSn40JpR6PvlCaGLPWVDjTBOO5/Xxpa0qBklGvh47cP5mXW/h9NT7bNEWCb5LZ/9V7aWFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282923; c=relaxed/simple;
	bh=+DwC1po6QNzeWYwgD2duaaNsmjf7EyOp177lUxSJIag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhvxDa4+Zu6Cye5JR1v+4MxoLhzVydAoOu/ajP/0buBd7M+7EEuHD9idPZgMwD6fkT8QKxYQ/7CLiDzXXF3yIKKtRZzjQyA19VUWH6mW25YR7/lTngCDDZaXTDUqIrUb5zi+kwml3QoEQr5ziGjJmy9znLd6nOi3g2FfUg1s52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNmBU9nz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNmBU9nz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CA11F000FF;
	Thu, 24 Sep 2026 20:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790282921;
	bh=+DwC1po6QNzeWYwgD2duaaNsmjf7EyOp177lUxSJIag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cNmBU9nzsbCBghhP67uIUaZoYXsMyTKR6OhhFycaut0ZdkWLD51mC8PqGr6ZvdHHK
	 JyfjhmiKxuQKC5qWLPkDBP7Cj2rGYzC5UhUArVeAbDm2Uo/adWyGVD2dNapNAdTZLK
	 rroDB/aQCK8MRIaWdqtobaFNenCHoR2EkqqvR7cf/7jADjxgPGi7VZGz/3hm7LxTyN
	 Yt6xkMITTd/7sxdlnenMVFENDZs8X/ocVYum+KYjq/ZXVVnvRjgoyHwsUEVcAp8j6c
	 8Ry0b1fwem0xBLPzvyq8mf1/FMZMFFlZsiQZXN6eGKj6dMD8w7wghtNaxXBeTwT2rE
	 ykb+UX42JZfRA==
Date: Thu, 24 Sep 2026 21:48:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH v7 00/13] spi: spidev_test: new features
Message-ID: <73bc611d-a662-4be2-9b25-e29d0854dbd3@sirena.org.uk>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p2B8OiKDLFkBkEQM"
Content-Disposition: inline
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
X-Cookie: Oh, so there you are!


--p2B8OiKDLFkBkEQM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2026 at 03:43:50PM +0200, Jonas Rebmann wrote:

> This patchset has been blown out of proportion quite a bit while trying
> to handle corner cases pointed out by the LLM.

> I will not try as hard anymore to avoid Sashiko "Regressions" as this is
> a tool which should first and foremost be readable above handling cases
> such as obvious misuse of the CLI such as passing options multiple times
> or with negative numbers as parameters.

In general for my subsystems I will not assume anyone has looked at
anything from Sashiko, if there's something there I think needs looking
at I will say something.

--p2B8OiKDLFkBkEQM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1jKUACgkQJNaLcl1U
h9CHSwf6A3XX4nC4728hSiZ2K5nw5/77TlAS+qRdrHudCLZPspk5fUuyVGB+RXdv
hCA0lItSherAPqTFPuRb1Q279QmNCtjSe8Aw4LyV55Y6b+XG5iWz+d6DQnfbQu49
jLproYtSla7+a6yT8g+S7DxfCxkqu070B6gUMoYw+r3vB1k7Qqj38D9itChow54S
rwim9DhhMgPcwmBmf11wOUZIM/NuV8ClvGi4qmRRJvh8gNYZhCL7jvPWUNPdStXh
l/pWs8s3DRD44IapEbhhaPCEijiHbMghGyca+Q36tR/+/QDa6jKkbxjlCvh5aTgH
Vj5JmRaTfM2zeKSCzF/kbs9XRG3vQA==
=ILXJ
-----END PGP SIGNATURE-----

--p2B8OiKDLFkBkEQM--
