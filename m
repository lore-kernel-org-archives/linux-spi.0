Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB130C14C;
	Mon, 13 Jul 2026 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958580; cv=none; b=jrVHo//o7smYQjMfMSBXkukon3eWp3QmqXnk1Hlsz2eJZHUWDQBwETnAsh/hbYClj6rttzLfnoBOZ/bM41Z4B3uLhlCImm7R6PE1wnxrQ0pLNHa8lEdQ1VcnPwudxHmUorkdfbZO/87KpIfW47+61R9VUy+E/oG0glwAtGyIRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958580; c=relaxed/simple;
	bh=Y9yhuB+mu8WYcDyqxFoMZMekpCXHbgjg6gMBmtzvONk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIIcl+BDInpqHMUhDKUg+vsZcsQZxIY/rYICi4p3AnO58cplDWko+mJrI7hIcpP9agCmAIDaZehendRNBS+eHP/7+cYTAUbVQBMIHqLxSaSXev8J/PkwRMdvPVOQrCVu5K4VhqtqaFCJGhbo6eY5BdgehX0O5M9KzWsXCBc6YKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B842E1F000E9;
	Mon, 13 Jul 2026 16:02:58 +0000 (UTC)
Date: Mon, 13 Jul 2026 17:02:55 +0100
From: Mark Brown <broonie@debian.org>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: pxa2xx: restore LPSS private and IDMA registers
 on S3 resume
Message-ID: <2ab0cd81-f139-4f9b-b7d6-f3cee4ebb8cf@sirena.org.uk>
References: <20260712162420.7453-1-fourdollars@debian.org>
 <20260712162420.7453-3-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s6ZXI26aYxOCLzx3"
Content-Disposition: inline
In-Reply-To: <20260712162420.7453-3-fourdollars@debian.org>
X-Cookie: Courage is grace under pressure.


--s6ZXI26aYxOCLzx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 12:24:20AM +0800, Shih-Yuan Lee wrote:
> Intel LPSS SPI controllers lose all private register state across S3
> suspend because the LPSS power domain is fully removed.  On resume the
> driver only re-enables the SSP clock but leaves the LPSS private
> registers (BAR0 0x200-0x2ff) and the IDMA registers (0x800-0x814) in
> their power-on-reset state, which causes two separate problems:

> 1. LPSS_PRIV_RESETS (0x204) stays zero, keeping the functional block
>    and IDMA in reset.  Writing 7 to de-assert both resets before any
>    register access is mandatory; accessing MMIO while in reset causes a
>    PCIe Completion Timeout and a watchdog-triggered system reset.
>=20
> 2. The IDMA block shares the SPI interrupt line.  With its registers
>    zeroed the IDMA asserts a spurious interrupt that masks the real SPI
>    interrupt, causing every subsequent SPI transfer to time out (-110).
>=20
> 3. The LPSS software chip-select control register (0x224) must *not* be
>    blindly restored from its suspend-time snapshot: if CS was asserted
>    at the moment of suspend, restoring that state corrupts the first
>    post-resume SPI transaction.  Instead, call lpss_ssp_setup() which
>    unconditionally writes SW_MODE | CS_HIGH (idle/deasserted), matching
>    the state established at probe time.

That's three problems, not two.

> +/*
> + * LPSS private registers to save across S3 suspend.
> + * NOTE: 0x224 (CS control) is intentionally excluded - it is re-initial=
ised
> + * by lpss_ssp_setup() on resume to ensure CS starts deasserted (idle-hi=
gh).
> + */
> +static const unsigned int lpss_saved_regs[] =3D {
> +	0x200,
> +	0x204,
> +	0x220,
> +	0x238,
> +};

Unnamed registers?

>  static int pxa2xx_spi_suspend(struct device *dev)
>  {
>  	struct driver_data *drv_data =3D dev_get_drvdata(dev);
>  	struct ssp_device *ssp =3D drv_data->ssp;
>  	int status;
> =20
> +	if (is_lpss_ssp(drv_data) && !pm_runtime_suspended(dev)) {
> +		struct pxa2xx_spi_controller *pdata =3D drv_data->controller_info;
> +		int i;
> +
> +		for (i =3D 0; i < ARRAY_SIZE(lpss_saved_regs); i++)
> +			pdata->lpss_priv_ctx[i] =3D readl(ssp->mmio_base + lpss_saved_regs[i]=
);
> +
> +		for (i =3D 0; i < 6; i++)
> +			pdata->lpss_idma_ctx[i] =3D readl(ssp->mmio_base + 0x800 + i * 4);
> +	}
> +
>  	status =3D spi_controller_suspend(drv_data->controller);

This is saving the registers before we quiesce the controller, the
values might change underneath us.

> +		if (is_lpss_ssp(drv_data)) {
> +			struct pxa2xx_spi_controller *pdata =3D drv_data->controller_info;
> +			int i;
> +
> +			/* First de-assert resets by writing 7 to 0x204 (LPSS_PRIV_RESETS) */
> +			writel(7, ssp->mmio_base + 0x204);

Do all the is_lpss_spi() devices have the same base offset?

These magic numbers are not good.

--s6ZXI26aYxOCLzx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpVDC8ACgkQJNaLcl1U
h9AkqQf+Jvf+gr/R3lK2/ScBT1Gl3/HqzT24YoOo0DXAX9zLh7sPEy6Ha+sGsTe8
Kz2NrD47Qs8PvwmTMeD+CvPj5G8RVXXnXY9b2j7QmfqMUUtXbIk0ONfC/yeOi6dy
6773qMcbC4PYRZL7KBy54WciramYx9fFSN2Iz2GHSRSVeF9eNiHV/ZqZBSnKvipJ
sO1HAdXgofmpbIQFt6OH0Amy1kfeWyF+H5FB6gNQbFjAxgy/rZ0PSoOCPgReG+r0
szCZ41VbnmrV+Sy0hUGJXByvuyXG+V+qVeXAW2sgmwIgPbuSe39tEjX9VJvkG48s
cnHNPrPIK2QvEWaKp6gSd0rc/W7m3A==
=0Y3H
-----END PGP SIGNATURE-----

--s6ZXI26aYxOCLzx3--
