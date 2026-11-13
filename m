Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572709;
	b=X35qq7bfRoBqYsky/TyT5HWku0e5z2QW2OUnPP5fM6EVAjMX/CERmqgxYaneYztkE/kb
	 kNjF7O2KscXMN/EF14PPCbK5CpQAuP7oiNCRf5zWeqFgBzLGqOIIKeLwm+I7urpJS3NIL
	 7srel2G6CRy1o9P/qYB2Y25Nh8pYjnnSgP5Z+NwB08unHohvro1K1PDpsk7x3cYyJpWdm
	 p7GRUe+43IZGpWX1pVgCpc4IJ2nK3GZwi5ACr+748oWWh19IdLnnBeapmzemgRs7M85T0
	 xstVUqZMZF808kAN86EFuEABwVtR5e5TsUabAJGBZW7Uf3BZWPFAhVSstWO1GlcECIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572709;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=EqCw5uzE8XALeVKaBC2jrOyc6WeslC8ZsxpNxhukdvo=;
	b=Nd6DSZ5XvjDpd/oP+rS2AdnjNFdNgkXQ7Jhf/P+ZVjjMW137pPfK/yJEHyms9EcWYVRW
	 Kfg6FrVDndVX/ZuEhE4mN+nNk7JhbDVKazRDT/y7WTCC6q6AU8GYABiDRglS/hX1F5I9k
	 aSTuFZDU/QcWdu2hVpGXbU4fpeAJOhM+OVIdzutgiR/yQxW2fD06N4xkRjqoyS+ZBF2fb
	 EVDY828nki1hJ8j2EEzJDWMPNAvdGiUCmn1Z4bPcNfOdckMHjHrWqXayCTP7EPC+4igWz
	 oRSca98jcN9p7O/x4Aet4Wd24oQIq+KLUm0g4SoyPI5fF5lFML3jgUkhzgJCpLLzXBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUt2Xd5q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC2606A88B;
	Fri, 13 Nov 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUt2Xd5q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B435A1F000C5;
	Fri, 13 Nov 2026 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794572709;
	bh=EqCw5uzE8XALeVKaBC2jrOyc6WeslC8ZsxpNxhukdvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VUt2Xd5qhFNMwF/hKucrVtY6uk/isDD24fFE/qGb5iUPllT7uwkhuBuR+bWsEbgRC
	 IlVS3a1+bpURbo/HxPxsomob4gh1JipApkFKhQj/zT2BP2+BnSp/7jh9/SJcrP3yXv
	 e8AhQAAEIYtTNK2XnlJn5nGg8A2Hz28Qzm0cHW0TUx3we95PwukjnJowZzLwRXCO1a
	 HAK4BziWDKOuLNyEACboITHwr8MPChLofb1uZc+E2f+UUgQkuaZAhOnJAvRMrI11ne
	 fuARqwqdvbYzET1VT0uUa5L6OrfSDH2Kx6AkhXzWdruki1RIctj/PBV5oXPRRj4yE9
	 Hg7YXK5+64LGQ==
Date: Fri, 13 Nov 2026 12:25:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Shuai Liu <847807867@qq.com>
Cc: linux-spi@vger.kernel.org, rust-for-linux@vger.kernel.org,
	ojeda@kernel.org, dakr@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] rust: spi: add SPI driver abstractions
Message-ID: <f8d00405-e8cf-4c77-a75c-9792ea81a546@sirena.org.uk>
References: <179451185979.339049.12323339081307899766.b4-review@b4>
 <tencent_097BA6F40A0B8FBC4C130C6EBF58F8048006@qq.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ggMePJOQVkw5nMmK"
Content-Disposition: inline
In-Reply-To: <tencent_097BA6F40A0B8FBC4C130C6EBF58F8048006@qq.com>
X-Cookie: Flee at once, all is discovered.


--ggMePJOQVkw5nMmK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2026 at 10:05:28AM +0800, Shuai Liu wrote:
> Rework the device I/O to map onto the lower-level C APIs, as suggested
> by Mark Brown [1]: instead of leveraging the C convenience wrappers
> (spi_write(), spi_read() and spi_write_then_read()), all device I/O is
> now built on a single `SpiDevice::transfer()` primitive that maps onto
> spi_sync(). The convenience methods `write()`, `read()` and
> `write_then_read()` remain as thin wrappers on top of `transfer()`.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--ggMePJOQVkw5nMmK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr3AaAACgkQJNaLcl1U
h9B8ZAgAgY6BVG6bG72JQRdVKvYmwEGGsir0CiGx82+qJ6rqrYYNL3cyBAIugk/i
mHe8gV3P0SBW/dUC/iVvLVadtUQoTPemFeecZPX5wm88L+JWTIs5Mm0C3CoMZ4qt
0fwPVawILQIRkJc6aSG+okQKY/VxRQOVT7k1Jbsg/Ojo3Tvph33SQvVwLmP54xft
vSOP+LKoYdPk/uvFPz1bwdD9WvBSpUxPYket26MygkZVSI40jo8t9NnKT6TIkUzq
5D65nbovb4cwX6NRCMcZOm+T7mPYdNwVkALf9/lgFiianbc7xD5tc/SPBItSjO7w
VeVGwKMzvOI70QmQpasaRmXERDQmEQ==
=r8pB
-----END PGP SIGNATURE-----

--ggMePJOQVkw5nMmK--
