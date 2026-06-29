Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA773E4C9F
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750788; cv=none; b=CTmi+A9ODHlws9vJgHh0OfRDLIA20s1CwCFo0J4tWkdCOI5ZYH0Dr/AhlGg/Y3kNWdu4qzZt/1mZXbO4/0Rzd/J/KuZBT2+2RegGvtEFaFZI4BO7XdAGv8+fu+Yyg0t3kAMDfUde2QN0P6Y3Gxdhc8ZHRWEsMLFgG0E2yBlWWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750788; c=relaxed/simple;
	bh=8rP3x0htxY/A0MfSa61V9+zBK94rm82LmijUT5jUvSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS2D3g+xM8Cv5bDhiEbXeIatn0UNGY8ZVUm4mAAse9/b/4bmZmMWHKa+tyTuTLKQ08YpgO9vn8E1QX0MJb73CKFIsiSLSL19dE6fjnupgGCTwJo/oKMBsOLBxZ+CFWkLQa1UvregvPgfZdO4vFDMziDpN3+WlIEHtjFr0wjKOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=St7LK6yF; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="St7LK6yF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=8rP3
	x0htxY/A0MfSa61V9+zBK94rm82LmijUT5jUvSc=; b=St7LK6yFLuXpJvomQZLm
	38BoK400HaRsNhlZ97DMK/TtyiQu2L835cmDEt08Tsn/FSLa6z6CN4vvmGj8vznZ
	mc8rjGXE5yUikZd6N/JVSfoTEN0sosoKe63/IINxfZCPdoJ7a0TF6Cm8V7cmymmg
	0kDXIRC3a4d5IwI4k0giLoxOShv3jlrXLx8UvUYym8WA3siXiIf+0JSBJWQlBhDm
	rNJW7jcKnqGIDlzJ4RJAnTo872ykxh450YQ+1DQEizfLssPd7m1tQPJMp9aX3Q93
	3M9dUPV1GCXxPW1tSxEidIVhDKoqywAct+As9pDcygvzP3THCFNbCDOW93WQwC2i
	Kg==
Received: (qmail 454313 invoked from network); 29 Jun 2026 18:33:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jun 2026 18:33:04 +0200
X-UD-Smtp-Session: l3s3148p1@8IQyA2dVjpYujntC
Date: Mon, 29 Jun 2026 18:33:03 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: rzv2h-rspi: Fix DMA transfer error handling for
 signal interruption
Message-ID: <akKeP6CL7vHDImQY@shikoro>
References: <20260627-rspi-v1-1-170c93ee14da@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OxiOyS8ryrau5BCe"
Content-Disposition: inline
In-Reply-To: <20260627-rspi-v1-1-170c93ee14da@gmail.com>


--OxiOyS8ryrau5BCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 12:02:29AM +0800, Felix Gu wrote:
> wait_event_interruptible_timeout() can return a negative error code when
> interrupted by a signal. The original code treated all non-zero return
> values as success, which would incorrectly synchronize DMA channels and
> return 0 instead of propagating the interruption error.
>=20
> Fixes: fa08b566860b ("spi: rzv2h-rspi: add support for DMA mode")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--OxiOyS8ryrau5BCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpCnj8ACgkQFA3kzBSg
KbYaMw//fASLo7A5pAiwRLSXSDlxJJTDQf5Pi3WbH1TW72LzOS4fxyz62MAQr9jl
Ums21KAjzfAi3otkfOip0yb3hdsP4sIXp8ANR1DAro+eWC6c7LnHe2biETH9P/Df
d3PzPjILpSQ2LuwrEkHR6OqKjhxC7SV/Xagb9Jy/uwSmvVrpN5e8BHLI/GlVSkcL
RrLL/qTstErQcif7BCnkFpxArXrpU5CR4m1n93c0o4LsPtXk9dH+aQvuqQnFUeyk
Z4mhz0VaLTww26Ll39z5EtWo/wZKNNGU9+XnMLgJW0RyDDDRKGKyvwKc8O2FqZj2
nrKTqTFzvzDD9i9tp8/Hxgq/mT2YkFPwuDKfbwXfwO6mr7jBnIhMydxG+u1iCHZZ
p/HorwyXEC5v7hAJBQUV0h7ipji2AHGTg26R+N8ejcWPO/Xq1KV0HUxKzCyIiNY/
YfVKRaaiRwQhACy4wEQCNI2SYjMVB7cCWTIt6tzuDBdTtXpJAenJiJ+kaU6kb/E+
d6NEvdW/noX+LjtrnfmPjhZvcE5s6/2142T6FoTVyAkhHzbeF87bjVVNxI1AJEAX
dwb3zF4FDIaFJGfG84Z9XfrGhQes5g6eKZ63dCa/DzB+adLm3Hhqh+dIcOpmvl5t
rff5b1waIospX8zwvfX2EllQbKCuHsPKaH1bxNzVDvyBCr/27qE=
=4qyM
-----END PGP SIGNATURE-----

--OxiOyS8ryrau5BCe--
