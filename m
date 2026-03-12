Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8AB396D16;
	Thu, 12 Mar 2026 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314537; cv=none; b=OYNTXSWyTvbKhVFT2wHpk7b7T3OMpJ8ek33zuaeVbGDrHYcae5NRSMnsVcQe71qC8Cd/KxkBGouoJ1wOOkiMD2Afs1iU3q9Rixq+yDVrjadAdP9w+yxnquuGlhTch/o1id0V8KFl68mObdn1YJBWLrRIqJZDZU5dN/fWzp4YH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314537; c=relaxed/simple;
	bh=n1nyacseKQZGGEJ1k1fJu0PAgJLlkvnCzlmgpYMhDy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFnNuiwCGXqGIYuQhpXJ5yNWsXhKiLjtIRn52N8ApNIdxsUjbqpUmKiMxKTKEB3xLiT0VJnsREdrHpIEbjBqHB0N8C29yW1cCt7ZqoscAmOq0uBYHwm5zup2bodMNPEDfxwlm6g5eNg7IwnNrgcsbSNST8i9FQ7+tIG0kSbuYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeovAqBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeovAqBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF58EC4CEF7;
	Thu, 12 Mar 2026 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314537;
	bh=n1nyacseKQZGGEJ1k1fJu0PAgJLlkvnCzlmgpYMhDy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oeovAqBNHFs5Q5oqGD2LLaEBwcoSqPSd7A2lcw5FNqv7g4BS4ncxXEqjwnJgcaUp5
	 P1ExOQ7Tj2rIQiWg6zIwouSXgQZb0z+8hH2Cw7N3aIKLknOYtv7O7grZlrYjlIOsb2
	 xAn2dom6zU8jUzao3QXIhs13tpIFJyQOAS6fxaLFtHQ5vLjNLP2+P4xkaOTgxJyOCn
	 LW7JBFr0s2hmsnsQYKm8v3e4SBLqSCgG8S+boUTrQZaPf60pqXQe4RQ6AURT8665g8
	 tuUx3ZrwIjaD9Mu+y3SQApdDxgo+RyRlt6Z2JrIx2RUrzcwkAJ5+WToJI8jmYXk1I8
	 aoKZdF4JRpJ/A==
Date: Thu, 12 Mar 2026 11:22:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: cl634@andestech.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: atcspi200: fix mutex initialization order
Message-ID: <8313fa0b-9c15-41da-aff6-4228a2b1f03e@sirena.org.uk>
References: <cover.1773193726.git.xiaopei01@kylinos.cn>
 <f47d4c292bdff7a0bad8d316c28c83c0fda36a0c.1773193726.git.xiaopei01@kylinos.cn>
 <dd58aff2-2408-4aac-b39a-bca8fe4cd64e@sirena.org.uk>
 <c95608b9-4912-4b42-a188-1265d603ddb0@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z0EM2gQe7uRzGP59"
Content-Disposition: inline
In-Reply-To: <c95608b9-4912-4b42-a188-1265d603ddb0@kylinos.cn>
X-Cookie: I feel better about world problems now!


--Z0EM2gQe7uRzGP59
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 10:25:11AM +0800, Pei Xiao wrote:
> =E5=9C=A8 2026/3/11 20:29, Mark Brown =E5=86=99=E9=81=93:
> > On Wed, Mar 11, 2026 at 09:55:14AM +0800, Pei Xiao wrote:

> >> +	ret =3D devm_mutex_init(spi->dev, &spi->mutex_lock);
> >> +	if (ret)
> >> +		goto free_controller;
> >> +

> > This means we're now using devm to free the mutex that is in spi, but
> > when we pass spi into devm_spi_register_controller() we'll cause spi to
> > be freed before we free the mutex.  This pattern gets a bit clunky with
> > devm...

> Thanks for review! I will use=C2=A0mutex_init() for V3 version.

That's still going to have trouble because if you do the free in the
removal function the lock will go away before the controller which is
it's own issue (this is what I mean about clunky).  It's especially
annoying as it's only an issue for debugging builds.  I can't actually
see a good way of dealing with this, perhaps just a plain mutex_init()
without a free is the least bad option.

--Z0EM2gQe7uRzGP59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmyoeQACgkQJNaLcl1U
h9CGEwf/YRDAWYbPb4HqIiUZ+cruSBGASNC2FUFyH/pLBlWw4Vvt7i0W4dmbwUUR
i307+hCrWclU8cG6mxFI37yvmWfJAucNdG9z09E+QIMhGBNWkCbqvVc1a4SvSouk
rGeed4fhVkuk20KnbjttZGZIdIg60wP9TlogLspDGembG82yVSyyDEbJbBuRl5Yh
QGVP+ovLbImYhWYPqS4qCXjBb2DQY/ib22qpuhMfKEhT7XhaTnBD7TaAn6lLuAP0
l3pNwPB/3w782eA4Hc/jLKMjNfslfh5ffBxEVZdUkFFmRn3k7IdSYOe8P6S6Jaxy
C/foSAVChqkIQn+h1iB/a4kapzTyNw==
=PdNn
-----END PGP SIGNATURE-----

--Z0EM2gQe7uRzGP59--
