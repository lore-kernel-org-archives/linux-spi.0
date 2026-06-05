Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF839A7F4;
	Fri,  5 Jun 2026 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672866; cv=none; b=Vr1VNCvjUJgXMsoxRpqoEJ/amlWaFcF5FHev++98Muf0xl9JuYp5ObvO7FRI2YTytVqDXL01qwq9e6VaiaKHaAEftJ8hykSuFA80zFN5W9NFY70BygLeMACe9gQW3AewYxCi/JrtkFRj8+MnIik4WKE9e/7CdfJB3voJ7IxoAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672866; c=relaxed/simple;
	bh=vw91GZNtqBFohd/dG1WeoM+tMXZptKE7kVHQJDsCpOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnQ8OXrh3rNeaTehFpdKdkhSJbNWu1op9GYTjwjwB/XyMc+XTISYP1OIoUEgeqUgJnk9xQ7PULoXKVN08fENaABeJH2Gq4LxQRm/zkj2XFaLcQHD0svOmxOxMQIDim16aHzpbuKXoQk5FOYTkaYRHfHmXki8wsjcvq8JfMQGBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrD1vjtK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrD1vjtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A43C1F00893;
	Fri,  5 Jun 2026 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780672865;
	bh=vw91GZNtqBFohd/dG1WeoM+tMXZptKE7kVHQJDsCpOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QrD1vjtK+SkysmU4faIqnr8ZN6m9IEZx4MtrX9q2kfLLNKJzB3Dy3rRqj6etwUTX3
	 H5+h1QlUbbXgkXEdyMhmOsLNj+Zo+RKomonT2jiUT9Xxj4q43D2Mhn+qrKnzubTxw+
	 eIiQ/F4T1QScIFYEYDxbn8PZ9vGvGVJi1M6t/TKjqfVOW9FH2WWqO/Zt/DqdoDco9r
	 1OhvnXMmT0/QSlObCncM+8K0HqAG62kbceKT4okzLYR7ZjPZHtcz4xmfzZgV6fCNW5
	 HaFVmQEK66fCAmwFHeVMeu1bZy6Zb8O4g0ty7qsZw2xsRZIwbU7SAhMNt7LDogjxFR
	 zgnuXdGDgRS6g==
Date: Fri, 5 Jun 2026 16:20:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Santhosh Kumar K <s-k6@ti.com>, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, richard@nod.at,
	vigneshr@ti.com, pratyush@kernel.org, mwalle@kernel.org,
	takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com,
	a-dutta@ti.com
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
Message-ID: <20260605-cane-duct-a5c740fae417@spud>
References: <20260602-aptly-bunkbed-1bd3a8d63d54@spud>
 <875x3zzkji.fsf@bootlin.com>
 <20260603-neatly-twine-e89b923f5cb6@spud>
 <87o6hry4d4.fsf@bootlin.com>
 <20260603-balance-encounter-94f69e1577f3@spud>
 <87ik7yydyv.fsf@bootlin.com>
 <20260604-shrunk-acclaim-25368d7ad63e@spud>
 <87a4t9wl7r.fsf@bootlin.com>
 <20260605-regulate-crawling-253c6d6bd971@wendy>
 <87tsrh4fe2.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n7CCSV6H7UyMc2Oa"
Content-Disposition: inline
In-Reply-To: <87tsrh4fe2.fsf@bootlin.com>


--n7CCSV6H7UyMc2Oa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 09:26:13AM +0200, Miquel Raynal wrote:
> On 05/06/2026 at 08:17:18 +01, Conor Dooley <conor.dooley@microchip.com> =
wrote:
>=20
> > On Fri, Jun 05, 2026 at 08:32:56AM +0200, Miquel Raynal wrote:
> >> On 04/06/2026 at 09:36:49 +01, Conor Dooley <conor@kernel.org> wrote:
> >>=20
> >> > On Thu, Jun 04, 2026 at 09:14:16AM +0200, Miquel Raynal wrote:
> >> >> Hi Conor,
> >> >>=20
> >> >> >> >> > Right, and this I guess is what scuppers letting the contro=
ller driver
> >> >> >> >> > sort the configuration out itself and leaving the property =
as-is.
> >> >> >> >> > It could be that the speed in spi-max-frequency is lower th=
an the "base
> >> >> >> >> > speed" of the controller but because of board routing or de=
vice
> >> >> >> >> > capability that the tuned mode is still required, right?
> >> >> >> >>=20
> >> >> >> >> I do not actually expect any tuned mode/frequency to be manda=
tory.
> >> >> >> >
> >> >> >> > I think you misunderstood my use of "required", I meant that t=
he new
> >> >> >> > property/information was needed in the scenario I described, n=
ot that it
> >> >> >> > should be a required property in a binding.
> >> >> >>=20
> >> >> >> Yes I misunderstood the term indeed. However I still fail to cat=
ch what
> >> >> >> you meant here, I'm sorry. Would you mind rephrasing?
> >> >> >
> >> >> > I was talking about a scenario where you want to use the tuned mo=
de to
> >> >> > achieve the maximum rate because of the device and/or board confi=
guration,
> >> >> > but the rate is below the point where the controller would need t=
uning.
> >> >> > Say the controller needs tuning above 8 Hz but the conditions req=
uire
> >> >> > tuning to achieve more than 5 Hz. In this example, if the device =
can do
> >> >> > 6 Hz, spi-max-frequency (in the current form) would be set to 6 H=
z, and
> >> >> > the controller would not enable the tuned mode, leading to proble=
ms
> >> >> > because the inflection point determined from the controller compa=
tible
> >> >> > of 8 Hz would not have been reached.
> >> >>=20
> >> >> I don't think this is a real situation. If the "conditions", as you=
 say
> >> >> (ie. PCB routing, mostly) require tuning above 5, then spi-max-freq=
uency
> >> >> should be 5.
> >> >
> >> > Then tuning mode would never be used.
> >>=20
> >> Well, this is exactly what we propose in this series, a way to indicate
> >> two maximum frequencies, one that just works (like before) and a higher
> >> frequency that is only reachable after an extra tuning procedure.
> >>=20
> >> > Remember, this is a theoretical world
> >> > where spi-max-frequency would contain the tuned frequency and the
> >> > controller was using compatible-specific speed thresholds to determi=
ne
> >> > if tuning was required.
> >>=20
> >> That is not what we are proposing. I don't think indicating the "after
> >> tuning" frequency in a property that has long been used for an always
> >> reachable frequency is wise. Hence either the use of an array (the
> >> second entry could contain a higher frequency) or a secondary
> >> spi-max-frequency-whatever property.
> >
> > I am/was trying to come up with a scenario that would justify the patch
> > man, stop trying to interpret it as what I want done.
>=20
> Ah :-) Sorry the intention was unclear to me. So what is your preferred
> take in the end?

I think the generic dedicated property makes the most sense to me.

--n7CCSV6H7UyMc2Oa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiLpWAAKCRB4tDGHoIJi
0if4AP9/WM+AK0u5JheOzThGNxZOzx0f/LbnrVw+eUcxqqq1zAEAhHeg2ZUM0hWt
Wobi1Twk/64oObefh9HxMBtDl6GhxwY=
=/wCv
-----END PGP SIGNATURE-----

--n7CCSV6H7UyMc2Oa--
