Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EF3DA5B4;
	Wed,  3 Jun 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504822; cv=none; b=gArXqTU7Hh4HF6aqWLSlMexQvkMMZMOXyLtSv7gExgeG5cd8u9wJJuBiEoaUgq3lpEJX61JTD0zg/vu73/DUihqyj/e6eA5UeduXJmWzW5HVJi2V5gV6jn0TcbXUPKIgVa9DH9oht4JPuGEOvo0S18IkYqk4miH8LXdgF1cXIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504822; c=relaxed/simple;
	bh=luc4L6XhnT5LeMOhHEbjH+HurAt5HycuPtqvc7Gzf1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz1XbOixbPkYLRIq/wa+cJLrFsowiiFsVzxMRo0H/5LbsfOI7zUdRG7acPRYhFVdHaXDuG1xc10LJplhRK+lATbGkl0LNlrp7/UgichAx6plsciGApLQR2w4IIBKTt8li5AsTYbjfWwni20qT39vcyHYnrW/rKhaW41znHxtu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF/0kdZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF/0kdZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35DE1F00893;
	Wed,  3 Jun 2026 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504821;
	bh=luc4L6XhnT5LeMOhHEbjH+HurAt5HycuPtqvc7Gzf1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MF/0kdZdsTn0ndmOwHBtYvNd9WB3YZ/gujPrpBgp8Cc3chrki7SHBBuctzf3/wq55
	 tzub1mNw9M2c6YNkjtqJHxdTU3d66x+gwYX6YimJNJtPfBPX8gGDFX0jLdpEw+G7jz
	 ppBjus1OthH9JzY+nFRolUHeXgyG73FlALmTvWwS/RrdVSRk2q28MO4TWwP8c/8U2j
	 dZS6X7BCovo64YOazj/wBcx7p4sYa/YPCuQUkcH14aKlVl3LErL8b6hjTK8xiW94FP
	 JasSEsKJ9TgxdEFgN1RHQahxdf/KX6/X2RXW4bcUBzDNuaywhNXMWjrOwtUhN1K5aP
	 3jZKJ92hLF0Wg==
Date: Wed, 3 Jun 2026 17:40:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Santhosh Kumar K <s-k6@ti.com>, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, richard@nod.at,
	vigneshr@ti.com, pratyush@kernel.org, mwalle@kernel.org,
	takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com,
	a-dutta@ti.com
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
Message-ID: <20260603-balance-encounter-94f69e1577f3@spud>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-2-s-k6@ti.com>
 <20260528-clergyman-kindling-20971775ba78@spud>
 <eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com>
 <87cxy92llq.fsf@bootlin.com>
 <20260602-aptly-bunkbed-1bd3a8d63d54@spud>
 <875x3zzkji.fsf@bootlin.com>
 <20260603-neatly-twine-e89b923f5cb6@spud>
 <87o6hry4d4.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jfR/k67CoFQAEo41"
Content-Disposition: inline
In-Reply-To: <87o6hry4d4.fsf@bootlin.com>


--jfR/k67CoFQAEo41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 06:29:27PM +0200, Miquel Raynal wrote:
>=20
> >> >> > The non-PHY frequency is a controller limitation/capability rathe=
r than
> >> >> > a flash characteristic, so it seems more appropriate to keep it i=
n the
> >> >> > controller driver as Conor suggested.
> >> >>=20
> >> >> The non tuned frequency is the maximum frequency one could use
> >> >> reliably. It is not controller specific. It is mostly board specifi=
c,
> >> >> and to some extend may also be chip specific.
> >> >>=20
> >> >> The tuned frequency is the maximum frequency one could use reliably
> >> >> after line a controller or chip specific training procedure. It is
> >> >> also the result of an aggregated set of non discoverable hardware
> >> >> limitations:
> >> >> - board routing
> >> >> - chip capability
> >> >> - controller capability
> >> >
> >> > Right, and this I guess is what scuppers letting the controller driv=
er
> >> > sort the configuration out itself and leaving the property as-is.
> >> > It could be that the speed in spi-max-frequency is lower than the "b=
ase
> >> > speed" of the controller but because of board routing or device
> >> > capability that the tuned mode is still required, right?
> >>=20
> >> I do not actually expect any tuned mode/frequency to be mandatory.
> >
> > I think you misunderstood my use of "required", I meant that the new
> > property/information was needed in the scenario I described, not that it
> > should be a required property in a binding.
>=20
> Yes I misunderstood the term indeed. However I still fail to catch what
> you meant here, I'm sorry. Would you mind rephrasing?

I was talking about a scenario where you want to use the tuned mode to
achieve the maximum rate because of the device and/or board configuration,
but the rate is below the point where the controller would need tuning.
Say the controller needs tuning above 8 Hz but the conditions require
tuning to achieve more than 5 Hz. In this example, if the device can do
6 Hz, spi-max-frequency (in the current form) would be set to 6 Hz, and
the controller would not enable the tuned mode, leading to problems
because the inflection point determined from the controller compatible
of 8 Hz would not have been reached.

--jfR/k67CoFQAEo41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiBY7wAKCRB4tDGHoIJi
0gfaAP0RkM4eZhjmrtl+tS3WyfzVSDCbOdy5h+wDJtvyjB/fyAEA5L95wFVM8cTS
9cLHUtafen8uIvPf2HFXeFNdH9wCjwM=
=/26Q
-----END PGP SIGNATURE-----

--jfR/k67CoFQAEo41--
