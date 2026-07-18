Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557D212548;
	Sat, 18 Jul 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784405668; cv=none; b=A8X00tC8UkReagZgrfe1+i7SLaTvEFbnAJpJVgP8xeBgvGqFCLCvhAZTuzYgp1pGbN3JaDHApd1iDPhjd4PCo0ldE8jmHYXWQ43M037C9IfLhvbiHSPRvseFcItzHieBzmAAk/atFXKhxO9VDnJr7Vc7amzAwimyIuWL/sNZqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784405668; c=relaxed/simple;
	bh=oQ4SeKSYL+saaGuM7lhSqsIWQevdtjGImhAIBqZoYng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwb7caLE4lPmbgIRXwhU4NYcAAARcWcsS/f7jckaygsNMQqCQ7AVPsEC8yxZN+pRLqPNbAaSFrtiyRVCqLqjoBsrLHF9NXGZNtx3q41gsNr/lrno3cDy59+iVgPYfVaaRZefVbpUxpIWMptUrVHdvRVIlIQatX6WUUe0FsvogHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0081F000E9;
	Sat, 18 Jul 2026 20:14:25 +0000 (UTC)
Date: Sat, 18 Jul 2026 21:14:23 +0100
From: Mark Brown <broonie@debian.org>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 2/3] spi: pxa2xx: fix runtime PM and interrupt
 handling in PIO mode
Message-ID: <5cc70d8c-9bde-4d92-9bb3-7902586b631e@sirena.org.uk>
References: <20260718160702.7861-1-fourdollars@debian.org>
 <20260718160702.7861-3-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uRleXeXHWzbJ1rVN"
Content-Disposition: inline
In-Reply-To: <20260718160702.7861-3-fourdollars@debian.org>
X-Cookie: Do not pick the flowers.


--uRleXeXHWzbJ1rVN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 12:07:01AM +0800, Shih-Yuan Lee wrote:

> When operating in PIO mode on Intel LPSS SPI controllers, runtime PM
> autosuspend clock-gates the hardware block, causing PCIe Completion
> Timeouts on subsequent MMIO accesses.
>=20
> To fix this:
> - Scope PIO mode autosuspend lockout (pm_runtime_get_noresume() /
>   put_sync()) strictly to LPSS controllers via is_lpss_ssp(), preserving
>   autosuspend for non-LPSS SoCs.
> - Acquire pm_runtime_get_noresume() exactly once in pxa2xx_spi_probe()
>   after spi_register_controller() succeeds, and release it via
>   pm_runtime_put_sync() in pxa2xx_spi_remove(). Using pm_runtime_put_sync=
()
>   ensures the runtime PM state machine transitions to RPM_SUSPENDED upon
>   driver unbind, preventing active child count leaks on the parent LPSS
>   power domain.
> - Track clock state using drv_data->clk_enabled in helper functions
>   pxa2xx_spi_clk_enable/disable() to prevent clock count underflows
>   on error paths.
> - Protect ssp_int() using drv_data->clk_enabled and drv_data->suspended
>   flags to return IRQ_NONE immediately if the device is suspended or
>   unclocked, avoiding unclocked MMIO reads and level-triggered shared IRQ
>   storms. Active SPI transfers hold a PM reference via the SPI core,
>   preventing autosuspend during FIFO transfers.
> - Register IRQ in probe only after enabling the clock and clearing
>   suspended.
> - Overhaul teardown sequence in pxa2xx_spi_remove(), suspend, and
>   runtime_suspend: first disable SSP hardware IRQ generation via
>   pxa_ssp_disable(), set suspended flag, synchronize IRQ to drain in-flig=
ht
>   handlers, and then disable clocks.
> - Guard MMIO access in pxa2xx_spi_runtime_suspend() with
>   drv_data->clk_enabled check.

This is a very big change doing a lot of different things which could
probably use being split out, if you find yourself writing a list like
this it's often a sign that the bullet points should be split out (as
submitting-patches.rst hints at).

> +static int pxa2xx_spi_clk_enable(struct driver_data *drv_data)
> +{
> +	int status;
> +
> +	if (drv_data->clk_enabled)
> +		return 0;
> +
> +	status =3D clk_prepare_enable(drv_data->ssp->clk);
> +	if (status =3D=3D 0)
> +		drv_data->clk_enabled =3D true;
> +
> +	return status;
> +}

This sort of refcount suppression is often a bit worrying, why are we
doing things this way - the changelog mentions error paths but which
error paths, and why is this the most sensible fix? =20

Also we typically use 'ret' in the kernel.

>  	/*
> -	 * The IRQ might be shared with other peripherals so we must first
> -	 * check that are we RPM suspended or not. If we are we assume that
> -	 * the IRQ was not for us (we shouldn't be RPM suspended when the
> -	 * interrupt is enabled).
> +	 * The IRQ might be shared with other peripherals or trigger during
> +	 * power state transitions. First check if device is suspended or if
> +	 * clock is disabled; if so, return IRQ_NONE immediately to avoid
> +	 * unclocked MMIO reads.
>  	 */
> -	if (pm_runtime_suspended(drv_data->ssp->dev))
> +	if (drv_data->suspended || !drv_data->clk_enabled)
>  		return IRQ_NONE;

Why are we switching to this suspended flag rather than using
pm_runtime_suspended()?

>  static int pxa2xx_spi_runtime_suspend(struct device *dev)
>  {
>  	struct driver_data *drv_data =3D dev_get_drvdata(dev);
> =20
> -	clk_disable_unprepare(drv_data->ssp->clk);
> +	if (!drv_data->clk_enabled)
> +		return 0;
> +
> +	pxa_ssp_disable(drv_data->ssp);

Note that there's an inconsistently quirk to suppress SSP disables on
MMP2, did you check if we need to do that here?  It comes from
29d7e05c5f75 ("spi: pxa2xx: Avoid touching SSCR0_SSE on MMP2").

--uRleXeXHWzbJ1rVN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpb3p4ACgkQJNaLcl1U
h9DKuQf9H0y2OMmLuBJLnUlGwjyyjJCLoh+6LmrF2WjL9SbEXH3bqa1nU/VV+oiZ
ZWSmPLbuXwho/1msh6hts1qEXTrLCJ7Lbv6R04koT9Gs9ZHW6WwVtu9aQVZu6bqg
6KPcL1Gqn3+sFCj9CxjtecN0lhk18qaZ2TEwFg6QyuSMsPYn8+ok2I8jJRHrbZQp
xRUWOwwmfWPO2qiIXPzeGIrB3TtsPsPqFbFUAYCiyNnGVyi2fCI+SDQIc+/gype/
LLCFWGcUWMLXjuMtEry43VbzBje+meaHBdIQ4w314Es3Vje1hfwSxrAnC9/L2XSX
JmbXX3e/9z65A8Vh6k5DAgf7icyy8A==
=/+hP
-----END PGP SIGNATURE-----

--uRleXeXHWzbJ1rVN--
