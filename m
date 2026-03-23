Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03527380A
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277279; cv=none; b=FiOmTJsdBNes8nJPOiUyl8vid//MSdfsBT2QzzuDmcPAJMDAogfguRNFbxRlnikfNhGi+y7o96JnTYZwlrzfX3FqxwoWYudCKWtbHCHsp27NJ7Qt2xq6mA851qvf7D8mQuq5RL46e/8E5AyoYYTy1/5HJ75TrgipzocKouHBoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277279; c=relaxed/simple;
	bh=KRhWMY0D4yhGWFmKo7SIP64MOjxHmC4RNBxgbfWI36k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaaLbh3IQ2pMPYw7TQmoZBs+e1E75XLJSwYkRcB7K0Clh3G5fYLYRBuzJUzVEZPF4MOve8PKyM182qUnVN0u5B0rF99BFnAxLPlirSha7gMxXAouMRXJc9SvzwhTr4AL1ARkYJ1GnrVHuSqysYOgjGKremgeH2don3lg6fZRQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4gZG-0008Jq-WB; Mon, 23 Mar 2026 15:47:47 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4gZG-001kFp-1W;
	Mon, 23 Mar 2026 15:47:46 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C7C050ABB1;
	Mon, 23 Mar 2026 14:47:46 +0000 (UTC)
Date: Mon, 23 Mar 2026 15:47:45 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
Message-ID: <20260323-kickass-original-wapiti-a01804-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-2-johan@kernel.org>
 <20260323-demonic-worthy-guillemot-c2abb8-mkl@pengutronix.de>
 <acEh6KiKMfBehoZO@hovoldconsulting.com>
 <20260323-dangerous-brown-polecat-a4988f-mkl@pengutronix.de>
 <acFHVTsDIbQm6GG6@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3bczsw4zpehoor7x"
Content-Disposition: inline
In-Reply-To: <acFHVTsDIbQm6GG6@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--3bczsw4zpehoor7x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
MIME-Version: 1.0

On 23.03.2026 14:59:49, Johan Hovold wrote:
> On Mon, Mar 23, 2026 at 12:57:42PM +0100, Marc Kleine-Budde wrote:
> > On 23.03.2026 12:20:08, Johan Hovold wrote:
> > > On Mon, Mar 23, 2026 at 12:00:59PM +0100, Marc Kleine-Budde wrote:
> > > > On 23.03.2026 11:49:44, Johan Hovold wrote:
> > > > > The SPI subsystem frees the controller and any subsystem allocated
> > > > > driver data as part of deregistration (unless the allocation is d=
evice
> > > > > managed).
> > > > >
> > > > > Take another reference before deregistering the controller so tha=
t the
> > > > > driver data is not freed until the driver is done with it.
> > > >
> > > > Would re-ordering the spi_imx_remove() function be an alternative f=
ix?
> > > > I.e. call spi_unregister_controller() last?
> > >
> > > No, the controller needs to be deregistered before disabling clocks a=
nd
> > > releasing other resources.
> >
> > I see. So the API is a bit strange to use:
> >
> > Allocate with spi_alloc_host(), free with spi_controller_put() before
> > spi_register_controller(), the free with spi_unregister_controller()
> > afterwards.
> >
> > But spi_unregister_controller() shuts down the SPI interface _and_ frees
> > the memory. Which is the culprit here.
>
> Indeed, it's a known issue with the SPI API. See for example:
>
> 	68b892f1fdc4 ("spi: document odd controller reference handling")
> 	5e844cc37a5c ("spi: Introduce device-managed SPI controller allocation")
> 	f0c35a024cce ("spi: fix misleading controller deregistration kernel-doc")
>
> > Would using devm_spi_alloc_host() be an option here?
>
> It can also be used, but that's more intrusive so I did that as a
> follow-on cleanup to the fix (see patch 2/5).

Ah, nice! At the time I replied to the patch, the whole series was not
available on lore, yet.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

And thanks for taking the time in explaining me the details :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3bczsw4zpehoor7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacFSjwAKCRDMOmT6rpmt
0jH5AP4hVLzgh7/KCvS63tENtlYD/gBthypUPqjQU1yH9ekz8AD+ILG7/baVx/CU
a1jobkWC7TfT0gUTX6hEpNk1YdY0dgM=
=SyjM
-----END PGP SIGNATURE-----

--3bczsw4zpehoor7x--
