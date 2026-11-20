Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174538;
	b=P2LxWLIlwzrUH+GjU2s6ndbboFTZPu0UTkQmp0DIc3Zoz57YHaVEfGIHIQS5m8dxzMy2
	 AxtDMqKWum314RDaVOR33EuRe0nE8uBwg0f0VpynF+iL2G94VlAAPcmZ9VIhuoOTY2hH4
	 ynn0t+d67PcCsDNcOdqF3TNGoint3X8Gcm+h+iqzekiPv3y5v+g4zwoh0SPZFM2GR8Ov5
	 nIMYhriekRUmTQJFMjFd1uhlVN/CFL+IWs46fh1UcOooGf58MZ5Ix5fHyh8qi5Zf1gwz5
	 65xweVIdgBy71oYnnyiBgMs4V92IvZiiGaHk3yNxWhzCuUgc/mIbnIke7DHJ/3jJCcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174538;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=OJ8sB8CqGQyDeYUESkBC1QwhQT3EKnox3F2/tdXe43s=;
	b=xIC7GUD0399+2Kavy8yRcQ1uFtm93Uem16hctEa7XrMRfe+84W6Q70CJjzaHz7wKQia2
	 l0UCkK5kHTp6mJbfzMc9NXzGKIdJjkhL7mdv/Vm1ixT2VUSzJy7hj72qE5dFKqZRNBng3
	 UCyGsaB2aur/4eKpy2bt7iQIMGICEKueska/qCjD59i8Gvwo7kWc7xWIvks5/f+BE7jA9
	 31ion1ISV1l8SIMDvB6DLlinw3HERTNZ9BbtnKrFmkSTCFXiqdTmUu+RzVfZvI75yNtg4
	 dKNG5CmwdSniCRtQ4zG7+Q0tBSn3LujdaAYu30gGEKn1Uo9+BDeCEZfHgRcESp/mkBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auFkIbCz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC44606A320
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auFkIbCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D2E1F000C0;
	Fri, 20 Nov 2026 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174538;
	bh=OJ8sB8CqGQyDeYUESkBC1QwhQT3EKnox3F2/tdXe43s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=auFkIbCzl/IJOsljENZs65myXMtW15xkh6T1sDxQateK1BrnMQHm6PJwigMv1exaW
	 g5qgRdtbTmwee4wVJ/DtCjOZdkxIT+gZCRYlOTt+Wk1pRjYGmxgP2Li9NRWEuPE/3d
	 coI8ffs7BewoK2zecQap/DbiWBjQjVqirnETms5+ETLrZr/lW3H+vNLKQZ87eckp5t
	 w+xyVPeJdFSTJmo+apZBLZHW/UeyBlrfD3Q6FFrQigjQBX3OI8uoueJNXrOR6eNzon
	 Qc4stNNh4iJdv+oYG9sNwlvINvneIhsxZse+C6N7xHoDKjLfU+O/4IFnh5zskefNiW
	 02yFsD86ltZ+w==
Date: Fri, 20 Nov 2026 11:35:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 06/10] spi: spidev: Allow untainted use of
 driver_override
Message-ID: <25b6ef12-fede-4cc7-81db-dcb5346fa0cc@sirena.org.uk>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <3821faaf865f1f96b45f6156b577cda57eabc4eb.1795171088.git.u.kleine-koenig@baylibre.com>
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
	protocol="application/pgp-signature"; boundary="humat08KGRpYilUJ"
Content-Disposition: inline
In-Reply-To: <3821faaf865f1f96b45f6156b577cda57eabc4eb.1795171088.git.u.kleine-koenig@baylibre.com>
X-Cookie: Error in operator: add beer


--humat08KGRpYilUJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 12:11:07PM +0100, Uwe Kleine-K=F6nig wrote:
> The spidev driver is designed to be bound to devices using the
> driver_override mechanism. Set .support_driver_override =3D true to
> continue having this mechanism work for it without tainting the kernel.

Acked-by: Mark Brown <broonie@kernel.org>

--humat08KGRpYilUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsAMIUACgkQJNaLcl1U
h9AbWwf8DEDkRxkPDolA8MPf7XLRKL2VZx65Q4PE3cyiACn7Vb0sHUtAZSMDyn/D
kKBiLgxji4ZLoRotWUZxh5kSV4XUb7a22NxaY4kYVVEy+BLXBywkwwC1FGwS7MnD
uWu/WDQrmZQsr4Y44/iImTXxZHK1mkJx4GD+l6/eZ6NMjtDXuNsujsWYqcvzyWtB
4Wu72pP+ZT5/9+wCyI77XuTFXqfCLMYFIbmTUJ6JFofWQZDekslYXxpssE/1dlvt
wenRCLnfjmRDwd47IGn/3/8AaT3YcZNlZiGXdZDjOfs76KGum11SJmGb+Zog9SLs
nvw+lvjdiyEhKF9uL3JxrpONlqvXrA==
=WMhM
-----END PGP SIGNATURE-----

--humat08KGRpYilUJ--
