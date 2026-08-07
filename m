Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C7A34389F;
	Fri,  7 Aug 2026 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123970; cv=none; b=HjDI5DAk/+Wn1tp3Lm4xqIfck30vluukrDR1f7uE4iXm8CSk75w/LrfVlbpAQk8V5Nub3XTVeDVxHS39TPaGCSRYTIb0K4utAjzvJLV59qTDXYeifdzBRhk8Rb+f/UvFpivxWxDa9iZ17myifxK0yrx8rQWIxbJkAIg5ei4YKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123970; c=relaxed/simple;
	bh=KitkeLExiYfT4Wyjr1X6KmtQkOFob9mUkzahmCKDTtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m94JQiQYmSqjR4bEGryA8G6Gw5soaUWD5/WA8/p5DHct4F/AlBkV6ZwzjllDM+oXJNj7ZILjt3VLZpahW9zIYrn6VnMQfKdh7GEo8wRyvYpQZ8iJmI6/FRg6wN0jTcVHgeGLoarD3n756yc6xlyHOpEaSPgMMXXmE1iiyN5rNR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaSkl0Fa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaSkl0Fa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0824C1F000E9;
	Fri,  7 Aug 2026 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786123967;
	bh=Nb79dty7Q1Ygm6NodF75IXTKvgQrkKgAEnfqavxtKCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aaSkl0FascTidt1TpbvhmEIqN3IHjeuQXm1px2lMFmf2AxwsKX6VB1jWN5sdD9fkR
	 0MrM0be1LO8h4ygSMTMSsGIcYLkKaVY3nRQfwuGRGyhEoncjypkq4YbMTwfZ0dYFRT
	 j2xLo1mRh8BS7wbbp9bvr/6Fl27BGW4Lu/KaihVxOMXJ+lCj79qVhncxJiu3aDegko
	 hZJyB45Iq76vYl+mh+O/tflMCUCXRfklyN/BE+weJ6T+i2buCoTu+tN516JsngP8oe
	 8LR+IPTg5oLpk6PKR2e3zYsfNkXuldIc4kH+10yHCrOvyoXr2Kxl0fdM2CmlnEAAJT
	 +1ed37IVDQqFQ==
Date: Fri, 7 Aug 2026 18:32:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] spi: dw: use threaded interrupt and optimize the
 threaded ISR
Message-ID: <ec1559ba-92d8-44d7-93da-e217b02f9399@sirena.org.uk>
References: <20260803140649.12718-1-jszhang@kernel.org>
 <20260803140649.12718-4-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nH2v8V4Ij7uN36tl"
Content-Disposition: inline
In-Reply-To: <20260803140649.12718-4-jszhang@kernel.org>
X-Cookie: 1 + 1 = 3, for large values of 1.


--nH2v8V4Ij7uN36tl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026 at 10:06:49PM +0800, Jisheng Zhang wrote:

> To avoid blocking for an excessive amount of time, eventually impacting
> on system responsiveness, hard interrupt handlers should finish
> executing in as little time as possible.
>=20
> Use threaded interrupt and move the SPI transfer handling to an
> interrupt thread.

It might be safer to make this happen only in host mode, not in target
mode - while the performance improvement will apply for both target mode
has no control over the clocking of data by the host so is much more
vulnerable to dropping data in a threaded interrupt if the system is
loaded.  In host mode this isn't an issue since we'll simply stop
clocking data while waiting for the scheduler to get round to the
interrupt thread.

--nH2v8V4Ij7uN36tl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp2FrsACgkQJNaLcl1U
h9CnBwf8CDXYrliuhcMpvFjtY9AevzWw0jNeKlhUMRAsVgTg93To7KGE7gAvoodB
jG+0WnE13uM7jboJbeUOL+5IUnrKboIAAYDWZAQ1bURL2sfkRI2mXcaST6fHlI9h
gUAY60PKB0Jkeyg5GjdswpwbaqiTcE8GJf1uLd2+Hsobvd4F6wN+yrgKgTDgorMT
XpX8vFTKxK64g/8PDsAcvF7bkXjfLMM1+soyMUUaSciYcgVUAgAThQwSUAzvDXbg
T6nEEi5JMbFy8AVdphopYiA/mVk7G90PUl/VUCszre6BPUZa1xxUwGvc+g5ZfHMM
3tuiGIIL/pikKi0Xn10xdwR5leXTyQ==
=Bq7k
-----END PGP SIGNATURE-----

--nH2v8V4Ij7uN36tl--
