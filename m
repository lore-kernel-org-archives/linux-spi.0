Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78083D5246
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365761; cv=none; b=Phg05K8cAoK/a9kFe3r+5nukYuXjg1SXhszWwYNgV9qye08+1wAcUgsD5sO+zIGhIJeX0WuRWrWostwFRj+WhmXgKXAX6oht+Fb4UJ8fR4A6P0vQZM2cbMs28fvynBmgFbYrwrkTSvcubtn6ON2MT9/u9h23wnq6F+K5/BrWxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365761; c=relaxed/simple;
	bh=BGkFIXiIvD+K/l3WKxKkXmi9Xyn1mL0A2qYi7914rzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWItboVLWvcE9BnkU2WWpJVZywO78HmxfP6rki44AE2k3W1fwikdTP3V6lcP+4zJfMuubR9URWnpCXbBdgtKolsi0lEO2S2Esmq9cyxDbXoMq5G81I8qLMnOMnMnyM8IpmreJfcpjdbqmOi3Fw5MPTVXmqLaAmiU3jFTS+wdMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w53aR-0005Zr-FD; Tue, 24 Mar 2026 16:22:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w53aR-001uwx-0U;
	Tue, 24 Mar 2026 16:22:31 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CF8D250BC05;
	Tue, 24 Mar 2026 15:22:30 +0000 (UTC)
Date: Tue, 24 Mar 2026 16:22:30 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, Gao Pan <pandy.gao@nxp.com>, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	kernel@pengutronix.de
Subject: Re: [PATCH spi] spi: spi-fsl-lpspi: fix teardown order issue (UAF)
Message-ID: <20260324-wooden-rattlesnake-from-avalon-2bc1ed-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260319-spi-fsl-lpspi-fixes-v1-1-b433e435b2d8@pengutronix.de>
 <acKoJ3Ca_q40baDS@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2kwmzrjaosdhal7o"
Content-Disposition: inline
In-Reply-To: <acKoJ3Ca_q40baDS@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--2kwmzrjaosdhal7o
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH spi] spi: spi-fsl-lpspi: fix teardown order issue (UAF)
MIME-Version: 1.0

On 24.03.2026 11:05:11, Frank Li wrote:
> On Thu, Mar 19, 2026 at 07:38:12PM +0100, Marc Kleine-Budde wrote:
> > There is a teardown order issue in the driver. The SPI controller is
> > registered using devm_spi_register_controller(), which delays
> > unregistration of the SPI controller until after the fsl_lpspi_remove()
> > function returns.
> >
> > As the fsl_lpspi_remove() function synchronously tears down the DMA
> > channels, a running SPI transfer triggers the following NULL pointer
> > dereference due to use after free:
> >
> > | fsl_lpspi 42550000.spi: I/O Error in DMA RX
> > | Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000000
> > [...]
> > | Call trace:
> > |  fsl_lpspi_dma_transfer+0x260/0x340 [spi_fsl_lpspi]
> > |  fsl_lpspi_transfer_one+0x198/0x448 [spi_fsl_lpspi]
> > |  spi_transfer_one_message+0x49c/0x7c8
> > |  __spi_pump_transfer_message+0x120/0x420
> > |  __spi_sync+0x2c4/0x520
> > |  spi_sync+0x34/0x60
> > |  spidev_message+0x20c/0x378 [spidev]
> > |  spidev_ioctl+0x398/0x750 [spidev]
> > [...]
> >
> > Switch from devm_spi_register_controller() to spi_register_controller()=
 in
> > fsl_lpspi_probe() and add the corresponding spi_unregister_controller()=
 in
> > fsl_lpspi_remove().
>
> Feel like it is not correct's fix. devm_spi_register_controller() is quite
> common, other SPI controller should have similar problem.

Have a look at the remove function:

| static void fsl_lpspi_remove(struct platform_device *pdev)
| {
| 	struct spi_controller *controller =3D platform_get_drvdata(pdev);
| 	struct fsl_lpspi_data *fsl_lpspi =3D
| 				spi_controller_get_devdata(controller);
|
| 	fsl_lpspi_dma_exit(controller);

It first cleans up the DMA support, but the controller is still
registered. In my use case the /dev/spiX.Y is still active and my test
program can still issue a SPI transfer.

|
| 	pm_runtime_dont_use_autosuspend(fsl_lpspi->dev);
| 	pm_runtime_disable(fsl_lpspi->dev);
| }

The patch unregisters the SPI controller prior the tearing down thee DMA
support.

Another options would be to push everything in the fsl_lpspi_remove() to
devm, too.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2kwmzrjaosdhal7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacKsNAAKCRDMOmT6rpmt
0lZfAQD5cdXo1b7EWWiEGcnWDFftMO+2gru9hEL343hxQLdQigEA3ppGEj7M4FZ6
kUOHzyBE69k/16qSeu23OBeVU8rquwM=
=InsU
-----END PGP SIGNATURE-----

--2kwmzrjaosdhal7o--
