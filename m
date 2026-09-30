Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548C4EC65E;
	Wed, 30 Sep 2026 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773790; cv=none; b=SmYjC0F5ZFLicTe1A38TAyStwVCOfZ3vupYd78q4OmJoERjrymB7cRhFqfaSWgVRnHmCK15zbt/1Vxj0tgAgflh11gpgm1G+8p63lL4sdHDLP2tgLlm4qjAXVk0M7Ca/iXsFFSrXBMcaa63AhoMUSwK/W7WWHlSOYGJLJFo1xOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773790; c=relaxed/simple;
	bh=J++qny+EBJxZHEZ4LSRSNmEN90XEpcwVvG5UR83jBqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTyQMaLfkMzoWyd5wXPoHWUGRQklwOjvT+pT6USMNT9y4e+aYpYJMb63EeoSfQhZ2SeCqcQkT/uBK7Rhadw+JDzKp7xO/yimkflkImtimXH3e0FawmCxdrOdv1C9j7zA67rWhZt3+DrxawF5GyLUMBOtDQqdwi4b+jwS6FETH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvO0649/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvO0649/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8171F000FF;
	Wed, 30 Sep 2026 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773774;
	bh=4woHoEVaTQEBheXiZHyVF4iXX9NPIEm5bR+jZ3AOrk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YvO0649/rX1Z5taZFH7CD9y/xYnJnE2JnmJ6ZKLiFpfAP5yyCrq3Gssre+d3nfQaF
	 v9uM58hIoSg7MfO02fg5zOo+s9wRlwPSn/FVow3AVzsKaknjOnKs2NTJPOSPhCe2/j
	 bDc22wN8V0PVWINcCHwKxEtyMfXIRH3mmHP37HWu7QO3i+nULU4IeFEZFAuzrzXoOi
	 ocigvdvVCkeTY+3IGoscWH08aw3bYR7qgqyO3Po9BdUc+AdIJqh21oai8FUPEv9HEL
	 FWwgsrXerBTYLmnRO0TkHHMQx4tYtJONHDdvMc+c2WoHUoGqq/4m+L4c6wUT6mlj3W
	 dD0L2Q1+eMjoA==
Date: Wed, 30 Sep 2026 14:09:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, jonath4nns@gmail.com,
	andriy.shevchenko@intel.com
Subject: Re: [PATCH v2 2/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
 in trigger_enable
Message-ID: <8ba05b99-36ac-4a76-ac11-e6ad92c631d4@sirena.org.uk>
References: <cover.1790731588.git.Jonathan.Santos@analog.com>
 <b1573f16b8e30f22877677026bc2296420a0c527.1790731588.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wbbwOVWLGMatWhGR"
Content-Disposition: inline
In-Reply-To: <b1573f16b8e30f22877677026bc2296420a0c527.1790731588.git.Jonathan.Santos@analog.com>
X-Cookie: (null cookie


--wbbwOVWLGMatWhGR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2026 at 11:17:45PM -0300, Jonathan Santos wrote:
> spi_engine_trigger_enable() sends SYNC(1) and polls SYNC_ID, it never
> clears the INT_PENDING[SYNC] bit afterward. This leaves a stale pending
> interrupt that can fire spuriously when INT_SYNC is later enabled.

> +
> +	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled */
> +	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
> +
>  	if (ret)
>  		return ret;

I'm not seeing anything here for the issue with ensuring posted writes
are completed before we drop the lock?  The write may not be visible on
enother CPU, we need a read from the controller or something.

--wbbwOVWLGMatWhGR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq9CgkACgkQJNaLcl1U
h9AY+gf+IcpTdrqN5pgjRTov3ioF32wKPIKxhbplBRj64csGTaNi291GCQ1Jprco
nMBjc3Dz4SBU/bTqfdbIfaeD1VhDYfp9DwHXCAlJhAQz/P2x3ImpVBy56k+3rjVq
G4FAaz4OUa6hCYrnch1lODnSF1sXnDO0RmjKlE77w9PjKSCeCCmI3iU3ey2Oqid+
QXd9nbp1XpxQwRBs8M/EWP9H1sy7LSPLfzQEyq4L0P6b8cVXLQTCvk2ZK/3nCcE7
zl1wqL1gmnQLMj+buo/IuoET3P/r+OzJphHMyzO6jwWf6pLHy5hU3A09tQmN1Te2
Sy0UcXNpDmAFG6k76d4jVwoozmeu9A==
=Ep6t
-----END PGP SIGNATURE-----

--wbbwOVWLGMatWhGR--
