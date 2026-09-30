Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C7538D81;
	Wed, 30 Sep 2026 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790050; cv=none; b=fwXovkcPbMvYF0093V3C+CnefZzMt1VabyAERj6w1F6IrI8/QEhDxxH41z6+7RFgyrXZAGKaXgUtyQyyVd6w4cWzBzTlx5aJ2I1Q0tdHzGoa7Hle6w+tTovBA1jFtww30xkJSaOMcM2H9AhFZd4IhcrbE4d77BVvvL50B5gD8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790050; c=relaxed/simple;
	bh=F/NvKDalXNIIfR6m4FdI5unaI125NQ8Aa6oYjU4JVHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSEw5YdVQh7K2CfNjaibSAKUk3/01fA79ibj6cfc+suCD4qFQRpa8TVWgo2cApM3XdKyU030d8le9dm0X42EaYLr0eLCDU5fm9uUCrXGS9DcyYDTbaG4D7bybEC0Kl0YkhPSqqVws4hbzMeJlLsx+Ql2Pvxj/9dH3xNROSMdrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEt7auJd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEt7auJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405CD1F00899;
	Wed, 30 Sep 2026 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790048;
	bh=pJxP02jgtsYKvx2G2NNGwZtK03ROopISrRswIgnOLg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mEt7auJdWJUg5J4oqGJ2f4A0mfumXKjZmabsGsBBUteaFnfqtPvpZKtBFwH9UyYp7
	 bcPXNFOyJ3QRNegNFvBCKJcfsgTxBiMGMiUrDrv1ri9eZ6u79p4vMGP/x3zXaUR1qr
	 Ff1JW3ph5GmwUZp3W/1BTDVm25dTpdKsBEBBshkAEu54gxLbXSC34+9BvI33WOKYWm
	 2iRPuaIV9fUtUKU2RurSggm7CK0Mg1vxfQsSoj9RUBwvwOLZU/2OQdHAlXEtoNuXSg
	 VtvyVweIeEVf0PGQIaSnXjS88RxMQMuNPACKeMNPPHLrc4stAurlwhnkddei1deHAd
	 4MsXVgJD/5hoQ==
Date: Wed, 30 Sep 2026 18:40:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v17 3/6] spi: pxa2xx: acquire active PM runtime reference
 in interrupt handler
Message-ID: <2070ad49-b017-4caf-822d-0ad8ef520f79@sirena.org.uk>
References: <20260930160629.1822-1-fourdollars@debian.org>
 <20260930160629.1822-4-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GTUHbOsFbl4ZReX2"
Content-Disposition: inline
In-Reply-To: <20260930160629.1822-4-fourdollars@debian.org>
X-Cookie: (null cookie


--GTUHbOsFbl4ZReX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 12:06:26AM +0800, Shih-Yuan Lee wrote:
> On a shared interrupt line, ssp_int() can be invoked while the SPI
> controller is suspended or transitioning power states. In ssp_int(),
> evaluating device power state without acquiring a reference before
> accessing MMIO registers is not atomic: another thread executing
> pm_runtime_suspend() can drop the last reference and gate the clock
> immediately after the check passes. Accessing unclocked registers then
> leads to PCIe Completion Timeouts and system hangs.

> @@ -1464,22 +1481,31 @@ int pxa2xx_spi_probe(struct device *dev, struct s=
sp_device *ssp,
>  		}
>  	}
> =20
> +	ret =3D request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
> +			drv_data);
> +	if (ret < 0) {
> +		ret =3D dev_err_probe(dev, ret, "cannot get IRQ %d\n", ssp->irq);
> +		goto out_error_clock_enabled;
> +	}
> +
>  	/* Register with the SPI framework */
>  	dev_set_drvdata(dev, drv_data);

We need the driver data before we request the interrupt, the interrupt
handler does runtime PM and the runtime PM operations use driver data.

--GTUHbOsFbl4ZReX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq9SZoACgkQJNaLcl1U
h9Cs3Af+LNc0+SJ5Y6YknMd3CLLOdUOalJr8UqvKUwpHVit5RsQkYbKXimsWEmFP
k1lEO3dyX+h0QhqFL3txzMQimFFnnfHTZAhXhDEVl8999xlNFmW+1k0Bwk6xesxd
StLhG6GcLi1zPl+8VAkYq5MJzxy8fxBwjO3umEzlcnLaw3c+t9Y/IVmTrY9SKaU3
hpir4cMgqB9pmtC84uegwD4jzZmvjBGkIsV+NwkkEP6DI9TjJQvnEHY0cqkiyLZh
kLww5lxAs5xzfeLshBt9WVgNJx3kn1AmRMmUyIjZ+BksvEr/IYkQDu6n4RkcBY17
a6jYxCY3E6mrmrkqTvFfQrf8MG2sgA==
=vbC9
-----END PGP SIGNATURE-----

--GTUHbOsFbl4ZReX2--
