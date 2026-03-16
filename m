Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4112512C8
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659978; cv=none; b=Gdl0HQBYu4kNMoyPgXBsvCEreU8NK2brrrNYlbZJHaQW4yLbXOkrY97WkpPfrJN4LWsUmDBwaDm+ZAi4tSqcjLhlN8EqNYkAxUSRxvuvAUfVuXumpHTUQLUf1Q76EivU/pAwB30eniiQaT07vnGP/Ny5be2RgYm758SQ5z/rUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659978; c=relaxed/simple;
	bh=1S0wIl/YZHfjM0IJFm4NkG2mpieY9HdmV3sF4TYbkg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIiFWEGQPrsRwn3IsXfLw2WUjnGEUWsDOGS+3LC0ZlKoreruLij1IGa2AeyHRmz8sqP9x+SL6/jv9UuJ+yI2CBB/qjbtl9IcGVyCOENm7TFUBRWkmcOxCoc8tiWuJLzt0p+utdvb/y1rvxdQ0Km5FPdCfE4SRF9izxrcGvfYWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w25yt-0004TT-Hc; Mon, 16 Mar 2026 12:19:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w25yt-000Yow-00;
	Mon, 16 Mar 2026 12:19:31 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AA22E504D79;
	Mon, 16 Mar 2026 11:19:30 +0000 (UTC)
Date: Mon, 16 Mar 2026 12:19:30 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: James Clark <james.clark@linaro.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, Frank Li <Frank.Li@nxp.com>, 
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH spi-next 11/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_bitrate(): don't treat devtype_data->prescale_max == 0 as a
 special case
Message-ID: <20260316-statuesque-effective-silkworm-011ed8-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
 <20260316-spi-fsl-lpspi-cleanups-v1-11-1b695607702d@pengutronix.de>
 <dbdd4655-1c6a-42b0-a6fe-8d14db1043f0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vsgq432vw6vb7dzf"
Content-Disposition: inline
In-Reply-To: <dbdd4655-1c6a-42b0-a6fe-8d14db1043f0@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--vsgq432vw6vb7dzf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH spi-next 11/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_bitrate(): don't treat devtype_data->prescale_max == 0 as a
 special case
MIME-Version: 1.0

Hello James,

I've no strong feelings about this patch, I can drop it in the v2.

On 16.03.2026 09:57:15, James Clark wrote:
> On 16/03/2026 8:39 am, Marc Kleine-Budde wrote:
> > The i.MX93 is affected by erratum ERR051608, the maximum prescaler valu=
e is
> > 1 not 7 as in the original datasheet.
> >
> > On unaffected SoC the maximum prescaler is 7. Commit 783bf5d09f86 ("spi:
> > spi-fsl-lpspi: limit PRESCALE bit in TCR register") added struct
> > fsl_lpspi_devtype_data to hold the system dependent prescale_max value.
> >
> > Commit 9bbfb1ec959c ("spi: spi-fsl-lpspi: Treat prescale_max =3D=3D 0 a=
s no
> > erratum") introduced the special value 0 to signal the default and
> > corresponding run-time check with a conditional operator.
> >
> > To simplify the code, set the prescale_max of imx7ulp_lpspi_devtype_data
>
> The whole point of the original change was to not repeat the normal value
> for every device in the config just because one device has an errata. This
> new change is exactly the opposite of simplification IMO.

Interesting point of view.

My reasoning is: When I look at the fsl_lpspi_set_bitrate() function,
there's the special case handling with the ternary for the "0".

I asked myself directly special case, why? Why not directly use the
value as it's provided by the devtype_data?

> > and s32g_lpspi_devtype_data to 7 and in fsl_lpspi_set_bitrate() directly
> > use the fsl_lpspi->devtype_data->prescale_max.
> >
> > On ARM64 this leads to a reduction of the code of 52 bytes:
> >
> > | add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-52 (-52)
> > | Function                                     old     new   delta
> > | fsl_lpspi_setup_transfer.isra                956     936     -20
> > | $x                                          7144    7112     -32

> On clang 15 this change makes it bigger by 220 bytes rather than
> smaller.

Quite interesting, with llvm-21 the size increases, too:

| add/remove: 0/0 grow/shrink: 3/1 up/down: 432/-32 (400)
| Function                                     old     new   delta
| fsl_lpspi_setup_transfer                    1072    1216    +144
| .Ltmp1                                      7116    7260    +144
| $x                                          7196    7340    +144
| $d                                          5659    5627     -32
| Total: Before=3D28126, After=3D28526, chg +1.42%

> I
> checked because I was suspicious that removing a single ternary could save
> 52 bytes, but it looks like the outcome after all the optimisations is ju=
st
> unpredictable so there isn't much point in making changes like this.
>
> You also didn't say _why_ we need to save 50 bytes, or what the performan=
ce
> impact is.

I just checked the impact on the code size with gcc and was positively
surprised. :) I don't need to save 50 bytes and there's probably no
measurable performance impact.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vsgq432vw6vb7dzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabfnPwAKCRDMOmT6rpmt
0ij+AP4tA2ErscWkvZ3Fwu5met7pd8olcpb13CXAY9a8emhxJwD+LzZ9Jhj5g5m6
fMD6ABKmdWb783qFOgVmBtIxqTSUUAk=
=jjT5
-----END PGP SIGNATURE-----

--vsgq432vw6vb7dzf--
