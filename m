Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49603DCDA5
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685880; cv=none; b=VVb9fDEIJD+mjiCZ4gMNm71eZ0HefgNV+Kr6A6QDuW5H+93uac65+WnUwDEPIusOSxYxZIq7DUhcgAWEof8Gl2qF8vDisixPtiZmZv4hi/7LDHfPkxUdRBGhsJ5QpvRDFRdY+T4H7RBlxNg8k1joyo4OHc8BpBeA/OkaHOx5kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685880; c=relaxed/simple;
	bh=1s5yL3jKHVPmD3EDSAmcQMcOnk479B5IteTYqbJ1oiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrdffgRkQUUDQpepHvgpjQI0FCUCd6Lrpov4zOVWLXQuUHB8BJQgEoCqBGPVIauMzNXmJ57hvrMXcG2SIINuQKTdl2VRF1Zankr2VLxCvMAXP10s8JQyyC8OTmSkajc+ZnmqS+iKE4vX4raKcO1nyN1JSzrVGATHqEx8y1+cXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2CiX-0005du-4c; Mon, 16 Mar 2026 19:31:05 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2CiW-000c9t-2T;
	Mon, 16 Mar 2026 19:31:04 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 754D2505384;
	Mon, 16 Mar 2026 18:31:04 +0000 (UTC)
Date: Mon, 16 Mar 2026 19:31:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH spi-next 04/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
Message-ID: <20260316-imperious-amusing-dogfish-0ca492-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
 <20260316-spi-fsl-lpspi-cleanups-v1-4-1b695607702d@pengutronix.de>
 <e4c711c1-5229-4685-aadf-f88aca9fbd3d@sirena.org.uk>
 <20260316-original-dove-of-respect-1a6e04-mkl@pengutronix.de>
 <0f04cc7e-c960-42fd-9a45-49777e49dd4b@sirena.org.uk>
 <20260316-venerable-caracara-of-advertising-a9e9b8-mkl@pengutronix.de>
 <b6787850-11cf-4b38-a5ea-da2c5d0811f4@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h7n4uq22syyuaq7j"
Content-Disposition: inline
In-Reply-To: <b6787850-11cf-4b38-a5ea-da2c5d0811f4@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--h7n4uq22syyuaq7j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH spi-next 04/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
MIME-Version: 1.0

On 16.03.2026 18:16:01, Mark Brown wrote:
> On Mon, Mar 16, 2026 at 06:59:12PM +0100, Marc Kleine-Budde wrote:
> > On 16.03.2026 17:37:45, Mark Brown wrote:
> > > On Mon, Mar 16, 2026 at 05:49:48PM +0100, Marc Kleine-Budde wrote:
>
> > > > The param register's default value on the i.MX93 is:
>
> > > > | LPSPI1=E2=80=93LPSPI3:  0002_0303h
> > > > | LPSPI4:         0003_0303h
> > > > | LPSPI5=E2=80=93LPSPI8:  0002_0303h
>
> > > > This means a RX/TX-FIFO size of 1 << 3 =3D=3D 8.
>
> > > Right, so the parsing code is using the wrong mask to extract the wid=
th
> > > here but with actual values it's fine.
>
> > No, the parsing code is correct, the width of the fields are 8 bits
> > (datasheet of all supported SoCs), but the values are "2" (i.MX7ulp,
> > S32G2) resp. "3" (i.MX93).
>
> Oh, dear, so that's potentially going to go badly if there's a SoC with
> a bigger FIFO that didn't also increase the watermark field width.  We
> should at least warn about that, and ideally do something sensible.

Good idea, I'll add a warning if the FIFO is bigger than the watermark
field.

To handle this situation I see 2 options:
- warning + limit the FIFO to the usable size due to the currently
  hard-coded watermark width - this will result in reduced throughput
- increase the watermark mask to 8 bits - which is basically how the
  unpatched driver works.
  As outlined in my previous mail, the other code in the driver takes
  care that the watermark stays within the limits.

> > into the watermark fields. So using the 3 bit mask in FIELD_PREP should
> > not be a problem, even on the IP cores with just 2 bit wide mask.
>
> Yeah, it's not broken right now - just landmines for potential future
> SoCs to trip over.

ACK

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h7n4uq22syyuaq7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabhMZQAKCRDMOmT6rpmt
0qpaAQCmJHjrIW0icAPqbzHiLpAYHFFXpMbhIP3A4xjQI5WxzwD/XFYFDp6iiTOG
OSNEF7mJ6YtsHdPvn8t4MWmYQgHgygQ=
=rzLM
-----END PGP SIGNATURE-----

--h7n4uq22syyuaq7j--
