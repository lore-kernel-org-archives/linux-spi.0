Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722E3B47E8;
	Tue, 24 Mar 2026 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339785; cv=none; b=M68Hrj4Qe1lVN4vnyd8bmsuiDv5PyXkl88VyWUIIQNH30CGzxF3Zxy/HeUkijgSFH/0FsyFlHVvQOZNLmQfo/SD08+6xhr8cbHVhIlYFw8kg8O67oxGgDYb8vHS9mIxDXGt3knOjpbKrsKSRxbtAjjmEmyWoW0wV1BUoGmPEVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339785; c=relaxed/simple;
	bh=XxlmSGIl4mWpDTTaOZhCX1H7/OQdVvYCpZcSuPQyLLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdOQmmUtKH4X5JYg20dR11WSv8UL3yQvSv6u8ctoiHfeQmxewAbEvNEQLYTPPif3SjepNA1CQpV2RY2cnLQZhBY2JV76UFiTOo8pFRKA2NMZY28zyUuY+HdjHIvKdzJmZSXGR2BpwhP62uOTj/Yr9Fcc4VjJvC3ytDDUA9H0qaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCXqFsLu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCXqFsLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7949C19424;
	Tue, 24 Mar 2026 08:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774339784;
	bh=XxlmSGIl4mWpDTTaOZhCX1H7/OQdVvYCpZcSuPQyLLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCXqFsLu0AIRrvFgwpQ0Y+8J0dGCqKNJ52R11Zh/2AOKGPq2JoYTmVMnY6MHYhJts
	 p3w0PqiBbY6iNzV8kt8BOAfTKN+WHB4FQdNw1sWuZ3pLoYmqWVGjMFk0F3AUdlMCaK
	 P4qJdYZunfLObtg7O8iQSqHRMFq78zR9LTjGKy+JQn2M69azwObf+7g+qbb9P6SN6h
	 7Ud2BHQ6V2Ii5+9Vrg5FplaUcYiX5PijtD0EYa4Io9SpgHa1QpWmxjHgtCaWm9NK6y
	 AcZT9ub8Po8eNLa+oXKizg9l5T12hLgmgVxfs4goFDHnhPA5xAvMu+BfTyqelVLVrq
	 WzDUqYgmy547Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4wpa-00000003iZU-1ZXL;
	Tue, 24 Mar 2026 09:09:42 +0100
Date: Tue, 24 Mar 2026 09:09:42 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: rockchip: fix controller deregistration
Message-ID: <acJGxl66BDmd2-Xs@hovoldconsulting.com>
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-5-johan@kernel.org>
 <2ef1dcd6-68f0-4111-b8ac-fdaf4aea36d9@sirena.org.uk>
 <acFviPkEwqJb4y36@hovoldconsulting.com>
 <696a4dc3-9095-48d5-bfac-51de204af89e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xMkArMJ48MhKAW00"
Content-Disposition: inline
In-Reply-To: <696a4dc3-9095-48d5-bfac-51de204af89e@sirena.org.uk>


--xMkArMJ48MhKAW00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 05:02:49PM +0000, Mark Brown wrote:
> On Mon, Mar 23, 2026 at 05:51:20PM +0100, Johan Hovold wrote:
> > On Mon, Mar 23, 2026 at 04:35:39PM +0000, Mark Brown wrote:
>=20
> > > Fixes should go before any non-fix patches in the series to avoid
> > > spurious dependencies and make it easier to manage applying the serie=
s.
>=20
> > Sure, but here there are no inter-driver dependencies (that is, the sets
> > of patches for each driver respectively are independent).
>=20
> If you're treating the patches as independent then send a series per
> driver.

I sent these as a series as the changes are related, but sure, it is
possible to split it in three series as well.

> > And I didn't expect this one to go into 7.0-rc (no stable tag).
>=20
> Why wouldn't we apply bug fixes as bug fixes?

Not all bug fixes meet the stable backport criteria, and late in the
release cycle we tend to defer non-critical fixes to the next cycle.

This one is border line, but I'll include a stable tag when respinning.
=20
> > Do you want me to resend a reordered series?
>=20
> Please.

Will do.

Johan

--xMkArMJ48MhKAW00
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCacJGwxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQC8XNwux9ZQjZygD9EvJ9jD8Hyh5IG/DGvaWj
E1mSXPqIbAKqybfP2HzSuLYA/jRh84qwJs5FNnBr9An+oxYn9RgghUTTa8m6sizM
cy4E
=YRfU
-----END PGP SIGNATURE-----

--xMkArMJ48MhKAW00--
