Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D1342CB1;
	Mon,  2 Mar 2026 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490786; cv=none; b=HUUd7vYFGhI6vAIyqJQOU/YlijixnAjho2F937LGmtY0D2XEWC94SKrTwCklzkwx39calbbyF9rvdEerhEVyWpFXHJQ5v31FISCYH2o+bq5Zwo8e4ATsPBZbpsIWpah5mJfu8BZnvxrGoPGfBFz+pt9d7Ye9+Xx/vCWSSmq6Raw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490786; c=relaxed/simple;
	bh=swa+ka/TD7SNyo2fpp7AqcNfu5+Ha1vhXniwl676quk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzTsNi4urJaMqQ5AYh+Hfs+b76UeFgYqRKltyz9IT0O3tg1ygT/Y0pu/YZlqTJV3pWMh+oT4jeGB7TgQVqBz1Qm0uuQ2rpBXUeSKx4FDulLyyCdHr3dXngqV/exuhdQH/ZNTFcMKMlSbe4BZD0qNnsqSxdJEHq/7QHTg+/4QUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XswFFd52; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XswFFd52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A0BC19423;
	Mon,  2 Mar 2026 22:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772490785;
	bh=swa+ka/TD7SNyo2fpp7AqcNfu5+Ha1vhXniwl676quk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XswFFd52PV0SV80Lhivmnn5v4rpriiNSLcHdmLHLhq5Acm1iipl0zDayWmiA9UU1W
	 XDkZQc31a4LbG5PXm3Ij34AJvBWREenQTXnwpg9jrBTzqzQ/q4CKM3mqxyY9SAlxyB
	 j5aoPswdlTUQqeyoFKPwqvhgcdfSBAJb1jdD8xk8JVp/Z7qHdHAGwA63gmYtzqCg9N
	 QYUVXuoaicyTT/dqnQGMxW80YunbGSwhFw3uATUQfmvkSh836gcHPdwSEn81OBFK/A
	 SO99bE5jn4bpdjrtOe9ygm5Z74Qp9CWUASpo7xlfJiBHIYQLJf50oipZUwnal+B29M
	 5vXQincIniT1g==
Date: Mon, 2 Mar 2026 22:33:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Vladimir Yakovlev <vovchkir@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] spi: spi-dw-dma: fix print error log when wait
 finish transaction
Message-ID: <692f55cc-d93f-4fed-b638-b9cce4d779a0@sirena.org.uk>
References: <20260302222017.992228-1-vovchkir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d9zQMK3IfY/Sola8"
Content-Disposition: inline
In-Reply-To: <20260302222017.992228-1-vovchkir@gmail.com>
X-Cookie: You love peace.


--d9zQMK3IfY/Sola8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 01:20:16AM +0300, Vladimir Yakovlev wrote:
> Hello!
>=20
> This patch fixes a system crash if there is no current message
> for a transaction.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--d9zQMK3IfY/Sola8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmmEB0ACgkQJNaLcl1U
h9BWqQf+JEVH4bcKul4rm/LG+kX8xyB7f7JVrHOoRY1R9/QQwSiAXmXBuVeWO2Gm
rEvNwn8tUA5u2vwsluQ0MwPs3lDhpX/anT2oxdvNmTbW8r3sq+a6n7oAiRR7mL+K
aS5K2IJhlcZwLAqko3sbAwY7GtuBl8nEx+U7sl8w4g7NgDuyRChCP1uQ+FK52T3+
DeyNvvPkXtEbPWKFYoBechvX15ECR15Ew07AfKO75iDydaxY1zuBqCZLSKo0xUA7
xzcVcMIJUEqFhXEe1Qmr5l3Etvzb8/Zv9OOgxtiflKHa+Ad30Xk5bR9c87IBtAI2
EgodhlRvOEqljlFOr5lZN++GxSoE5g==
=QBhu
-----END PGP SIGNATURE-----

--d9zQMK3IfY/Sola8--
