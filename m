Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AC3BC660;
	Mon, 23 Mar 2026 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285373; cv=none; b=Imb3yIDYBYzSlULIn0gqo94dxZEnKLR+dIlWQPVNv111DdxM67I833ZvxUlfeMGGOaeoo3jqhE9IyMCJ8gBuGpV09+Z8zA25rp9UKw8Y45SPWeo/2qDomECQgD0XAVaxqcypqdaMxQS0BUq2o757FZSVy2aleEUYpxM1WlQQZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285373; c=relaxed/simple;
	bh=hseuDWWLAkVC0L/09iibqIXq0l2/wdfWxJd+Wv65xrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4c4EntMFS7A+klqEX8ipIBRvHqEwnUO0fVkZLwv344X2ZBBH+PpSRZ/M5Rjd7S3DLZ8dFwKGyPtcZTb37nU1rQJHukcgjjRyBTkJBzARiz+Y4OlEPDQ4WUvHHKYCI86/syVcECqIDajripJ1cxHgjMt02mDeBsCVOp4+7LPQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6y8C3sD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6y8C3sD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8BAC2BC9E;
	Mon, 23 Mar 2026 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774285373;
	bh=hseuDWWLAkVC0L/09iibqIXq0l2/wdfWxJd+Wv65xrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6y8C3sDEZcQCfdDqmfELlFje5DnyEY/PjiCgorth5jQoCMp4jeKkjF+aKB46Epwa
	 hI5NKFM767i8cpzhDJLsY0CKuhecfIkx8TJ4hf2v5/sL/oFRvwW/5FyhUZRXVEFV9L
	 iJPh1vLb7rV2pClKBFJiLIJV4v/we5V/QiZ8D2G86P6UqoRVFFc0yp0hB5MsMnjB9c
	 V9H0fChEaoFC0BFfyl8QPgTSu1HrnrQLIxtQj9o/N+JbyJWKEV0h3wSZKLnADOMZcB
	 77SQN6t+2VAKYpDDNR5JRRYFDwBd8ZHzQLFKfjS61JB+WjyGxlluipKeOAmV4jezL5
	 wXKnwP/1yp5ig==
Date: Mon, 23 Mar 2026 17:02:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: rockchip: fix controller deregistration
Message-ID: <696a4dc3-9095-48d5-bfac-51de204af89e@sirena.org.uk>
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-5-johan@kernel.org>
 <2ef1dcd6-68f0-4111-b8ac-fdaf4aea36d9@sirena.org.uk>
 <acFviPkEwqJb4y36@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qMPGV0bCD29Sgywf"
Content-Disposition: inline
In-Reply-To: <acFviPkEwqJb4y36@hovoldconsulting.com>
X-Cookie: Avoid gunfire in the bathroom tonight.


--qMPGV0bCD29Sgywf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2026 at 05:51:20PM +0100, Johan Hovold wrote:
> On Mon, Mar 23, 2026 at 04:35:39PM +0000, Mark Brown wrote:

> > Fixes should go before any non-fix patches in the series to avoid
> > spurious dependencies and make it easier to manage applying the series.

> Sure, but here there are no inter-driver dependencies (that is, the sets
> of patches for each driver respectively are independent).

If you're treating the patches as independent then send a series per
driver.

> And I didn't expect this one to go into 7.0-rc (no stable tag).

Why wouldn't we apply bug fixes as bug fixes?

> Do you want me to resend a reordered series?

Please.

--qMPGV0bCD29Sgywf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBcjgACgkQJNaLcl1U
h9CajQf/XJHsZeCcgVX4+QVYDuM8S9X35dpa/4WdfLLRezna3QDCIeqteOyVkCyU
RhARYqf49wytT9n3qSyeDlaoLd4pgcplIuH4+kuKrM7XGeGdEGiu0AIxIiGqIhYL
ZUizuJa17ii2vTs/Rbnuf3AcDai6MDOzruaYEFvnO1GupI12Nt4Q1WdNMDvEzDEy
W+RSYHWdDB7zbGvEFO2yob18yzMqL5xmOWJfEegUPpb2kPOfB5fU2aBr/iQJqYv4
X8SSmnmlkvJYX0zkonJ3gT0y1TmTovQ0agcB5xKBhUAmje09TXCJ56hjDLS5bYKZ
dBTTwNT2RJDWIPw3mJftkRJZHVR5dA==
=8UwR
-----END PGP SIGNATURE-----

--qMPGV0bCD29Sgywf--
