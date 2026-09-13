Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5739CD0C;
	Sun, 13 Sep 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789299265; cv=none; b=Xtjfod8tL/sO0vmpeyfakKQ7kbFEbTOO6pPvfeWXvAMoNGaSYKodaPjqcvZbcRH4xkAmEZIPo8n0sVCdIUFgsezqTw1woHO54BBCUX6E86OXQbP+iACQrqLZ8H+XBJBD1SNxfihc/dfod9LZGOo+/s3xvqVFuVaXIjTq1cMEr5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789299265; c=relaxed/simple;
	bh=eqmYMNWXm2PS32PWATDXedLh2UIRpr7LtOC/6nDcHj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAAiYVSvkJv1c1wgwLZ8fPL+WDaIdbVrmKg3C2nfo4Y2d821ChF5Cq8OYrqtqvpRFv7MdJfSBQ8mr0RKWyjwvu9yGhyPmi0O25gclD0xZSKfbMZMidRxcJp0nZnKSAL+Lf7dOZp08kpZzfTsmGNS460NDHomX8Pae6buFuwgaWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRVLq5JF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRVLq5JF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8237E1F000FF;
	Sun, 13 Sep 2026 11:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789299263;
	bh=eqmYMNWXm2PS32PWATDXedLh2UIRpr7LtOC/6nDcHj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aRVLq5JFfmgQKaElgN9hARd2PubXgi6NeRv/TslJWttkklDgADNXdjSt9xm2uuuY7
	 81s3CAWyI4DwWKC3npVWoo+KgwQvw/sGscw9tR8i8v+We5Z3vWgYjJaRzd45KXI24D
	 Dvf7AXCH9Y8ZSObDY061Tbk7f+Y3xtY0AfQ385ilASDCaaWuyGHyr1qWOxbDVD5CQp
	 pc1A8Ut9y2SgUWJYsBdtl+Ew6pK2SWyJ4QxomjdPpDsv6kAXBt6h2xNh1ayyzbJIHv
	 0BbaaqFN9QuGlkmsh3tMHpI0Vpa8lCUf8LLQHd4fj4ij52IVzjfSx6hJGLSYJjq44J
	 SoMhGNHysk4qw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id EF057E0EC90; Sun, 13 Sep 2026 12:34:20 +0100 (BST)
Date: Sun, 13 Sep 2026 12:34:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH v2] spi: rockchip-sfc: skip DMA cleanup in PIO mode
Message-ID: <aqaKPEFt7fQe8QQp@sirena.org.uk>
References: <aqRM17TZ0-5pd6Y0@sirena.org.uk>
 <20260912190056.42192-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BYqHUzUgRwUKZNts"
Content-Disposition: inline
In-Reply-To: <20260912190056.42192-1-mhun512@gmail.com>
X-Cookie: Orders subject to approval.


--BYqHUzUgRwUKZNts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 12, 2026 at 03:00:56PM -0400, Myeonghun Pak wrote:
> With rockchip,sfc-no-dma, probe skips allocating and mapping the transfer
> buffer. However, controller registration failure and driver removal still
> call dma_unmap_single() for that nonexistent mapping.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--BYqHUzUgRwUKZNts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqmijUACgkQJNaLcl1U
h9CwIwf6A+Mv5erq9BOAGamYCRiq0f2YOtNdxCsprU4hUbNYwPzZgQCAmGAZhjr/
ORtTTFeMpKTizo2EekSAvp83S2VL9dxe1BhUaQoerKnG4MIqirlduo003OZ/gKtM
89/BUKPy6WqkW3A+nQ81bAglYptFyX8qo5FQzTb/cyyf+uzdxd5+xh5n98k0WS5s
SNR89mnwLzTyi0pmvALL7VmFl806G0KpMKPnowxT7PbjK54tboXHqO2BtCJEYk31
9Obbw0U7ogp3P+iV8nlQ30ZrZfb+MRCip9C4g27hJxcj69T3a4GbXySG9rJw7qid
YPCNkqKMNPhB6SoN6x0xYTwx4pg7cQ==
=X0/3
-----END PGP SIGNATURE-----

--BYqHUzUgRwUKZNts--
