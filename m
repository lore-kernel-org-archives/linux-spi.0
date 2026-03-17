Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41482331A5E
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738294; cv=none; b=XYOjqDzVAfbTBIf6+5L/JJAj7FMAS5l9H40LcoZgiRoANaBlzY8ckZW/gDIhMZmvbNg/UTIuvUhtOoKCWFZuaEAZ1hODGvuvOe2VJmKlLwXayaKq+AbjhZ/yVZsz2m3ATQ+TBEoy99gMQ9iLX/DH5EU37aJmxayAYV/IdjQ69zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738294; c=relaxed/simple;
	bh=kJ3+nJJg6PiWODU/3fU65iX7WzkNPC9djstMNR4LXWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdnATTeLSTpz/M900fJn+z+fWgFzdIJ3vycyM+ZHIszUDjdYtqhIEzSlYxsrGdMz7zFRJ/Y5MzjPyp1DGZXTz4CB7VZFd591o/1M/d0BuRWuk6RUHtMxYWeAmPcG3D0p9y9yC+nDMA1p2Mr2llIrzOvOU7OruTvcpjkXTZFLVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2QM0-0004eP-1u; Tue, 17 Mar 2026 10:04:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2QLz-000iBd-2C;
	Tue, 17 Mar 2026 10:04:43 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2B493505A75;
	Tue, 17 Mar 2026 09:04:43 +0000 (UTC)
Date: Tue, 17 Mar 2026 10:04:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH spi-next 02/11] spi: spi-fsl-lpspi: fsl_lpspi_probe():
 use FIELD_GET to decode Parameter register
Message-ID: <20260317-ordinary-liberal-vole-9d2524-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260316-spi-fsl-lpspi-cleanups-v1-2-1b695607702d@pengutronix.de>
 <20260317010548.3293912-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iodtmxpkk2tucydh"
Content-Disposition: inline
In-Reply-To: <20260317010548.3293912-1-Frank.Li@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--iodtmxpkk2tucydh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH spi-next 02/11] spi: spi-fsl-lpspi: fsl_lpspi_probe():
 use FIELD_GET to decode Parameter register
MIME-Version: 1.0

On 16.03.2026 21:05:45, Frank Li wrote:
> From: Frank Li (AI-BOT) <frank.li@nxp.com>
>
> Typo in commit message:
>
> > Instead of open coding mask and shift operations and to o increase
>
> AI: Should be "and to increase" (remove the extra "o").

Fixed.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--iodtmxpkk2tucydh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabkZKAAKCRDMOmT6rpmt
0uBDAP9SMTTVpxAbtMepBGriNZXNHbcfrKfBbetc1JzmsZS//QD9HOmv01cg+lQK
lutQRU+AWx70UxkICHOM+VQNazRT9ww=
=hr2e
-----END PGP SIGNATURE-----

--iodtmxpkk2tucydh--
