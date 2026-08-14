Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA924908B4;
	Fri, 14 Aug 2026 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729305; cv=none; b=GPXrWiBb4iA/n/O1q/DyfhPWeDXuWLtpVwpU/DQJMQ/7Z85N7A2UmTgXYniq1HhBhQqlYnTd5x1d1nsig59OjaK8Pt/Fqer3Baoc8OWy5prjh8cgXLLm0fTx2siqn8FhpBVZOmwTiePARIGljh+HH3OjGx86WQCmONiNaYq8KAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729305; c=relaxed/simple;
	bh=ZaI4ojQJI8KLdxZWDMHAqMT1JrJovr0G8iAVI9gyhZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ7dnfI8Lch90uGEIa9tFIFSshuJ4YpmL/WH56uIZviNtuFy0pD6hq0Reljw4GiB7oZAqYLvltAcpKrHHXcyiH0lG/qm0bfKqa8fV2HMV5e1YBtuIlOziVu77XKsnIZ+2amYQ8R+8hSxmM3WrF85WYI0m4NCM+w6RgQy/Fbv8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9c3vXC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9c3vXC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19861F000E9;
	Fri, 14 Aug 2026 17:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729304;
	bh=Y+u7FXSJY3hzwnNhU+/OewoWE7AAIpifvv43gvfjulU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V9c3vXC2cp8blKnbjgidRWJ+jo1+SLnr+PG0FJcoE5YPvVIqMIEkSpN7N0vgprMp8
	 5WNnmzHJ16Uxt9Eyn5fpq9NHRCETB+8JjPOzayvK2TehvwNaMs8v3LCctqTGAT0mf3
	 VD2BtwDTYBIsIrk7YnvUm8ocVKlD8HPF7gizY8w64ahaiAKRgRb2lFdg2zhlauV6vp
	 4m+1Gp4TvQ2N0YT7fnRelZswf+friQj8ZEonRm1jL6TFr5YLpZJ0FxGDEV3nap4ush
	 E/tUVYcuJeyFnnOktQIPNkQran8qsfwvpnJbQBGnFbyFL3Im05TqJaHp45/fgWMK1i
	 RODb7DiZ5vqUQ==
Date: Fri, 14 Aug 2026 18:41:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Honghui Jiang <jiang_hh2019@163.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 4/4] spi: Add KUnit coverage for DMA mapping error
 paths
Message-ID: <3b3f84f5-b922-4a97-ae16-1f380035a53a@sirena.org.uk>
References: <20260814031419.43378-1-jiang_hh2019@163.com>
 <20260814031419.43378-5-jiang_hh2019@163.com>
 <an8JaNLIy4je-tiG@ashevche-desk.local>
 <93950eda-ee8e-4a28-8e3c-707d64c956fe@sirena.org.uk>
 <53943105.8b50.1a0015a531c.Coremail.jiang_hh2019@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vL6qZ56Kaxp7GABN"
Content-Disposition: inline
In-Reply-To: <53943105.8b50.1a0015a531c.Coremail.jiang_hh2019@163.com>
X-Cookie: Body by Nautilus, Brain by Mattel.


--vL6qZ56Kaxp7GABN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2026 at 01:38:11AM +0800, Honghui  Jiang wrote:
> On Fri, Aug 14, 2026 at 01:49:50PM +0100, Mark Brown wrote:

> > Well, one of the config changes is.  Clearly spi is critical enough to
> > be tested by default!  :P

> Thanks, both. I'll drop CONFIG_SPI=y from default.config in v3 and keep
> it in all_tests.config.

It's OK, I deleted the extra change locally - no need to resend unless
my CI blows up.

--vL6qZ56Kaxp7GABN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp/U1IACgkQJNaLcl1U
h9B0bQf9HECSF2EjFIh7o0n2WvZC8+Gsod813EvFuSCF6JqmW8Ne0EIWIkIXQjmG
INqKZWXOruGAs2oYhkoueQQ9UukuXn7PiVp7vSDrBd9G8w3npSjJ5FftYuL1PMRG
bQaT6NYBW5sF71PVegxApxZ+GaQSnKFLm9gUVE5ajuCiSMCPfjefUhr7IXlrgSxb
4up+1EX57B5B0wmRGn31puRZAjVzX+89v7PReE0iwc6VlHdd2CvkTIp+dLj+TKQd
0opUawCO/Chw8j8b04mBRdZHrEeON5JJw2ZCM9e/2eHryg3FNq4kduhE29olcOw0
fU27FeaZSKyZyI78o0tC4g7r3/wUpg==
=6PY6
-----END PGP SIGNATURE-----

--vL6qZ56Kaxp7GABN--
