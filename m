Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5151E458;
	Wed, 30 Sep 2026 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789505; cv=none; b=IM4bOAPd3RGTv5og5jLpf6xabSfhH+Kh2rmR8AHQTw5axTOaP7S5namnCB/js2EkU5N5PCatBOCgpIaHzvPfGkHdXaNcDO9436IHA7efgnlAY8+b2WTgi8eA8otUmHCHFEXos8v3jFNgVkWtarq0X43Ul4cDbepcT9BDyF6ATNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789505; c=relaxed/simple;
	bh=Y2LwRdtHxMRHwvsRXA7tplZ36k6KiAtaEcHtl1BHZAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4xNLk4EGlnsb6r18Tgh/wNfBRMiG8hOQqP6gmYi0jRDGDM56TK4VMjkrVf3RjWLsvEdxjXoXKZLEeclRyZLrIAO9D6ktflLHVtR3qMrlAYIkbDgJatrbBQjhicSVheg3tSw75zCOfwtXUI2l2UWlsyR+oAbDEyl/2JGt0UCI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130CB1F00899;
	Wed, 30 Sep 2026 17:31:41 +0000 (UTC)
Date: Wed, 30 Sep 2026 18:31:39 +0100
From: Mark Brown <broonie@debian.org>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v17 2/6] spi: pxa2xx: introduce clock enable and disable
 helper functions
Message-ID: <4fafe6fd-b97d-4887-8788-b925cf7167eb@sirena.org.uk>
References: <20260930160629.1822-1-fourdollars@debian.org>
 <20260930160629.1822-3-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kKefU3zr1yzK+k5m"
Content-Disposition: inline
In-Reply-To: <20260930160629.1822-3-fourdollars@debian.org>
X-Cookie: (null cookie


--kKefU3zr1yzK+k5m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 12:06:25AM +0800, Shih-Yuan Lee wrote:
> The driver enables and disables the SOC clock during probe, teardown,
> and power management callbacks. Directly calling clk_disable_unprepare()
> when the clock is already disabled=E2=80=94such as when removing a device=
 that
> is runtime-suspended=E2=80=94causes an unbalanced clock disable warning f=
rom the
> Common Clock Framework.

> Introduce pxa2xx_spi_clk_enable() and pxa2xx_spi_clk_disable() helper
> functions that track the clock state with a 'clk_enabled' boolean flag
> protected by a 'clk_lock' mutex in struct driver_data. These helpers
> make clock toggling idempotent: repeated enable or disable invocations
> are safe no-ops serialized by clk_lock.

What problem is this solving?  Usually if something is dropping a
reference to a shared resource like a clock without knowing if it took
it then whatever else might have been using the resource is going to be
broken when the clock suddenly vanishes underneath it.  If we are
coordinating properly we shouldn't need the flag, the refcount should be
good enough.


--kKefU3zr1yzK+k5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq9R3oACgkQJNaLcl1U
h9BgaQf9GKUrZjBxMYFeduDpMZivWsKGhWAQfS09vbG6cAlOgj6pHjVr39I8Rar4
ujG/YQSqeMlV84iVKuASSZrDXCShHolBrCI2gqXlWXhdUx4E/r01bmj6N6dbUY4H
3d5PJAGhPmOGMy2ZtoHbH+hkK4nq4ojlLI8wnAD6m8yHJXZHOWKimYlunYjC3SnQ
jOng8rJY1Y8z1f70hs3thctQrG0SDB7sTNEZDlE9XG6uzK4VVz+AIOT4AVEnsyu9
iJVBj1PxW3vKvw4HvcqJQUlshwimBZYkMJcbGoEv8BhjWj3FONc47TTdMB47lu92
0AvsySe5Pdk7TIXSFZa3W0tG6N4Whw==
=eMDF
-----END PGP SIGNATURE-----

--kKefU3zr1yzK+k5m--
