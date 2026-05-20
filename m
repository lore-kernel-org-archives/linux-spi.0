Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0743F166E;
	Wed, 20 May 2026 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297309; cv=none; b=o3Z+evZXj4wFYA2S6jxB4LIcSFsCCHY5X36XgNcfS9CzyEsXOw9iheKyf33lVZZrC/4eLuAXFqIxDTFF97u9z3dvPuAub+A0IvkIdAONzlwz2x1dKd4LIfCJxCcyYna7UE6OCQSk9iQwTg60lj3bA3H3BjT/y6kc7WqP6ENI1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297309; c=relaxed/simple;
	bh=z109xjiyBg/bPW3+PiTLkzKdPTHhD3Ay+xR/mXYoMEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4ZqkOYUBtF5YaTEEaIXTFxuxoTsibB8p/XZ+qM9ZTWT/E6SBewexmCpmPXZwbm7y2aH4Lz2xL6CWuhZ4mUk2mvoRH6zmhUgCPIqnD9v21T4ofXfE0LeR+oPi3wW8j8sDaki7+emvzzqvtEElLNw8dtU6DwJn/6hmxW2pNmMv6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqT7fhx7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqT7fhx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A77E1F000E9;
	Wed, 20 May 2026 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779297308;
	bh=z109xjiyBg/bPW3+PiTLkzKdPTHhD3Ay+xR/mXYoMEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CqT7fhx77TCpuMbuhrlTqYgBZYlFFNNlXV7NLvl2cYxSJFp1On1t7a3MFkchRYMML
	 i9uftMVnXde9CO6SC3VEOjxk4uNMzsz0X3YeBBwv1kToAsdTXli1MzxNaqVAmVh6EV
	 kOqr7mID/YncOa8o65dWvA0U3orC2m0Gaq6xSVCXY15MuHISXvZ7PQ0plZr4ATvCCK
	 a6U391SiHV7ToWhVw6gkQLfcHkPJXRXS8BEGFC6qx0KWsHqaX7N8VfgSD44I9up2zQ
	 t+yfcmXn527vrh8nur60uB+6Z2oseDHd29PjwNIPYKzlYIF90+aYfITJ1MEYOX6QyW
	 quXgmmujtKRhA==
Date: Wed, 20 May 2026 18:15:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Thomas Lin <thomas_lin@lecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, hoan@os.amperecomputing.com, linusw@kernel.org,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com, andi.shyti@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
	lucas_hao@lecomputing.com, puntar_liu@lecomputing.com,
	jihua_tao@lecomputing.com, stan_xu@lecomputing.com,
	lumin_liu@lecomputing.com, notics_zhang@lecomputing.com,
	braden_zhang@lecomputing.com, harold_wu@lecomputing.com,
	will_zhang@lecomputing.com, aurora_jiang@lecomputing.com,
	ryen_lin@lecomputing.com, andy_jiang@lecomputing.com
Subject: Re: [PATCH v4 1/3] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs
Message-ID: <bf8f5861-5f05-4474-9acb-d29e4e627d2f@sirena.org.uk>
References: <20260520081140.637637-1-thomas_lin@lecomputing.com>
 <20260520081140.637637-2-thomas_lin@lecomputing.com>
 <CAMRc=MfM38h=zJU5Uy7zu9pigjb-XBAteBhUmvMAKZRWHGZNKA@mail.gmail.com>
 <cc8dc59e-fc00-4f7b-9f24-467c670c5615@sirena.org.uk>
 <ag3rSq-gx5bruPNW@shikoro>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9n25FFpVf1QMg//d"
Content-Disposition: inline
In-Reply-To: <ag3rSq-gx5bruPNW@shikoro>
X-Cookie: Natural laws have no pity.


--9n25FFpVf1QMg//d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2026 at 07:11:38PM +0200, Wolfram Sang wrote:
> On Wed, May 20, 2026 at 04:24:12PM +0100, Mark Brown wrote:

> > AFAICT any dependency that exists is runtime only, it's just a bunch of
> > quirks and none of the patches touch header files.

> Patch 3 depends on patch 2. So, maybe it can go all in via GPIO?

Oh, right - you'd end up with a trivial add/add conflict.

--9n25FFpVf1QMg//d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoN7BQACgkQJNaLcl1U
h9BNrQf/WRWomgWQ1dKj/HymX4SC3BAekCw2hGDX01llBikowEWmDd3O8Zeu4ZCw
XB6jILk78biHcICrLc6PtUZLTH9FauUODZknzAHVdObeN28E8EDoHfx4427PoRK4
GTKNNjqappq+GS8t8DslM1JJkWoqLeJmUQf69Jj1HYrbhJ3tgShxlR70itB1utKx
/ES0WmGmrDfFS/BXx0aVlOFfDMwNFcFTs+aYH0mpKAIvr30Y1zSssxElkgz7lEbo
hAYfjmTyT4/4DhMPNpRseUJ0X2mj8U7KXmQTS8S4LJ2i5+JlQYhAkKE9x8+JPyJW
kX7uWINAjDW7GrL3buq0O012qUHGxQ==
=o2ta
-----END PGP SIGNATURE-----

--9n25FFpVf1QMg//d--
