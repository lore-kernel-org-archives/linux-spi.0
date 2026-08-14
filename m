Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D1472521;
	Fri, 14 Aug 2026 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711801; cv=none; b=mrC3XKkeaCW2JWpTG40Be5ww+lAZOUoHXn6L8APn3j9vRLpoOrAgzs2I20GGCcL2wegRcLc8CwOZg+VE5wBG1gFME5u89fZlccAD2c2xkoMlnszZuqniu8H7d3bIjHI4AM3ItP5/4s2oD3oeXjJLGyeFLR3qWIejcyL8OA9sKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711801; c=relaxed/simple;
	bh=3TklQdqemkgoIXYlyCZS5WtzU7vc1hhNbPZ5FcaiImw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+/pE0lnUMu48z/hydDL5ZhC/mzkl2vBTKqezUnvMUKDQ/0L+d5ygpdSpa1zE/kTXVqV7Lxf0cVm3hcBTcPwoj6J/7mZye2qXtLJWxNhWInCkEPf1MGYdL59cixbgNhq18COLFn+xnZjCdzNk2cRMepKzbz25RCU3d54A9PdHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtfMxA7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtfMxA7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3901F00A3D;
	Fri, 14 Aug 2026 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711795;
	bh=Eol6eLHoqu7HuHR9wB+lOSHn9H+ZvhVg3MutcIPfN9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OtfMxA7eU6XuLTqNTVc8tnoW82ptVc/u2aWF3jPUqhQxmPa3W9sjrGR8JsEXM8zO6
	 Vw+H8crQmuZYrEzmexIBjJMXwSVXYsoCkJFkaq9H2hS2Rr+UVrpo79abWaxC0xCyWx
	 43e45m5BkCiYxKf/zOa7IjLOWBWXIL6qYRJTGPvkShcXSOrsKBN0fmXua0L+JNqLj/
	 rnNLY6CgpZkpEDNoqQZY7xrKTp66LZMvTVV5jnvrEkdBlZdKT/CLVkoHG8c50pkU5l
	 zY+1omVbkROI6IVIK21NydDmMMoIbL6Nq8egz9qFQIyGSe4NyHr8icQPGpOOy+VrvM
	 sxQK1TveniKRw==
Date: Fri, 14 Aug 2026 13:49:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Honghui Jiang <jiang_hh2019@163.com>, Andy Shevchenko <andy@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 4/4] spi: Add KUnit coverage for DMA mapping error
 paths
Message-ID: <93950eda-ee8e-4a28-8e3c-707d64c956fe@sirena.org.uk>
References: <20260814031419.43378-1-jiang_hh2019@163.com>
 <20260814031419.43378-5-jiang_hh2019@163.com>
 <an8JaNLIy4je-tiG@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VkLJR19Okf05R84I"
Content-Disposition: inline
In-Reply-To: <an8JaNLIy4je-tiG@ashevche-desk.local>
X-Cookie: Body by Nautilus, Brain by Mattel.


--VkLJR19Okf05R84I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 14, 2026 at 03:27:13PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 14, 2026 at 11:14:18AM +0800, Honghui Jiang wrote:

> > +++ b/tools/testing/kunit/configs/default.config
> > @@ -1,3 +1,4 @@
> >  CONFIG_KUNIT=y
> >  CONFIG_KUNIT_EXAMPLE_TEST=y
> >  CONFIG_KUNIT_ALL_TESTS=y
> > +CONFIG_SPI=y

> This is a stray change.

Well, one of the config changes is.  Clearly spi is critical enough to
be tested by default!  :P

--VkLJR19Okf05R84I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp/Du4ACgkQJNaLcl1U
h9BsCAf9E9436owfoOpp2YSJsHcXippykAK9tgZB3x05UYKy8dgNSzufoN9u9Czo
boNSu59ZdYvwDFmaXFtoP9KRggPIkcz5G8OaSU8VUJj35dhFM34lDSmh9oq61vK8
kZYkiTpZAnf2Beaq4PDSYFt+qNLf6chSlBgw4X9ZgLvLRtUtqBDc459Hj+6fgMaD
cgKdO1k/C7Df/c8JzfwUe5Fcl8apYn4ty7Pombp2Vgs14vYRZ3BzOvb0H1Hhohfm
gen7QYH29dD9LFbh55jbidjBOHJiDQVR/fYKgSbYkJYxpXPawx8InXeVrizpvyEn
0tdUbzfbszGMTOzJHkQYsEsK6rnupQ==
=9jNV
-----END PGP SIGNATURE-----

--VkLJR19Okf05R84I--
