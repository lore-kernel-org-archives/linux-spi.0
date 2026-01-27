Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70A327C10;
	Tue, 27 Jan 2026 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551832; cv=none; b=la9xNtVi8/8gqOdYNQVErmOZq2EnbfN+QUYOv+NnoAoGepxoGz317IRmpVzDsCh8qS4SK3ZWK0x3z6u9pk6iiThnxFDEWtkw4L0hOYjUqbFi+3HKaOcCH5m67CgCLgDURJ90NnNN0uexkQkTIcklqLGremugZAg0LcV74HNQA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551832; c=relaxed/simple;
	bh=srC4Chwv/BTjScuQeP50SNnG1utEHvwKVit4KKdEf8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd340gE0rKI+P3cUphNs3vsj0J2smi+6Jc64LutQMW/G3SGtuq+b1AZ0CrDFfk4D9cLD6exr/DuUTIMbSC/c/TFN4ri/a+M2CwYzSEGmMfFd1nYd/HY5P768nB6pXVODBa+1as/IK3BHhDd3arRMymh6CjB+Jhhp69j8P+N+VhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8U4Ws7P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8U4Ws7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E80EC116C6;
	Tue, 27 Jan 2026 22:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769551832;
	bh=srC4Chwv/BTjScuQeP50SNnG1utEHvwKVit4KKdEf8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8U4Ws7PM9c8BI6IEefjY2XlzaPVtT8mUkhXD5ch8nHlQGo9GQwJi3R+V5hX9AxIj
	 2J6amGhX2dYYbIxR6s9Vmqv6UXvbb4vqRsptFIwh3g91Ma/LuitXHZW4JH5Xn62+wx
	 7p8CGt9n5wtrPRoWa18xZDVDUxgym4ixSHbv7FRvvQvPyqGtZ1fjUMEmVQxGpqH3OA
	 RhI4bjhaaT7mmYkfoAUVnpsp2UX5pB0BBonEFkBH4Xg6z54zXjn279BWc9sJrZ51BN
	 iLpMopDNC1aZyw7euKqmGtzhoyVgmgSEo0q0mLtB23Poh3PAYB4jDq45o4jNN4Zgir
	 bsqna6Q7paHGw==
Date: Tue, 27 Jan 2026 22:10:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw-mmio: support suspend/resume
Message-ID: <ffb79668-3007-4e5a-bcc5-38f404da3287@sirena.org.uk>
References: <20260122155046.12848-1-jszhang@kernel.org>
 <d0bd831a-08dd-4c2c-97e8-896f885cdbe8@sirena.org.uk>
 <aXjhcijjig79ocks@black.igk.intel.com>
 <6b89afd5-9e6c-45ed-835d-6e0d1906aa14@sirena.org.uk>
 <aXklYtTg-pqrT5sw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TZh9DBlDoRcPmwZL"
Content-Disposition: inline
In-Reply-To: <aXklYtTg-pqrT5sw@smile.fi.intel.com>
X-Cookie: I brake for chezlogs!


--TZh9DBlDoRcPmwZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 27, 2026 at 10:51:46PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 27, 2026 at 04:07:11PM +0000, Mark Brown wrote:
> > On Tue, Jan 27, 2026 at 05:01:54PM +0100, Andy Shevchenko wrote:

> > > We clearly can call clk_disable(), but I'm not sure unprepare is the stage that
> > > has no side-effects here.

> > What makes you say that disable is OK?

> It's (assumed to be) paired with clk_enable() in the resume.

I'm concerned that we might manage to get a remove() on a device in
suspend through some means.

> I was talking from CLK usage perspective. However, after looking
> at the resume implementation in drivers/base/power/main.c I think
> the failed resume of one device doesn't prevent it's removal or
> anything. It just collects statistics and records an error, but
> no other actions are taken. Which means anything that needs to
> be paired between suspend/resume and not checked at remove or
> shutdown is prone to the same problem.

Yes, exactly.  How likely that actually is to happen in practice is a
separate question of course.

--TZh9DBlDoRcPmwZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAml5N9MACgkQJNaLcl1U
h9DdAwf/ZYcbfggwqEipbyns3uzhfXLcnj71/bVygfgwq3zCY7IRcv3iWP2+8Mc9
2DJdT3+e0McJvayXlWy8xmvgewdQGOa00+TqaOKBYasAlCYdE/7m45GqG4Kjc9vn
jbtFzze+1Lq+4UekCRWT8v4f10crQpL1w2Gzykj9EomCb8iOej0KsoU3R4lYu8uF
92id/Xba9NnnKCDghFe9y+De59Rwh+MiQdfImUJIoRSyqP8OozLkQ8K+2XF0ifNW
CbOPpIkUiguo+81is1yAn7mSs6EVHbShwX706/83R/APfub4EIwdujgeZys65uyQ
yc2T5vABMAtUuVZcrU+nI1ogeBK45A==
=ufYw
-----END PGP SIGNATURE-----

--TZh9DBlDoRcPmwZL--
