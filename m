Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C282390C82
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740699; cv=none; b=QEkf67ZHce+X9PQC1StSHO9QQCtL+84D7B1hbl/lbSJejx917WfsBXqttjgKfDCezIfg3qPFMFLOgdsl5zqsM03p7rvzXAxMjYO6g6pqE7Au0Cu8BJXLgUoILLpNmwwlTlfPHlltWjQc8OFQKh66WfzJb5/yRODHtO1tXYH1nug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740699; c=relaxed/simple;
	bh=rbkGXZUTbzl4wjQApSCgMFx0j1VLIx6SsyEX3z6TrXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIByhXzlF38Ld9EDMQ4czMSYhqrJZI+eesaaQEEkxgOHzlHnnUdbemEae61g13KU8N4fGaZVCmn5gCKrjNvc9RlcZ6pi6bIFzDmY/8ynEtc1300LV1iXUERdz3EbtQUGfu5ZHtwNHX2/nPxz+ke/iKAHc0jvaVg4a6iDhI6Cixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2Qyq-0002yP-8g; Tue, 17 Mar 2026 10:44:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2Qyp-000iXV-2z;
	Tue, 17 Mar 2026 10:44:51 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A5B83505B19;
	Tue, 17 Mar 2026 09:44:51 +0000 (UTC)
Date: Tue, 17 Mar 2026 10:44:51 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH spi-next 04/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
Message-ID: <20260317-beautiful-intrepid-chihuahua-6113b0-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
 <20260316-spi-fsl-lpspi-cleanups-v1-4-1b695607702d@pengutronix.de>
 <e4c711c1-5229-4685-aadf-f88aca9fbd3d@sirena.org.uk>
 <20260316-original-dove-of-respect-1a6e04-mkl@pengutronix.de>
 <0f04cc7e-c960-42fd-9a45-49777e49dd4b@sirena.org.uk>
 <20260316-venerable-caracara-of-advertising-a9e9b8-mkl@pengutronix.de>
 <b6787850-11cf-4b38-a5ea-da2c5d0811f4@sirena.org.uk>
 <20260316-imperious-amusing-dogfish-0ca492-mkl@pengutronix.de>
 <585afe0e-0ffc-44bc-b3d2-63e5075ab1f5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qdry5lnhogdwtgll"
Content-Disposition: inline
In-Reply-To: <585afe0e-0ffc-44bc-b3d2-63e5075ab1f5@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--qdry5lnhogdwtgll
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH spi-next 04/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
MIME-Version: 1.0

On 16.03.2026 18:49:15, Mark Brown wrote:
> > > Oh, dear, so that's potentially going to go badly if there's a SoC wi=
th
> > > a bigger FIFO that didn't also increase the watermark field width.  We
> > > should at least warn about that, and ideally do something sensible.
>
> > Good idea, I'll add a warning if the FIFO is bigger than the watermark
> > field.
>
> > To handle this situation I see 2 options:
> > - warning + limit the FIFO to the usable size due to the currently
> >   hard-coded watermark width - this will result in reduced throughput
> > - increase the watermark mask to 8 bits - which is basically how the
> >   unpatched driver works.
> >   As outlined in my previous mail, the other code in the driver takes
> >   care that the watermark stays within the limits.
>
> I guess it depends how optimistic we are about hardware engineers
> keeping the FIFO and watermark depths in sync.

Right, we're talking about FSL/NXP hardware :D

> The first option is more
> defensive, but like you say it'll hit performance on future devices that
> do expand the FIFO.  I guess I have a slight preference for that?

Yes - I'll increase the watermark width to 8 bits and add a comment next
to the GENMASK.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qdry5lnhogdwtgll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabkikAAKCRDMOmT6rpmt
0uTHAP9DENCerrIPfeSLS2ISSv6ZjZ+tZ99q8JdjYRfKE3zwnwD/W+xi9wJnZykB
CSsLfSxOtU+ClhZ4eC0ARhnCMQNb6A8=
=OlS7
-----END PGP SIGNATURE-----

--qdry5lnhogdwtgll--
