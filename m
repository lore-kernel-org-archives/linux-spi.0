Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A992FF65F;
	Wed, 22 Apr 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874361; cv=none; b=g/Y6Nh4KYE0Gy79ZsRjniyIf0+YcQ+13pk8OKq25yNF/g2g+DUt5sUtVIR3P4TD/YI5mlbID+rFbfP5BJPBbVsHE227w0epdLu0Glk5gGxP1MuOSqfmk+vu7VPwob9glgt6sgCHdGum3Kyt3BQLiZm6Tset9/5AE9kUhe/i85Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874361; c=relaxed/simple;
	bh=I4v1mxCRxuY9peEu8fTfKrXZSA0Vc+jvyVH85GUdMa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orAd/1gbQWMHBWVuREwZjvbtQHbFpRKsBFSSGvGTS7HOTTz2xvWQPfEo0gP7PqC1C09NYVjmhqrTqShqBi3zjVK1rj3BoSnXvzY/ogA1h8lNxAmXfuenH0DXwklZYwFVjbiSxwSEkHzxE/zeuU+O/rx78J5LO5L1eyS6ZIFgBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWAvy/nn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWAvy/nn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04545C19425;
	Wed, 22 Apr 2026 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874360;
	bh=I4v1mxCRxuY9peEu8fTfKrXZSA0Vc+jvyVH85GUdMa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWAvy/nn5QZhZmCrSDiN1EIhuFbaDGGWLi0RwtvoxWRoFd/VfKKhZ0pp9rt/M0wAh
	 ErIoYqjegHXpgg0y+w5dMY7n2dED7Q9TLGX/3RfkFq6U/HIR0yl471rIwfk7ODO7Mo
	 jcKf8e7NQ0dhNeagP758lxGi7ADJxy5AVynoFhtvWvOakj07T6lifdbH9rW/LvRWlN
	 rinzWgRvdEw8uWsJvydj70GUSdw2Hj63LIZJQrzrvUg6Py86sxqueS0oTd/E9q0rLB
	 zMv9wSbNBz8ENafiCZqAI3TwPT+7lDzGhdW0CmZsk92x2XTOZuUvitJzilnWlMZi3m
	 ytReU96Ouh6zw==
Date: Wed, 22 Apr 2026 17:12:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] microchip core-qspi gpio-cs fixes + cleanup
Message-ID: <20260422-refocus-massive-c3eea64ee60c@spud>
References: <20260422-foe-strength-a5d8ad650ef4@spud>
 <8cb49ccb-5a12-4770-9c91-982d78b5f962@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b3mXLTcArltJS4g8"
Content-Disposition: inline
In-Reply-To: <8cb49ccb-5a12-4770-9c91-982d78b5f962@sirena.org.uk>


--b3mXLTcArltJS4g8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 04:25:43PM +0100, Mark Brown wrote:
> On Wed, Apr 22, 2026 at 04:15:41PM +0100, Conor Dooley wrote:
>=20
> > Got a couple of patches here, the first two deal with an issue that a
> > customer reported where using a mixed configuration of the built-in chip
> > select and a gpio lead to data corruption. Turned out, the built-in chip
> > select always gets activated at the moment even if a gpio-cs is being
> > used. With that fixed, I noticed that any read with multiple data lines
> > was not working properly, so patch two changes how the driver deals with
> > emulating mem-ops. The remaining patches are things I consider fixes but
> > not meaningful enough to get a Fixes tag. LMK if you want em split out
> > to be put on for-next rather than for-current.
>=20
> I don't know what for-current is but they certainly don't apply against
> for-7.1 which is the only active branch given that v7.0 released (and he
> same content as for-linus and for-next as a result).

Ah I forgot about that widespread devm_ removal series.

> It would be
> convenient to split the fixes and cleanups, unless there's actul
> dependencies.

Sure. I'll rebase, split and resend. There shouldn't be any meaningful
dependencies.

--b3mXLTcArltJS4g8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaejzdAAKCRB4tDGHoIJi
0iOnAP4ghNY31x2PcHvukxiOG0UNXW2dN8JYTVfDX4urqheYeQD7B+Cq9/MbM5ku
Ft5i3AHUtT1qIWSYcLWZZB/knaUvswA=
=z+I5
-----END PGP SIGNATURE-----

--b3mXLTcArltJS4g8--
