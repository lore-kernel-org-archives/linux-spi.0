Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB2394786
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663089; cv=none; b=pxmyqw0DJZd84bDHEtb00gEsJnsi0A92cVJxA1n+8IMu9poFPMTE5JzzwGHoPkspd8DuNDwuko5YC68IPjr5V74/kygkdB2pDVCYQE++XvfCGkE5BsA5Big8jiSAnOSnnkAV4WEAXbRueQQRPg8CMVLQJ5TIVJeEcvfyjHlYc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663089; c=relaxed/simple;
	bh=m/TuoBMg3ymkSUKCTl/ZKP3nvXnA83o4t/rgmsIzYVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+SyufF067Slg7fDb9tSvKt9Vooan8QHCbfEUYXOZKki+IO4+i9KAusEAPPBVUUkCNPbATSeVGOKmsQObUlwgw6gnQ/0uv4eNnInrKQZu8C9+/0Ezc3YFmBH0v7o5WddVkhjhQ+fqRwUUhAPa2CEqfmxXSbNyauY+SYwlUcXHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w26n1-0002vJ-KU; Mon, 16 Mar 2026 13:11:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w26n1-000ZGP-0b;
	Mon, 16 Mar 2026 13:11:19 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E1396504E3E;
	Mon, 16 Mar 2026 12:11:18 +0000 (UTC)
Date: Mon, 16 Mar 2026 13:11:18 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: James Clark <james.clark@linaro.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, Frank Li <Frank.Li@nxp.com>, 
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH spi-next 11/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_bitrate(): don't treat devtype_data->prescale_max == 0 as a
 special case
Message-ID: <20260316-spectacular-warthog-of-refinement-1af0bd-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
 <20260316-spi-fsl-lpspi-cleanups-v1-11-1b695607702d@pengutronix.de>
 <dbdd4655-1c6a-42b0-a6fe-8d14db1043f0@linaro.org>
 <20260316-statuesque-effective-silkworm-011ed8-mkl@pengutronix.de>
 <2b1eecef-9da4-45a7-9401-425715de4624@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hp6lsxboaypg22is"
Content-Disposition: inline
In-Reply-To: <2b1eecef-9da4-45a7-9401-425715de4624@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--hp6lsxboaypg22is
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH spi-next 11/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_bitrate(): don't treat devtype_data->prescale_max == 0 as a
 special case
MIME-Version: 1.0

On 16.03.2026 12:08:13, James Clark wrote:
> Those structs are configuration for different devices though. Having a 7 =
in
> there implies that it's something that is configurable to different value=
s.
> When I was adding a new device that made be crawl through a load of
> datasheets to see why arbitrary values were needed only to find out that
> it's only for one errata where it's 1 and actually every other device sho=
uld
> be 7.
>
> I tried to change it to a bool "has the errata" or "doesn't have it", as
> that's the extent of the valid configurations that should be exposed. But
> Frank said he preferred a number with 0 as the default. That seemed like a
> slight improvement to me so that's how it ended up like that.

Thanks for the insight, I'll drop the patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hp6lsxboaypg22is
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabfzZAAKCRDMOmT6rpmt
0mUCAP9ub55JhgxetU8leBiIFjHQ65xxjiYwpc9m5F18IYOqUAD/Z8Tot3Pw57IZ
4LmNkvmCV+mH5R86lt00eBOll9B7lgw=
=vMPh
-----END PGP SIGNATURE-----

--hp6lsxboaypg22is--
