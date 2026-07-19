Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66D15C14F;
	Sun, 19 Jul 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784472625; cv=none; b=oICsWFguW+Cn27ISrP1wAzLd5ns9R0r4C8SDBJgjvk1iPj6OdaRPEwysFBs6m4t6k3IXStvleZbfI+BcXbfW8+CC07QfUKh23l+9YYd9aSYDRYatVrGs7SkLvCj780u5azIas5QFyb1G5PKJszENYr4bLGLwktK1VEOX6L2BnHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784472625; c=relaxed/simple;
	bh=vhBrze3NWSYtz/miPrWh1wuNwJ+jo9iJwd1O5X2fH/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRBiWRzyl08UsTOREBlMlX9ePgtSC0SnUrXVeejQmQmWs+a5iMgB6Svu+RAzyX/yBG4TajuzCKR4QJGBN0c3Clos9UjGZC4r8Fexvp+PGMBSnNgbxFNVIv6gIqGeHBMzZgrxKTvVJtSySZrhekjTFz0618HDEAHtRbpLDrlbVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2086A1F000E9;
	Sun, 19 Jul 2026 14:50:21 +0000 (UTC)
Date: Sun, 19 Jul 2026 15:50:19 +0100
From: Mark Brown <broonie@debian.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Suresh Mangipudi <smangipudi@nvidia.com>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] spi: tegra210-quad: Improve interrupt handling
 for loaded systems
Message-ID: <c1100cde-ffe9-42b7-9f21-827cae7248e7@sirena.org.uk>
References: <20260708011257.1712961-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvxvVOWO2BSOvtse"
Content-Disposition: inline
In-Reply-To: <20260708011257.1712961-1-va@nvidia.com>
X-Cookie: Courage is grace under pressure.


--kvxvVOWO2BSOvtse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2026 at 01:12:54AM +0000, Vishwaroop A wrote:
> The current threaded IRQ implementation in spi-tegra210-quad suffers from
> scheduler-induced latency on heavily loaded systems. Because threaded IRQ
> handlers are subject to CFS scheduling, they can be delayed long enough to
> trigger transfer timeouts even though hardware completes in microseconds.
> This results in false timeout errors and WARN_ON splats during normal
> operation.

Is the handling for timeouts with DMA transfers that get split or
chained together safe?  handle_dma_based_xfer() starts a new DMA after
the current one completes if there's more work to do but it looks like
_combined_seq_xfer() will clear curr_xfer if we didn't get an error from
handling the timeout.

--kvxvVOWO2BSOvtse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpc5CoACgkQJNaLcl1U
h9BbTgf8CYbgoUMsXHKhpfVE2XUJ0Y0pBQhodvk/MlN9N3S0plYLN/2AA7oJZ/O1
Z+LvCVnReggifw4TD52M9H9T7yUqz0Iy/QtvXQB5rBHEbmB77G7E6l5JEHctglUN
axtLTRfFrZ0ziCU2ZEoRttYt5HDqksedLEmy4q71zy3ufKcTafosZCVmnj3BhXx4
dn4A2JRCBwrHDepkT2cd6pl7NpYtGfCNcW6OcRfUoAuFjXeMnIBxbuj4pbY4zJIa
jEn7iMhv3mG7U8o25+qLO9iSDF62gaIk3CTFi+jkBzq5K+SCj9ghBeceIEbZ46h7
QC/zhYweCoL9xmlmma88SAu2PblolA==
=xEde
-----END PGP SIGNATURE-----

--kvxvVOWO2BSOvtse--
