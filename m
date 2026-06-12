Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D637DEA1;
	Fri, 12 Jun 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280519; cv=none; b=aBXiVozVwRNu3+FT+LEVI3B526VVyvhtb3OuriqII1ZvW+soDOySHT17htWDZyL8NJCcZ/4Oo3/lF6/ieWyPdreRAzw1M4BuemIi+GQLFzjY/v9rYuw7HmRvv6Y8chvT+5/G+HBFO/Paq4GGzalbh227z7eMb6GrfSKyvBKixAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280519; c=relaxed/simple;
	bh=hhUl3XwZZAj6/NFiqIzS9xsUsHsZqDPVOhzmupLJrjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObakqtOszvu0S3PxaB3ISJRxgrLi3uPVx8XMJ+iQI4Y3ZFaowBHc+xaA5ARWmfp/PngqgbeR6FYLNGcA5hU5SaNbagrdY1IAKqZet4fms13GCVz0U92+ImK7RO9bGDDVIV4VneBA6qV/pUWh14IVwYUj5ZZD4aoQc5h7cwCxElo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7EA1F000E9;
	Fri, 12 Jun 2026 16:08:37 +0000 (UTC)
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 60F911AC5AC2; Fri, 12 Jun 2026 17:08:35 +0100 (BST)
Date: Fri, 12 Jun 2026 17:08:35 +0100
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
Subject: Re: [PATCH v4 2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for
 timeout handler
Message-ID: <aiwvA4z45FUqzgiB@sirena.co.uk>
References: <cover.1781037385.git.va@nvidia.com>
 <2ed90a7d175f7967e621943b772115da655c477d.1781037385.git.va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LPxkVfs8jyUyi99U"
Content-Disposition: inline
In-Reply-To: <2ed90a7d175f7967e621943b772115da655c477d.1781037385.git.va@nvidia.com>
X-Cookie: Nice guys get sick.


--LPxkVfs8jyUyi99U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 06:24:01AM +0000, Vishwaroop A wrote:

>   - tegra_qspi_isr() reads QSPI_FIFO_STATUS and QSPI_TRANS_STATUS,
>     derives tx_status / rx_status, then publishes them via WRITE_ONCE()
>     and the trans_status cache via smp_store_release() before masking
>     and acking the controller IRQ.

>   - tegra_qspi_handle_timeout() consumes trans_status with a paired
>     smp_load_acquire(). The release/acquire pair guarantees that a
>     timeout handler which observes a non-zero trans_status also
>     observes the matching status_reg / tx_status / rx_status updates.

>   - tegra_qspi_setup_transfer_one() clears the cache with
>     smp_store_release() under the spinlock before unmasking the IRQ
>     for the new transfer, so a stale RDY bit from the previous
>     transfer cannot fool the timeout handler.

It looks like the CPU based transfer function supports multiple
interrupts per transfer, though the copybreak for switching to DMA is
FIFO sized so I'm not clear exactly when that might happen.  Can that
happen, and if so don't we need to clear trans_status when we handle the
interrupt as well?  It might be that this can't actually happen.

--LPxkVfs8jyUyi99U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmosLwIACgkQJNaLcl1U
h9Ab8wf+Mj/ot/6xv3SxptNFBXnqSih6mugC/UO8B/vfVIvlyGj15t+PVABKcOv6
fTsk5bbhAku7RZ0tht1fs4KFxrBUXEYA+33KCYY+ouSzmYW5Z/JkEwhCz8jyqU81
wuGXEdmwgsf9ClqOPbHv3woF3+M9stDdA22A/XP4OASJ+UUFAFxIHEY+S4GkWtSO
SQ/wOAxskMMx4QcY1a+dhyfK6qyFv8I3Z0ot674gFdEji9SQBj0ghSJHtjAQ/Chq
yuIb93evfgLaQMEEbNc1D/7HVzpqMBzeve86v0sIQaaLJHEX3L+H4ahNIq6q+njJ
aQTWBT7H5GRz8k8YyowlGnfBYTh2ng==
=hOor
-----END PGP SIGNATURE-----

--LPxkVfs8jyUyi99U--
