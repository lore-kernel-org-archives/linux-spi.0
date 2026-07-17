Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9FD32B130;
	Fri, 17 Jul 2026 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324644; cv=none; b=o62H2EAyDAQEfE+oh+iIAVw5jV+086grHMxBknErRP1myXOLHEYPH7DsCnbEKNm/OV38cLzilgyQ5vE/OJz4DPkT/CFVn/JvN6jThyKuDzXCtNwr8AdGXKagZsktSiOXGnUCprKWaN6Jf3NnSkrq16Bh2EsZ9+i0Q1AhuZj5n8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324644; c=relaxed/simple;
	bh=7xk072eb1ILmdzbQgR5G2CqosbAC0wnv2s4o4F3q+1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8WjdqCa3pG5Mn6roubn0Co+VSjP9v6FYmGtGq10vUhhapc8C0DM3SdzIeqhtU9ldinZIeexRjvx2f9Hu3bY2xw9fJ/7J9Fm9GUttgpzaq+Bgx2fC2BIJ06+YnWV/p2Ia2Dv1qk9MqeqNgoakIjd9imZT/A8L+1x4NSVkXiYQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25931F000E9;
	Fri, 17 Jul 2026 21:44:01 +0000 (UTC)
Date: Fri, 17 Jul 2026 22:43:59 +0100
From: Mark Brown <broonie@debian.org>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume
 state fixes
Message-ID: <51a76c7a-1cec-4d2a-9a78-1ef0da890636@sirena.org.uk>
References: <20260712162420.7453-1-fourdollars@debian.org>
 <20260717154646.5854-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Su2EJxll9C79jsr7"
Content-Disposition: inline
In-Reply-To: <20260717154646.5854-1-fourdollars@debian.org>
X-Cookie: Enjoy yourself while you're still old.


--Su2EJxll9C79jsr7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 11:46:44PM +0800, Shih-Yuan Lee wrote:
> Hi Mark,
>=20
> This patch series resolves two issues in the spi-pxa2xx host controller d=
river
> related to Intel LPSS SPI controllers.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--Su2EJxll9C79jsr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaoh4ACgkQJNaLcl1U
h9BVpQf/fTXENe37w1xzKNYSkRsydhCi+d3kAx/sPbyJ+2JKFxaLEJIpKNuoiYmQ
5B0wZg7Pncz38YKcLKvY+SJ0Dnm5emKhyEAHW/AhVsvd/aMdf+ZAMBJpOSyXWfUl
plDSb0gMloJr7NYEwH1In3c99xP9zRUEP7XLOQ87nUKfzNf3gwerAqVeOiQoXt+w
6yWjxrsEUX1IfslN5IWMgfg4IAXKgQXCWU8DpUPX71eo+637TsoEN55D9yWdpyVQ
JiVWvwdeV+DLDayuf9rXRmkm0DTrPVZdOf81WS2ZMRVSp2Y0KD5p6/RiZB/89Fzw
GPGxhdwJTMwGTXgl95KFmpf9nm9Ftg==
=+GD2
-----END PGP SIGNATURE-----

--Su2EJxll9C79jsr7--
