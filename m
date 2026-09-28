Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081AB4E4C51;
	Mon, 28 Sep 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608134; cv=none; b=cQ5Tq39XUC/E/ucJTuEE7DjKU9ycmX5TOECeVcz4UrW4RSsTxC00CRP3aLme8BbC+WK+fbqwNQRjd5p/C5jTgC5IQx4lMgCLCMlS5lTnYUEb8n01Ot7nQWhQ7s+7lBY5rz8icd270bhdkBL6zmygDEbLuun0Juy3UOSbLPvjsec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608134; c=relaxed/simple;
	bh=2xkGA8aZKLllhVVJE91IdJDwl7ahKvtTwSPbi3DRxe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK7uZjmwnPRmY8wys3C4BB/k3JOtKag1uMA4qHtbD2wMLpCjIlMYZkdvs40h5mCYNHjD0y1i1u8HghBqcEVk3FlBC1MhGt9dq6X1W0g9CzeOUBkic268t1GYnFwSiywilh1KUQHqa5oS7s1ibL9Uth+cq5j0XGzOPc7aodMfV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrIN7/Fe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrIN7/Fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E681F000FF;
	Mon, 28 Sep 2026 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790608132;
	bh=v+86pY99f9Mrk7cH2S6hh0JxWIlKV8Q01gKUQP1sGWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LrIN7/Fe/DLtQMb4ZNm93wXqsYFbgZeElpI+rGtZ5FEkbyc08On+5BqSICFngypW0
	 Wn9r4L2c/HF0KZQ7YslHfXuHYGlPfwwdIW5cXwsawmYrOf7laDvSRI6o1UvU66SkTj
	 Bowb75sMWKbVFCVdSw/ux/c6UddG0982SuKxFtH/XjiFy5fKm8tbW2J1/OCHMLE4c7
	 BPMAr247e92qEKeQYtyEWtUedJhYtjxlkFWMVRH3kLjYsxrm89A6Ita0sfWwSaYvoD
	 iVFXNE6CAou63jcv59q4fVednKg66VZhM2P6DJFBC8LlKVYY0/L6RlyKRa+o6lXRwE
	 amU0fgU9l+z7g==
Date: Mon, 28 Sep 2026 16:08:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>
Subject: Re: [PATCH 0/4] spi: spi-mem/mtd: spinand: Prevent SPI NAND
 continuous reads on am65/am62
Message-ID: <38290328-a562-4813-a9e0-2fafaa3874c7@sirena.org.uk>
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
 <878qa7dzke.fsf@bootlin.com>
 <87mrt177km.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UW2x+p4caSA0vA8C"
Content-Disposition: inline
In-Reply-To: <87mrt177km.fsf@bootlin.com>
X-Cookie: All is fear in love and war.


--UW2x+p4caSA0vA8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 28, 2026 at 04:51:21PM +0200, Miquel Raynal wrote:

> It seems like the spi bits have not been applied, can you check if you
> can still apply them? Without these, people using this controller with
> continuous read capable devices may observe spurious issues hard to
> debug (due to the CS possibly not being kept asserted during long reads,
> leading to the continuous read being cancelled by the SPI NAND).

No, they don't apply to even v7.3-rc1.  I didn't see the immutable
branch mentioned in:

   https://lore.kernel.org/r/1FyLxEwWqNFzX@sirena.co.uk

yet?

--UW2x+p4caSA0vA8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq6gv4ACgkQJNaLcl1U
h9DudQf7BuWfGWihFlF2YkdCUNB4BRnTbzaO30+LUfjJ7Qwcy3qf7sS/X3hyPTuH
WtJoIY+UOpk5OE3Jl1PuBbcZqV8cWokcXCwQCtHp/hROw1fLEHQH0UiKqABUe88C
2x3PINQRmgINaSiImDEPzH+8epIU8d7v2TGEUwcXdNA7JAkFUZQrDoInDMeF+vDp
68O14Y5djmpT3WLf53E0W0RtUXwAlyCz8v2/VcUs+EoOTaR+PzAkiF8+ef/Tuibp
sYzA+bEMbBeqPegks8mItzFKIJA90Tflv+aVISYFkoJD7dC9BPCZVD3lIg7a0G5q
CYlhzRU4XF+6P5DoHPLccd3TbHFP/w==
=hVRM
-----END PGP SIGNATURE-----

--UW2x+p4caSA0vA8C--
