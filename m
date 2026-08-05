Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E83F44EB;
	Wed,  5 Aug 2026 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785967067; cv=none; b=HhAnHVMz+2uhG0dAeZHJsnqih+BotnXge2BS88YNKVV//4l2HO01tWAfHORiqv4JGIq2mDragPNxvYvENaAPT3x3Sz82r+iZGY1P4TUQH5Unb1slb6sXGb+1Y86bgA1DB6RUpVSc234QF+KZXgv+4mk2SI7climrha/im2nl9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785967067; c=relaxed/simple;
	bh=UIHmsXpdNuWoFBoIbHiYhr7f75+sYin5ZiadL7/3Ujc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEDygBG8eVH2e9iwngoxmSpReIYXMrAU3SkXmANI0GlIESWpvS5z0hc68lntei78vSi5fyn6eMPDC29MI7XyGnYhhvc0gVyyDIlZ7zkD2sq3Ci2XIOpF4qx0a865aSfwDwlOMd9DCCteuHnqFZVTBoHkhRx5gokDzKa74L2TJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obyj/gHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obyj/gHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86D31F000E9;
	Wed,  5 Aug 2026 21:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785967065;
	bh=PCSg8wxXQwhweaduFBlyw+m+o1F9qQircZb9vnaMbtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=obyj/gHU7Ib0CMjbTv9GkuHY/GQv3uQ6kOmXJwiQQZ9ZeEC3kzS69gqi8F8ywO1+/
	 SiD+HkgIyCZEZxS4/CycEllptCtZxE4bpodASkq/QdWy85sEptetpdCWyL3Tijct0o
	 rKHjXS9XlXBRkxIC7KrEMRmnRhJoU/5ZUUPRQgv1BxvWDFYMG39yBluSVrfD4ORKei
	 jUuQaqmTQuzHkpzItIBBDEpQ1j4bWLumfj2rXDyI8mi5JevSPED669mG2mN/d+5xQF
	 2Av86COVyM7o48+6VRtfS/Q6xqhOaag0bg0HJOTkGM7HhalMgEacNRxYxOl1Jv9de8
	 plbBe+IP6kmZg==
Date: Wed, 5 Aug 2026 22:57:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Honghui Jiang <jiang_hh2019@163.com>
Cc: andy@kernel.org, andriy.shevchenko@linux.intel.com,
	fancer.lancer@gmail.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: Add KUnit coverage for DMA mapping error paths
Message-ID: <fbc72384-2f47-4577-859f-719d55a2a66a@sirena.org.uk>
References: <20260805151456.756579-1-jiang_hh2019@163.com>
 <20260805151456.756579-3-jiang_hh2019@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FrLLJjW7SGEwmpUS"
Content-Disposition: inline
In-Reply-To: <20260805151456.756579-3-jiang_hh2019@163.com>
X-Cookie: Stop ahead.


--FrLLJjW7SGEwmpUS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2026 at 11:14:56PM +0800, Honghui Jiang wrote:
> Add KUnit tests for the __spi_map_msg() error paths.  The tests verify
> that mappings created before a later TX or RX failure are unwound, their
> flags are cleared, and cur_{tx,rx}_dma_dev point to the device used for
> the mapping.

The tests themselves look good but some style/integration stuff:

> --- /dev/null
> +++ b/drivers/spi/.kunitconfig
> @@ -0,0 +1,4 @@
> +CONFIG_KUNIT=y
> +CONFIG_SPI=y
> +CONFIG_SPI_MASTER=y
> +CONFIG_SPI_KUNIT_TEST=y

This also needs enabling in the KUnit defconfigs in
tools/testing/kunit/configs.

> index 05a852494..42e337c54 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -5146,3 +5146,7 @@ static int __init spi_init(void)
>   * include needing to have boardinfo data structures be much more public.
>   */
>  postcore_initcall(spi_init);
> +
> +#ifdef CONFIG_SPI_KUNIT_TEST
> +#include "tests/spi_kunit.c"
> +#endif

If this is just so we can peer into the internals it'd be better to add
a local header for internals and build as a separate translation unit
like normal rather than doing this sort of bodge.

> diff --git a/drivers/spi/tests/spi_kunit.c b/drivers/spi/tests/spi_kunit.c

Everywhere else we use - as a separator.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for the SPI core DMA mapping error paths.
> + *

Please make the entire comment a C++ one so things look more intentional.

> + * The invariant under test:
> + *
> + *   When __spi_map_msg() returns an error, no transfer in the message may
> + *   still claim a DMA mapping.  Any transfer that was mapped before the
> + *   failure must have an empty SG table and a cleared *_sg_mapped flag.
> + *   ctlr->cur_{tx,rx}_dma_dev must identify the device used for this map,
> + *   rather than a device retained from an earlier message.

This is for one specific test, either this file should have a test
specific name with everything else namespaced to make room for further
tests or all this should go with the specific test.  This looks like a
DMA subsuite so possibly named after that?  The same applies to internal
identifiers.

--FrLLJjW7SGEwmpUS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpzsdQACgkQJNaLcl1U
h9B/fgf9Gw8KnvDf5UwgZX9s1UqYkz3M6ZVSVZErzXGtdvpsg0K8RKC83d+/wwK/
FOsOgSrvKAE5TcPV23+w4AIeAXI21HJNHFBZqemVFdQFA0CUYQI+Vgl4H2MSiDwf
SvWDJP6SwKuK9n17s21HoD8ociqKFk0vUyDXU+GZuOgbZhjot8AI9y0wPhpYw/vc
IWC2g853XkT9WhWSZFrVgwzVRgnIXpY2QMcy89fdrS8AVCYu64lSMhdSRsv7/PKm
Wn1bKrCUf9L9ViwxcTtkUgffwRBwK3wOExqAT7GufWnZKbgGmwUGIJjklvUFZY7Q
GV7qlI00LRqIAgLJNqdEoXsuC1lSjA==
=rpC4
-----END PGP SIGNATURE-----

--FrLLJjW7SGEwmpUS--
