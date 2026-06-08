Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892E335BA7;
	Mon,  8 Jun 2026 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914698; cv=none; b=IBTDDp50rkYwJoPtesrPxvWKQK+Io/sS22GLT9UKBbIozEgekyqiyT1NVvsfa+HvBEoNwThNnWY9Ijkn99pnr96LAHHFJEksbvj1lRFfQZYQv4SPCH5L270F/WcdAs4uuUf/3b1e+2qoof6bWnHHIrml6GmB2//PyluJGNibsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914698; c=relaxed/simple;
	bh=k+dEObENb2yKf5zcDdJwxmqYYsK7PyCb7samBUUVHb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJjYBjEW04/XQa6Saia6npkmywNSPV5lO/kRXP6gOm8kx5u1aExB9ELjrfOG+83KcAK1fhUL/vzHwLSXL7L/0RhlWk5qFSZgguZPKwu4fR9Udi/q+OhRYTmTI8FjaC9km2lX08gCyhpVy4qa89d9wLWbXufJ3HhExiOg/8tsf1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGikl9AQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGikl9AQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C18B1F00893;
	Mon,  8 Jun 2026 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780914697;
	bh=gyJ1MxgMf/YV2lGjR0+TQwlqFXjFL6hZpHmvCzkcqpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TGikl9AQ8LBe892twjqstBGqB2fQfSS7hlknHLHY3hhjS8KkDv2U+Zr+P2dzCfNLO
	 DLPh1XMWA9f3ASDMjPjzahdCvnX3tvWt4eI9VeTooraPKQcbSl24olI6ZhUhGdmcSZ
	 ZE1jo2N8qmPFEtawjztiPQHJ+rQ5jUej+RFoosematWRlc6oClPtpjXa8L4BYEh7Kc
	 m+ytqIh/wE5nAtU39JnJAGGVit60TELAxOxj68MRleTsLQnWBboWRtlhqOUuDa5D+l
	 3J7P5EPf+EnOL1xDvS9nXFf7M9daac1+suTt5HxfgD0M/+dNEYUdWX3e41QeqspdX7
	 Sm+eRrLlircCw==
Date: Mon, 8 Jun 2026 11:31:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, Jisheng Zhang <jszhang@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-xspi: Revert COMPILE_TEST support
Message-ID: <a723320d-20e1-4e5d-8a11-d63f84bc8f69@sirena.org.uk>
References: <20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5DwTduOXkpVpT7Qh"
Content-Disposition: inline
In-Reply-To: <20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org>
X-Cookie: We've upped our standards, so up yours!


--5DwTduOXkpVpT7Qh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 06, 2026 at 03:26:04PM -0700, Nathan Chancellor wrote:
> Commit 0c5b5c40dc31 ("spi: cadence-xspi: Add COMPILE_TEST support")
> allows this driver to be built for 32-bit platforms, which causes a
> semantic conflict with commit 4954d4eca469 ("spi: cadence-xspi: Support
> 32bit and 64bit slave dma interface"), as readsq() and writesq() are
> only available when targeting 64-bit platforms:

>  config SPI_CADENCE_XSPI
>  	tristate "Cadence XSPI controller"
> -	depends on HAS_IOMEM || COMPILE_TEST
> -	depends on OF
> +	depends on OF && HAS_IOMEM && 64BIT
>  	depends on SPI_MEM

Why combine all these, they're not obviously related and HAS_IOMEM can
be turned off.

>  	help
>  	  Enable support for the Cadence XSPI Flash controller.
> diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xsp=
i.c
> index e2bfb0c78b82..e1b337789fce 100644
> --- a/drivers/spi/spi-cadence-xspi.c
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -22,10 +22,6 @@
>  #include <linux/bitrev.h>
>  #include <linux/util_macros.h>
> =20
> -#ifndef CONFIG_64BIT
> -#include <linux/io-64-nonatomic-lo-hi.h>
> -#endif
> -
>  #define CDNS_XSPI_MAGIC_NUM_VALUE	0x6522
>  #define CDNS_XSPI_MAX_BANKS		8
>  #define CDNS_XSPI_NAME			"cadence-xspi"
>=20
> ---
> base-commit: 4954d4eca469419339452cb5fea26dd0fc678c54
> change-id: 20260606-spi-cadence-xspi-revert-compile-testing-7919284daf5f
>=20
> Best regards,
> -- =20
> Cheers,
> Nathan
>=20

--5DwTduOXkpVpT7Qh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmommgQACgkQJNaLcl1U
h9CKfAf9EeUSPYESZGFgl+yH9QjfIBs6/hL29jqCnjA0S0Xvf9VTGr2i2rLjy2Al
HnNCbKzA9XWWdMlaXpRo1hlcrOW2FVtwCR3lN3+UYRl5MdNMUn2qe1JHpyDuYM84
H2rZmH/8S/ztvLDndEKh+4d9bUIxYepuc2by17UCpdKqu4DarkA9M8t+CwJAxvYu
RE5Nki4iDSWoY7s0KatdJXoPmabWWTo16JnvfcIK/bE4VaG4NV9IgFX08HGvYHPc
+3kIp5BlF3bSOJQ7IdVnsVkMDPcGTLWvaU9Gd13Gzp2JrOpXovFPcCfDiAEmG1uo
u6Gae3RLRQ1QleWLrjKx/1hxCtoU4w==
=4+/5
-----END PGP SIGNATURE-----

--5DwTduOXkpVpT7Qh--
