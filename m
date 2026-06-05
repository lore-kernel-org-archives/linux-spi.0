Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA272EEE6E;
	Fri,  5 Jun 2026 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643894; cv=none; b=cyxF6p74sUfe243AWtBPfVqtQKOFnLW+W8k+zriUAKkzfitnEiaGdKPsIH7l3ppFwClgFky8SFrhf+VsGTwTOSiufx+Q0Idj/glqCcEMx5AwVoCHkEUnr0/LAYstvFdmLk761bT8UyMCOGFClAJw7NKMA1boHyHcr8HUqzCZUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643894; c=relaxed/simple;
	bh=jcrToytibwcBAYhSAoNEEpY1rO4Mmvre/yeNqvlg5Fw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuSip+yPtnQUs5Sbi6cwbKkZd0jQsmEvFMNydOeWrhGSC0Dk0Vi8j+i4UbggLQBfhJXeK7xh2Ty+j5RuBhAcBJ4j3PDSD+X1tkeguqZRr0jh4cHVFTUW/tQhudzcrXDtfMemUlK4y0B4qo//n3NasFkTczfOg4OCEjNTK8uXD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b7+3e0Cu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b7+3e0Cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780643894; x=1812179894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jcrToytibwcBAYhSAoNEEpY1rO4Mmvre/yeNqvlg5Fw=;
  b=b7+3e0Cu12maMeGmtkn2FIkQrGXzzBl5l0X//7dAub2oRHPG6n0oXHZT
   5Cox8KnyZi4u+q03plJ5I86ZvjNFlKqtnehUPQlVFy7lVs+YXffio1kkV
   8LlUs/hP6T3xxzQvnoB/JXVgcF46lGua5z393XkeYq+5lWs2eF4u7TGRe
   s+/uCKPqv9/G0WNow8L+6IT3R5OzAquszt2/e5Rp9cQLmiOps3DAwEqV+
   z31Glm0irGonLruUf+3Y2sHGPg2kpOa3tOUXirIm4yZNlg8+vJgL4WmAL
   2ZXPsUFnwiSQwByhOXRtskeuj1r3ON0UKL6RQeK0oZ1AeSaom0NcMpfkZ
   A==;
X-CSE-ConnectionGUID: GTxp86iZTpGaNRQZ6+6kdA==
X-CSE-MsgGUID: QRxBKdmdRiqD2ogDiIat/g==
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="asc'?scan'208";a="58640353"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:18:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 5 Jun 2026 00:18:06 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 5 Jun 2026 00:18:02 -0700
Date: Fri, 5 Jun 2026 08:17:18 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Conor Dooley <conor@kernel.org>, Santhosh Kumar K <s-k6@ti.com>,
	<broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
Message-ID: <20260605-regulate-crawling-253c6d6bd971@wendy>
References: <eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com>
 <87cxy92llq.fsf@bootlin.com>
 <20260602-aptly-bunkbed-1bd3a8d63d54@spud>
 <875x3zzkji.fsf@bootlin.com>
 <20260603-neatly-twine-e89b923f5cb6@spud>
 <87o6hry4d4.fsf@bootlin.com>
 <20260603-balance-encounter-94f69e1577f3@spud>
 <87ik7yydyv.fsf@bootlin.com>
 <20260604-shrunk-acclaim-25368d7ad63e@spud>
 <87a4t9wl7r.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zUWntl/XEoxjT7CW"
Content-Disposition: inline
In-Reply-To: <87a4t9wl7r.fsf@bootlin.com>

--zUWntl/XEoxjT7CW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 08:32:56AM +0200, Miquel Raynal wrote:
> On 04/06/2026 at 09:36:49 +01, Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Thu, Jun 04, 2026 at 09:14:16AM +0200, Miquel Raynal wrote:
> >> Hi Conor,
> >>=20
> >> >> >> > Right, and this I guess is what scuppers letting the controlle=
r driver
> >> >> >> > sort the configuration out itself and leaving the property as-=
is.
> >> >> >> > It could be that the speed in spi-max-frequency is lower than =
the "base
> >> >> >> > speed" of the controller but because of board routing or device
> >> >> >> > capability that the tuned mode is still required, right?
> >> >> >>=20
> >> >> >> I do not actually expect any tuned mode/frequency to be mandator=
y.
> >> >> >
> >> >> > I think you misunderstood my use of "required", I meant that the =
new
> >> >> > property/information was needed in the scenario I described, not =
that it
> >> >> > should be a required property in a binding.
> >> >>=20
> >> >> Yes I misunderstood the term indeed. However I still fail to catch =
what
> >> >> you meant here, I'm sorry. Would you mind rephrasing?
> >> >
> >> > I was talking about a scenario where you want to use the tuned mode =
to
> >> > achieve the maximum rate because of the device and/or board configur=
ation,
> >> > but the rate is below the point where the controller would need tuni=
ng.
> >> > Say the controller needs tuning above 8 Hz but the conditions require
> >> > tuning to achieve more than 5 Hz. In this example, if the device can=
 do
> >> > 6 Hz, spi-max-frequency (in the current form) would be set to 6 Hz, =
and
> >> > the controller would not enable the tuned mode, leading to problems
> >> > because the inflection point determined from the controller compatib=
le
> >> > of 8 Hz would not have been reached.
> >>=20
> >> I don't think this is a real situation. If the "conditions", as you say
> >> (ie. PCB routing, mostly) require tuning above 5, then spi-max-frequen=
cy
> >> should be 5.
> >
> > Then tuning mode would never be used.
>=20
> Well, this is exactly what we propose in this series, a way to indicate
> two maximum frequencies, one that just works (like before) and a higher
> frequency that is only reachable after an extra tuning procedure.
>=20
> > Remember, this is a theoretical world
> > where spi-max-frequency would contain the tuned frequency and the
> > controller was using compatible-specific speed thresholds to determine
> > if tuning was required.
>=20
> That is not what we are proposing. I don't think indicating the "after
> tuning" frequency in a property that has long been used for an always
> reachable frequency is wise. Hence either the use of an array (the
> second entry could contain a higher frequency) or a secondary
> spi-max-frequency-whatever property.

I am/was trying to come up with a scenario that would justify the patch
man, stop trying to interpret it as what I want done.

--zUWntl/XEoxjT7CW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiJ3+wAKCRB4tDGHoIJi
0tz4AP97UBfrz9S9QPKf/ELSWSCSJG0AKrTL2Ilbca63w1hqBwEAmh8dIG97WI0/
6CTKNcnF/fGzd+mNaOA+H2isiryDNgs=
=GMVI
-----END PGP SIGNATURE-----

--zUWntl/XEoxjT7CW--
