Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED735248883;
	Mon, 23 Mar 2026 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280478; cv=none; b=fOnGl/5IFoaP8v8cxH45DJ5MPl2otXVPIWD3DBRJJhEe04HzggyY8JX0Qr+xV5xRS1PATIpAPXsxaw5bDYPyZMUGRVD0b2wuNOySPW6oIi/6kJskr6wTTi7AkHf9/SABiZnwcIQtLvR0gKHAiZfrzlFbOIBRTNXV6x17GJQRt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280478; c=relaxed/simple;
	bh=vm30eMFGxskKy/ijeC5ehl1Qj0N8mnf2losx1vmPRbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/QGoH0E6ApPYyWiZSSyTwueak3uPi4Mflt9m1aIO7+QRX/nOGQHmmzsTBJAw7jVajX4xYoWcSW6vyG0OWyo2P1ZZjqMyRuanbkbY3N2Bb8accD4wxfvXEu+6sxHsJq7+0BF3pFkf4va1VACBsV6kxpuVeQbHXdV8P1Q1LDnGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw/GVMy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw/GVMy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F395C2BC9E;
	Mon, 23 Mar 2026 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774280477;
	bh=vm30eMFGxskKy/ijeC5ehl1Qj0N8mnf2losx1vmPRbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qw/GVMy1FnLhesd/tj4uX6d7rW7Vk+K5fvs+ktD668psjASQLPYD4O3ds5GCAYoeG
	 Msjlx5BWuxyhsaaTC1vRJx3MPtml5q40xMARb0Y0OCSn3P/+t2ApnVpcNGEpbzTOAP
	 /ivV+t+1c9ijtDfU+6wrTc5rtS/b2hcCnVz7PKKwrrQr3S6VGv6BwDRnL+1OHtbKyR
	 5Bdu8WntZnCQeg+uWiYK+esYy2prnC5OXzueaTdhmpDEkyEcaY5C9G90sHdd0VhHuz
	 /Q8hUghDZDU/PJ9Ss2HaZDFkRrItMqpsPZZS0vB4FP+ZvGITrSyZgh4eUvvtT17nPv
	 HcMo9dP2k9UPw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4hP1-00000003bsf-0sp5;
	Mon, 23 Mar 2026 16:41:15 +0100
Date: Mon, 23 Mar 2026 16:41:15 +0100
From: Johan Hovold <johan@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
Message-ID: <acFfGzBkNPaIj3jv@hovoldconsulting.com>
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-2-johan@kernel.org>
 <20260323-demonic-worthy-guillemot-c2abb8-mkl@pengutronix.de>
 <acEh6KiKMfBehoZO@hovoldconsulting.com>
 <20260323-dangerous-brown-polecat-a4988f-mkl@pengutronix.de>
 <acFHVTsDIbQm6GG6@hovoldconsulting.com>
 <20260323-kickass-original-wapiti-a01804-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CNjBYXrzSikli04s"
Content-Disposition: inline
In-Reply-To: <20260323-kickass-original-wapiti-a01804-mkl@pengutronix.de>


--CNjBYXrzSikli04s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 03:47:45PM +0100, Marc Kleine-Budde wrote:
> On 23.03.2026 14:59:49, Johan Hovold wrote:

> > Indeed, it's a known issue with the SPI API. See for example:
> >
> > 	68b892f1fdc4 ("spi: document odd controller reference handling")
> > 	5e844cc37a5c ("spi: Introduce device-managed SPI controller allocation=
")

> > 	f0c35a024cce ("spi: fix misleading controller deregistration kernel-do=
c")

This was supposed to say

	3f174274d224 ("spi: fix misleading controller deregistration kernel-doc")

> > > Would using devm_spi_alloc_host() be an option here?
> >
> > It can also be used, but that's more intrusive so I did that as a
> > follow-on cleanup to the fix (see patch 2/5).
>=20
> Ah, nice! At the time I replied to the patch, the whole series was not
> available on lore, yet.

Sorry, I should have CC:ed you the whole series.

> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> And thanks for taking the time in explaining me the details :)

No worries. :)

Johan

--CNjBYXrzSikli04s
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCacFfGBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQC8XNwux9ZQgnVwD/Q3X6RdvBSW0A8PUIA4ZB
2e8FyOAWQb58tkt66oBVG4kBAKjHv0cDtTlzn3uvktXRn1pa2X5l1mRzPqGaCmnS
2u4F
=IhzI
-----END PGP SIGNATURE-----

--CNjBYXrzSikli04s--
