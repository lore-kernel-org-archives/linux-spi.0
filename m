Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CB30ACEE;
	Thu, 23 Apr 2026 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970210; cv=none; b=jzplXV8vJlIvrd44Qky5oWgExIE4PTMfLdTDayTGRO8uN1y6qZTQLV756tDxbzkGfN+lb2N3kMJmK4yf0fFS3Khtsl16T2F2QFa0dhlBRcgIAOnANg3VIAFPeEXxYB1Xy4lPkbG+1rBXQC4SbSNDFu0xby+kHzx9w+GomuqQlXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970210; c=relaxed/simple;
	bh=7vB5IPxTRHP39nn5nizcVUL7wYBYeAXeH+nIwf49x40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2YoXx1eOjxIxzWq+X+sLWGzGnig5KVOkjgwtiGT+/L1KYYGj4eSr9L7BclwKJAx6gOOKdaA8IVp72mv8oCXamv3pmk55/51VCOnEWOFX9jwi1B5ZHwdXKHsUSYMwd74UKeDJ9zdm/2QTVKvuFXzr8fJEaAC7znyjJTF0DL0yxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFqSgZln; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFqSgZln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E29C2BCAF;
	Thu, 23 Apr 2026 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970209;
	bh=7vB5IPxTRHP39nn5nizcVUL7wYBYeAXeH+nIwf49x40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFqSgZlnTfVBRjGJbfom7Q+r2jaidYL9x0RD7JgrV4TpzLgnqQmWRYz0gFbP8/YNa
	 mU9Aut1CrtTPrlpcaOz6mlrYh3V2VtQ9Cup0LxatNyPZEUYGhgoCIgEHGXVjMHq6vl
	 ssBKDvVQe2RbIR1+NPnfrjfXA/DIxxiFKAc27AgqovsoPUU5sO7He82/LvNfq1W3V7
	 Dbmn7lnTxIHdWvGLFADrP+iD90ZWsBavHQsic6IMwBKR2QERkv58kVZL1KtXzkgNPr
	 Y9hp/fmxJd/XxtcBAZBRtfh3A3U8zKlx5+fGOfkyme135zXHHUf4yulDBTG3e6xEPm
	 /PGLxoH+RWRdg==
Date: Thu, 23 Apr 2026 19:50:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Kevin Mehall <km@kevinmehall.net>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Mirko Vogt <mirko-dev|linux@nanl.de>,
	Ralf Schlatterbeck <rsc@runtux.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: sun6i: Honor CS setup delay on the first
 transfer with native CS
Message-ID: <5ccd1ed2-b4b3-4f94-8c32-89bb27d4066f@sirena.org.uk>
References: <20260423174001.2797797-1-km@kevinmehall.net>
 <20260423174001.2797797-2-km@kevinmehall.net>
 <53c2d366-2d76-4a6d-a72b-99544026ee27@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IoiCEiiWH5qA67xB"
Content-Disposition: inline
In-Reply-To: <53c2d366-2d76-4a6d-a72b-99544026ee27@app.fastmail.com>
X-Cookie: I'm hungry, time to eat lunch.


--IoiCEiiWH5qA67xB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2026 at 12:40:34PM -0600, Kevin Mehall wrote:
> I realized this is incorrect. With a GPIO chip select, sun6i_spi_set_cs() is not called,
> thus CS_MANUAL would not be set, and the hardware would then automatically
> assert native CS 0 during the transfer. My testing was with native CS 1 and a second GPIO chip select,
> so I didn't see this because native CS 0 is not used on the Orange Pi Zero 3.

> Therefore, I think the best place to set CS_MANUAL is in sun6i_spi_prepare_message
> as I had in my original patch [1], unless you think it should be duplicated in both places
> or have a better suggestion of where to set it. sun6i_spi_prepare_message() is still called
> before set_cs(), so it still fixes the skipped delay.

That sounds about right, the other option would be
SPI_CONTROLLER_GPIO_SS but I don't think this controller needs it.

--IoiCEiiWH5qA67xB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnqadwACgkQJNaLcl1U
h9C5sggAgETyhpLUFJdWeth+udrgH/0YKeI5n87h7uw96RcN0MdcVQrXGRwlQkVC
bThbi9LY3VJ+YrGlL6zWSFmuybyaX7AlukJjJo5GDYYSuFHy2VInX0OT+4HVpTUK
oJxbCCxXZ1Va6mtIThVE8t3vFrOIL155dYBmsPZgfS6/nIDxd39HOuBB3tw1j7Iw
I2QGXa2fVP+ok8j+1s8Es+QFnqbJ/QBzMJnlNbOLmaKU0/LM7U94amjkoxH0bQq3
KhAgTQMMultNs+8dnShM/So2hBRJj+pCNZA42XsKCnZEFFLVZv5ISXq8pfO4Jibo
huXj5pI4nhgNwZDXgrYYvnRlUhZ+rw==
=WYR6
-----END PGP SIGNATURE-----

--IoiCEiiWH5qA67xB--
