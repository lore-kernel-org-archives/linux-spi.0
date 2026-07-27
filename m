Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E837F728;
	Mon, 27 Jul 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163988; cv=none; b=dTWLpOuHqmKz2GpMB5kJPCPvBST7LqULcV4I7UiSx1FX+AaBjRb4cAFv/NvCPC1S4wi5Q4VDnCuQ0YR3PVLxwSANtUQWzJdoQpGs79YlwohMY5cYh0rInU2g98sCqtOuwBK69TL//STkpemxmit41S3vGh3U70/xF0PRbkei5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163988; c=relaxed/simple;
	bh=P1cqhPDBp7qKcokX06q/7QI0+YnURTviobzkdCnDGhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSBZXhdIm4iggZEq/1hPY/fLtalf5sAk+uxq9lHYp60sqOs6bcGCtsD6icNMPOLO373Zncpy0GHzMOFb5KAS4ME35eUKv10bhrL8vNHye82UWSwmaV/3C9danhtbg7QexLUNnLXecnJ2OLQdzh7Fvq/12KBt9FGxlWYf5hlMTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKk9gQ6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKk9gQ6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FAA1F00A3A;
	Mon, 27 Jul 2026 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163986;
	bh=GgYRgnZIQ/83JLPMS6O8UlL90vEuvFgUNm1GadO5RRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZKk9gQ6RdEqoCrMcx/EUjKWfHygw5k4in/o7hFf4ctW4rAznXC0vMoonNtxTdq1oU
	 5oFmU3t2GxkhW9/YKfhy1Z36uGPNjU4qqAEl14ztrvRkxTYIqWGgU1y0n7M3mumoqj
	 gwxsjZ+aE1YRvwkKNLSeE3OkBstMvnqgE6RwF5WWiB9/jqrXLhcPtv6vdGM8rdrABF
	 6ivvHhJ2RquNnImItfmHfcVvN2D3nSdapscyROf2lN0OIfEuxLmOTd7ZDz5Wg/Yal0
	 3lIHbvk3RMkF7YirtBtEHHcZ1peBdCjwnCA/f+P8C4+CtDHXNyxnN/6qU8JWhg0Y/c
	 6KEK4qlnO+A+w==
Date: Mon, 27 Jul 2026 15:53:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonathanh@nvidia.com, thierry.reding@gmail.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 1/2] spi: add new_device/delete_device sysfs interface
Message-ID: <3d714de1-c895-4700-906e-ff324cbfb048@sirena.org.uk>
References: <cover.1784000000.git.va@nvidia.com>
 <20260714100947.1871359-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dyQaVNmmSwVglcpo"
Content-Disposition: inline
In-Reply-To: <20260714100947.1871359-1-va@nvidia.com>
X-Cookie: It's OKAY -- I'm an INTELLECTUAL, too.


--dyQaVNmmSwVglcpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2026 at 10:09:43AM +0000, Vishwaroop A wrote:
> Development boards such as the Jetson AGX Orin expose SPI buses
> on expansion headers (e.g. the 40-pin header) so that users can
> connect and interact with SPI peripherals from userspace. The
> standard way to get /dev/spidevB.C character device nodes for
> this purpose is to register spi_device instances backed by the
> spidev driver.

> +new_device_store(struct device *dev, struct device_attribute *attr,
> +		 const char *buf, size_t count)
> +{

> +	if (blank - buf > SPI_NAME_SIZE - 1) {
> +		dev_err(dev, "%s: Invalid device name\n", "new_device");
> +		return -EINVAL;
> +	}

What about empty names (" 0")?

>  static const struct attribute_group *spi_controller_groups[] = {
>  	&spi_controller_statistics_group,
> +	&spi_controller_userspace_group,
>  	NULL,
>  };

It looks like there's an issue with cleanup here when a controller is
probing, the userspace interface will appear when the device is
registered but that's part way through setting up the controller, before
we've finished sitting up the devices from the firmware and the queue.
We probably need to manually register this as the last step of
controller bringup, we can't defer the device for long enough as we need
it to create the children.

--dyQaVNmmSwVglcpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpncM4ACgkQJNaLcl1U
h9D6Pwf/ZkClNxLCcwlgiNQoFGrg064F47SAKpk3yJClF76e43XokmuXdO4zjhxc
gJWhiqdb64IQ5mST4VtA8yIMXmiM2U+JpzTOzPrjW6jGcjTVtw0TLxTDTWI1PUbw
PK5bBQVEMuGQ1M5/V+pv4ZmTk6ymPNpiHMSrGQdFXhDb17glkINyMGM/TqalUw77
k0iLcf8cn1MOsx6z5uyLfB4+14f4ub/R5hmV313YlTy1lobTzky01bow5X5f2JF8
QHdlOdHHESpj4IX5pLNtm4+Rpb1von5VPCJ58uzdWkbcr/uFNvPhPix+Xn80NKye
lk9zd9TquR4PhoDwFNwYWwZmNlYqwA==
=3S/D
-----END PGP SIGNATURE-----

--dyQaVNmmSwVglcpo--
