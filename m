Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE4399359
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267071; cv=none; b=HFWNyV4O/sVgPOYOxh3Z0Yu50C8H5UKv4RxZf5vEN4PTVgrKqFdGNCL1U186spXJskLUz6U73ec1u8UPPzyXl25Gv8SyMD460EqQ72em3mwr6vrftAjI8MM5fI3z9ezifpySF3j7zCXr8MP2blVfalsaAsIjRNXV4SIrAxiJJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267071; c=relaxed/simple;
	bh=0GEHw3O1Oq6BqaFe1Cdqj4TpK8O/uQhDjjVI6uLu1pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WL4Jj0IOCP4bR9h61XXD3oRB524nVFgUvVyz/IDGcUrF+8bh1PhXi8iFgkIzYTcZyqurn8n1oFyCmKRGLNk/BRMuEhYA0ardR0kPTQgx9oj+z8eStMU6SH1to00Ep4EgMeg7ww4ri3g7CwFao3HQFesggL74rnE/kT4aprbTcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4duh-0002kn-8c; Mon, 23 Mar 2026 12:57:43 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4dug-001igy-2d;
	Mon, 23 Mar 2026 12:57:42 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 785FF50A949;
	Mon, 23 Mar 2026 11:57:42 +0000 (UTC)
Date: Mon, 23 Mar 2026 12:57:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
Message-ID: <20260323-dangerous-brown-polecat-a4988f-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-2-johan@kernel.org>
 <20260323-demonic-worthy-guillemot-c2abb8-mkl@pengutronix.de>
 <acEh6KiKMfBehoZO@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oc3ekvkopuutzogv"
Content-Disposition: inline
In-Reply-To: <acEh6KiKMfBehoZO@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--oc3ekvkopuutzogv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
MIME-Version: 1.0

On 23.03.2026 12:20:08, Johan Hovold wrote:
> On Mon, Mar 23, 2026 at 12:00:59PM +0100, Marc Kleine-Budde wrote:
> > On 23.03.2026 11:49:44, Johan Hovold wrote:
> > > The SPI subsystem frees the controller and any subsystem allocated
> > > driver data as part of deregistration (unless the allocation is device
> > > managed).
> > >
> > > Take another reference before deregistering the controller so that the
> > > driver data is not freed until the driver is done with it.
> >
> > Would re-ordering the spi_imx_remove() function be an alternative fix?
> > I.e. call spi_unregister_controller() last?
>
> No, the controller needs to be deregistered before disabling clocks and
> releasing other resources.

I see. So the API is a bit strange to use:

Allocate with spi_alloc_host(), free with spi_controller_put() before
spi_register_controller(), the free with spi_unregister_controller()
afterwards.

But spi_unregister_controller() shuts down the SPI interface _and_ frees
the memory. Which is the culprit here.

Would using devm_spi_alloc_host() be an option here?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oc3ekvkopuutzogv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacEqswAKCRDMOmT6rpmt
0iRnAQDbf2ytPLs0BNfsXOUD4zDDeyHAMjvP4Ik56CAjrDLFdgEAmOygzR66Rk5V
7aGwLx7qtXaGDP6+haazZPB2gf/EMg0=
=e5n1
-----END PGP SIGNATURE-----

--oc3ekvkopuutzogv--
