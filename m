Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FF33DEF9;
	Tue, 20 Jan 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927983; cv=none; b=V8IpksQgFqIjS9q2BjJGHBQm6DMzg1GPERMTe1TXP1oEUOdaNdbIKzaukYzUxlbstizBKFIG9W6U7w8urW/h7SwQFVVd0gT65uQGAGC14DXh8d4a2Lymadz2hldf2NtqaJXrvGr4TtLCnaf+Nhv9cUs6raQMu2x/hRu+GrmNVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927983; c=relaxed/simple;
	bh=Ger41I8x6kqqHGn743sCsSsB7ojX5dsspT8FOm5T+W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9NXui7qB1slnefNSWL+w9VmKt57WleVNpRERq0ibyJ9qcWtKP2TDDDtrVL5cuR0r3TVzfL75H/L0rtAbbyhzYo3EKdQanZhGZ31BCNYPUxRxL/O/x7I/XpPpRhpFyXHUmIqo44y718LHR6s+EBxiNTmBnxg95JT0Cqba7A6fJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F8FC16AAE;
	Tue, 20 Jan 2026 16:52:56 +0000 (UTC)
Date: Tue, 20 Jan 2026 16:52:53 +0000
From: Mark Brown <broonie@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Vishwaroop A <va@nvidia.com>, thierry.reding@gmail.com,
	treding@nvidia.com, jonathanh@nvidia.com, skomatineni@nvidia.com,
	ldewangan@nvidia.com, linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, puranjay@kernel.org, usamaarif642@gmail.com
Subject: Re: [PATCH 0/6] spi: tegra-qspi: Fix race condition causing NULL
 pointer dereference and spurious IRQ
Message-ID: <0cba7a42-f322-48c8-ae89-966779355420@sirena.org.uk>
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
 <20260120112242.3766700-1-va@nvidia.com>
 <aW-seUXIJv4Lz7bK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4BCuffH8cCdM3zc9"
Content-Disposition: inline
In-Reply-To: <aW-seUXIJv4Lz7bK@gmail.com>
X-Cookie: Slippery when wet.


--4BCuffH8cCdM3zc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 20, 2026 at 08:49:23AM -0800, Breno Leitao wrote:
> On Tue, Jan 20, 2026 at 11:22:42AM +0000, Vishwaroop A wrote:

> -       if (!tqspi->curr_xfer)
> +       if (!tqspi->curr_xfer) {
> +               /* Spurious interrupt - transfer not ready */
> +               if (!(status & QSPI_RDY))
> +                       return IRQ_HANDLED;
> +               /* Real interrupt, already handled by timeout path */
>                 return IRQ_NONE;
> +       }

IRQ_NONE means that there was no interrupt flagged by the hardware, if
there was an interrupt you should return IRQ_HANDLED.  You might confuse
genirq if you flag it spuriously.

--4BCuffH8cCdM3zc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlvsuQACgkQJNaLcl1U
h9D8FQf+NkYChgWwqjcsZfFdF/vvQsvS8zmlpHHQwO4TKImqgDFA6yN854wf9MZ/
JA45cUZha9G/kqfgK983F5w1WdLGxc15OG0/DzCihsS1D+t/NOwKKObwHwxAhzYa
FfADNvXYEegiprKwRNpFwX1QwK4xB3g1cBhg6tr5yQAYnvScRJtBEajHi1Yi2IxH
4jO+zYzgrSiVlrnEOX7r/GFQ/jkLSXoaqfbvbKgx1lWpjsLP+XwyyfG6OzZIg+P6
AzWIDTlvUifvCi/7tGk+NPWOrAatuj68KGr2hpEV6k1wBnAjt0x6hB+prDFef14J
5dSnyIZlVeRzBaWeb0LxnG8IkZjQjw==
=dVgB
-----END PGP SIGNATURE-----

--4BCuffH8cCdM3zc9--
