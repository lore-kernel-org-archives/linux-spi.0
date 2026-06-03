Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763143C04B;
	Wed,  3 Jun 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479064; cv=none; b=cwJYz5K2Ejx79PT7ejUNNoEMt/3OqjBgobl1l88C/+UaruYixBeh4VYkawxw08NqRxBF3lG3pPDAVfaAZa3DdusWOJ54LnmmIxyQQynKoNsTO/uxnxdJVbid/+vE8FvFZFKgeBgdvYAT2ermXoLxl2W5/0EUfBMAvE1LQH+AxTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479064; c=relaxed/simple;
	bh=emg/Jr2AK/rp3uG3OGfjNJgCPPs0dyU3KM+4DpGshSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou4mzYIR+acDU0xibdIf/qtud7oSXIML0beJNZuJTEDN4GdE98qnv3aJ59LoUQJQqU7yMOVMvcn7ofQTeCrWlLE3HbEw/jUJWOZ9gvhBe/KvUKEQfKNaX6xVtoh01eP+YXxerBFf0iVFXSbrKBTUK/knYLwlgQvWtrLinkSYg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKLZwikI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKLZwikI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BFD1F00893;
	Wed,  3 Jun 2026 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780479063;
	bh=9AerHmbjV83y9A55r5tKc0QfFhPXJXRVsUh6a0eEv+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gKLZwikIl6VoRszNhPOK/+zp4BVbh6zVW6r8nz2fnlagc02qK642z4MrYzSbbssSw
	 e7JRRtsWorSrBHsqNO4xQhZX12YvUZbRJbVTQ2g2v0dWqWlV7FcMsFv/gwZ1YbvAz0
	 +vUddHj3B1Vt+6On03NYjYrOLTNGii7X2GDulHv8wWBGP1eMar/AVYvKii2fLfKfrm
	 0lkbEmJx1jNscxT8WjJBtidHIfJBhvcIAVXKh6fs6J0R4qn80HyhT5CqDeW90HtbMU
	 qGIcCmuNydBim+RvY5zxFR24oGjQ8AdFIwPqZNwo0cswOM4hMbD0viAWZ5Pj1Y6t2d
	 hnbSm0QXnB0Yg==
Date: Wed, 3 Jun 2026 10:30:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: Re: [PATCH 2/2] spi: Add Nuvoton MA35D1 QSPI controller support
Message-ID: <d32634eb-4eed-46e6-b378-d42df0b1c75e@sirena.org.uk>
References: <20260603043551.1062112-1-cwweng.linux@gmail.com>
 <20260603043551.1062112-3-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UGarUI9v4pCN0SBM"
Content-Disposition: inline
In-Reply-To: <20260603043551.1062112-3-cwweng.linux@gmail.com>
X-Cookie: micro:


--UGarUI9v4pCN0SBM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2026 at 12:35:51PM +0800, Chi-Wen Weng wrote:

> +config SPI_MA35D1_QSPI
> +	tristate "Nuvoton MA35D1 QSPI Controller"
> +	help
> +	  This driver provides support for Nuvoton MA35D1
> +	  QSPI controller in master mode.
> +

Other drivers for this SoC seem to have ARCH_MA35 || COMPILE_TEST?

> @@ -0,0 +1,579 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Nuvoton MA35D1 QSPI controller driver
> + *
> + * Copyright (c) 2026 Nuvoton Technology Corp.
> + * Author: Chi-Wen Weng <cwweng@nuvoton.com>
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +static void nuvoton_qspi_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
> +	unsigned int cs = spi_get_chipselect(spi, 0);
> +	u32 mask;
> +	u32 val;
> +
> +	if (cs == 0)
> +		mask = NUVOTON_QSPI_SSCTL_SS0_MASK;
> +	else
> +		mask = NUVOTON_QSPI_SSCTL_SS1_MASK;
> +
> +	val = nuvoton_qspi_read(qspi, NUVOTON_QSPI_SSCTL_OFFSET);
> +
> +	/* SPI core passes enable=true when CS is asserted (typically active-low) */
> +	if (enable)
> +		val |= mask;
> +	else
> +		val &= ~mask;
> +
> +	nuvoton_qspi_write(qspi, val, NUVOTON_QSPI_SSCTL_OFFSET);
> +}

Note that the core deals with SPI_CS_HIGH, the driver doesn't need to...

> +static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
> +				    const struct spi_mem_op *op)
> +{
> +	struct spi_device *spi = mem->spi;
> +	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
> +	u8 addr[4];
> +	int ret;
> +	int i;
> +
> +	ret = nuvoton_qspi_setup_transfer(spi, NULL);
> +	if (ret)
> +		return ret;

This uses spi->max_speed_hz but spi_mem configures p->max_freq which you
should use (it might be lower).

> +
> +	nuvoton_qspi_set_cs(spi, true);

...except where you're calling in directly at which point the driver
needs to figure this out.

--UGarUI9v4pCN0SBM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmof9FEACgkQJNaLcl1U
h9AGigf+PXAtexduRP/S5ai2U1yA1oOZHH5GxgE1+Oyoyq8Z+QkGmkVCjl4ru80E
7R1XMoIB0CB46+Pkd4+3bvwxfWTqLtrdknVUatHO/QcvWOezFdEk3sPF3XOyEfdH
S/u1vxPWFi+L6ywy2OdG0gFt7aYJIZAc7l1SZNe5C7Ck0HLpY1O5sajk+Gu08tY5
UeskE7hA23JmD14+jzbM8yMVyVHVYNwpIq9Y2cfA7I8Hxe+wkLVGnN46FIgzXrsI
ZwHk1Y48hGsKqqHjLdkiYvv5kHAKI+3uoJNicUuhycLo9980PDh999clA/7+RPUL
Uzf+IFtyZ0vuj1TsWQ90yUArWSfLLw==
=PW/z
-----END PGP SIGNATURE-----

--UGarUI9v4pCN0SBM--
