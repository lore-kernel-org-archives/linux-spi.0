Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9136B07C;
	Wed, 18 Mar 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820457; cv=none; b=E6ml+W72rqOGYedTANaEtn0xanHaj5GklX2o3TbMmr8DDBs5CRShuXoZ15EFMYYxIuOcth9ghum5odwe+y7cPHeyXHlFkuG6FitE5S2u7Z2p4mSZJ9dVW19HCWMAP+J0wweafHsmUWJfiRG97g3Q3UEe2Ty5BlhxtqxxajTNUHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820457; c=relaxed/simple;
	bh=bk4wnamFVrTawAELOt9eEX4xVNZGHRQD1ApgpP4wf3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB5b+urJqVhYsXtgFMNOTKwtnSukfGaynN18lr8NkPuPvlpT+fF6u1gOurPsOUhmbjL4Un/4R1lbW5zNNE6WfPF7htnIKyHCVf4+/NRJAxkGnbgS3UmmC0sjq5j3qR9us13tO3Ua6cMRbl9e7NFO/Edg/6r9j9birmCHkQ0LtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hs8svr+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs8svr+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93864C19421;
	Wed, 18 Mar 2026 07:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773820456;
	bh=bk4wnamFVrTawAELOt9eEX4xVNZGHRQD1ApgpP4wf3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hs8svr+Y5W5blUFJJY4rkdg1xasKU2xi5NfqKhojiPuresAviLCtBvwNKJvRUKvIh
	 LuN4PgfcgBtZ3qj2EaYv9ZN/YMX6OcvLZ9+1zzTBcuj9qDKPlLOklOyyB1idGwKiOK
	 Ym+BZqwerJCO6cyr/OKND+mipc4MTwT1FmqzHbDSaBnLsLuLgb0rEDKZBp/275L9WF
	 Oq1VLFwXYTY4EBdbwvrUn/7O0PkNaeek3+NjNk1utstnD2bewniH3wWzBeQc/FVF5n
	 elr+nErpGnnVpR5IYlJNSdlV2fHq3axS9sThSXtdT4aIDP4+r890P4d8D/96T1W6mx
	 GtmrQuMYcuvaw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w2ljK-00000000655-0fr0;
	Wed, 18 Mar 2026 08:54:14 +0100
Date: Wed, 18 Mar 2026 08:54:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Harshit Shah <hshah@axiado.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: axiado: fix use-after-free on probe failure
Message-ID: <abpaJu19LN1Z0U8o@hovoldconsulting.com>
References: <20260312102811.29223-1-johan@kernel.org>
 <df8998fc-f3c9-48a6-a4a4-33a8726bb386@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W57NZo3JaH3v67w0"
Content-Disposition: inline
In-Reply-To: <df8998fc-f3c9-48a6-a4a4-33a8726bb386@sirena.org.uk>


--W57NZo3JaH3v67w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 05:35:55PM +0000, Mark Brown wrote:
> On Thu, Mar 12, 2026 at 11:28:11AM +0100, Johan Hovold wrote:
> > The SPI controller allocation is device managed and must not be released
> > before returning on probe failures (e.g. probe deferral) to avoid
> > use-after-free.
>=20
> Felix Gu already sent a version of this which was applied, please check
> if there's anything remaining to be fixed here.

That diff looks correct.

Johan

--W57NZo3JaH3v67w0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCabpaIhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQC8XNwux9ZQjM1AEAq8M+l3T7LBvC4YDPQTUZ
gmG+ugdhUC2/m2iRTnPBjy8A/0gZVYM8/a5nnErqTnZ8Hpu1nrUP20sSTLKRbBtU
KksL
=QYSH
-----END PGP SIGNATURE-----

--W57NZo3JaH3v67w0--
