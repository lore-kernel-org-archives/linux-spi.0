Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F118A6DB;
	Sun, 19 Jul 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784471618; cv=none; b=ubQ5Nv5tKZ3HKvEAQwMMH/+P5yh4newf/rtDig+BxAbBQug2BrKjyA40a7pnEyptXoyuWN41jSWyiQMqlvZkwVK2YU31obBmPcquwv+jKiFja2HWFCIGo9dOavKiQAav22YTI6V/nbzUO3La/33L+M2tGx9Me4d1AWUSU7gzQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784471618; c=relaxed/simple;
	bh=Gn9gWvs0EvGT4P0iS4BOO81/3G7NJEialNsjD/Bqa18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtEHF/WRnGjYCS1ggdDcaGj9co5sAKE+mczZBMQFjaWPm1WnPIy2HIhxkvk8VV/TxI9iTVktyBbcbohAz4pEJw+GcD4ALKu+2OnDcHrgwiaW+PpzsSuqDRm2tXGWPDp+SHPz0tNh/YOMeICA4pQhoXVYjd2FmibZvPfPiU325S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0E31F000E9;
	Sun, 19 Jul 2026 14:33:34 +0000 (UTC)
Date: Sun, 19 Jul 2026 15:33:31 +0100
From: Mark Brown <broonie@debian.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Suresh Mangipudi <smangipudi@nvidia.com>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] spi: tegra210-quad: Convert to hard IRQ with
 high-priority workqueue
Message-ID: <bbc6a709-7c83-4866-8905-39ab4d8b3b77@sirena.org.uk>
References: <20260708011257.1712961-1-va@nvidia.com>
 <20260708011257.1712961-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6TkO5ubd5lUZO7Fm"
Content-Disposition: inline
In-Reply-To: <20260708011257.1712961-2-va@nvidia.com>
X-Cookie: Courage is grace under pressure.


--6TkO5ubd5lUZO7Fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2026 at 01:12:55AM +0000, Vishwaroop A wrote:

> Threaded IRQ handlers suffer from scheduler latency on heavily loaded
> systems, causing false transfer timeouts. Convert to a hard IRQ handler
> that schedules work on a high-priority unbound workqueue.

The high priority workqueue is a SCHED_NORMAL task with priority -20 so
it can be starved by real time tasks running at SCHED_FIFO, interrupt
threads are SCHED_FIFO (see the start of irq_thread()) so are harder to
starve.

> -	if (!t) {
> +static void tegra_qspi_work_handler(struct work_struct *work)
>  {

> -	 * If no transfer is in progress, check if this was a real interrupt
> -	 * that the timeout handler already processed, or a spurious one.
> +	 * tegra_qspi_handle_timeout() calls cancel_work_sync() before it
> +	 * invokes handle_{cpu,dma}_based_xfer() itself, so this work is

That's actually in patch 2 so we have a bisect issue here.  Not sure how
critical that is though.

--6TkO5ubd5lUZO7Fm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpc4DoACgkQJNaLcl1U
h9Bl+Af+IG+QSnMmd97Wop/tWRHPZMqaeWxEqHhvOLYMLyRvMchNFZaUZwoIbeea
6bn4XpMUmTmxBgyN6RaGnWxNEX2fAlvsldzg8ypMNMmF0WoEtoe6mUyfwIiQMcCb
MDf78yeO6/mVOJwvSJC68iwAaFV+9tA1D31G7TkfaEDE6+6pyuDZMfgKj7UJVcmg
wTyCtgIYr06/8fnnumvySlwY/RfvHEln/m9HHo5VG2jcH6xSdC9hNaKps/ilc8nq
xgMn+To76hDCYKYhvp+N49cj14Ee7zNepW06muRfGlde0qtSiUr8HABBrB5tpKQk
7VQn9YPsJoehZlKqBXFVEAZ8YIInlw==
=SIaD
-----END PGP SIGNATURE-----

--6TkO5ubd5lUZO7Fm--
