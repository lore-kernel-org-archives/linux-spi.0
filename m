Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2740BCDA;
	Thu, 24 Sep 2026 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244476; cv=none; b=Qr/bf13DZGhUBsCAwUkeSksHfkHDU2zd0PJrq7eiTkXdBD18qj8ni+4lKL2YQDNdyEcRsrZn/P8S5ZtjoSgRsKTPk1LcsI8X2lS2sTSiZhX3lORzM/9AOqa3kKeXQBPiNjbl51dqULCeQILGWTRovkEQdrjKpChUu0tZ8pCiSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244476; c=relaxed/simple;
	bh=8JvwrieSguXCPZtU7OI6cAyL16PbOL4YUvLwGEC48G0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Vfk6GAxyZLvoBBImmsDr4jZqL9Txeyi34UnyX9263fe4g7jQ5Pk3rV60GVmoQs4Ij0TfJF8peKcym9w1W8dUmyXhSFM3/uizEpXhFFUeriKRQkDQxhxGdhmsSBPpZHgr9acuoEEwplRTW08onzRPotlNH72Bd4uYt96wR4pHWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=GOKVsOjn; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="GOKVsOjn"
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 1C4282C9;
	Thu, 24 Sep 2026 12:07:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1790244454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0EErLq3sMzuJYoFXE6V3970B7/j9JzXaV0n1ty6ddI=;
	b=GOKVsOjn6Pvxn5u39cuXn+/nAIpc9ljcWltO80iPGNEJsOThDO2o0r+IkHQIB1ROnM8wvD
	yrLldPVTC6VSVsEsXwGXLRQFT01K8qSvTqJg7XjTNU5RehY65HkaW5hMp45YUHP17KvY1/
	E02Jr5KW7GUlRAz8kUtOjzLcMhOC6tz2wvPPrWqsooFD1QJkJOMJzgDIDkFIe9x2fl1psu
	wHJrEpkIV4WKWEzXCDSYl5Zv+PgPTo07AxG6ll6Hqtk/25zdGp3JD1yqVWofmjjO3ZhC8r
	9aY0YPjB282SXMVYQuAJ6mWNsA+DZYc8KuMFxzAZFS2CykzepT6zHuhTyJTOhw==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=0d7cb4d557e05dd47fa38394d5771c8becb400c5916a7003912143d41284;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 24 Sep 2026 12:07:31 +0200
Message-Id: <DLNGOZHD5KI6.26QUK1IZB7UJY@walle.cc>
Subject: Re: [PATCH v2 2/3] spi: spi-nxp-fspi: enter stop mode before
 reconfiguring MCR0 and DLL
Cc: <linux-spi@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Haibo Chen" <haibo.chen@nxp.com>
From: "Michael Walle" <michael@walle.cc>
To: <haibo.chen@oss.nxp.com>, "Han Xu" <han.xu@nxp.com>, "Yogesh Gaur"
 <yogeshgaur.83@gmail.com>, "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
 <20260728-fspi-clock-v2-2-dbe786a4a6eb@nxp.com>
In-Reply-To: <20260728-fspi-clock-v2-2-dbe786a4a6eb@nxp.com>

--0d7cb4d557e05dd47fa38394d5771c8becb400c5916a7003912143d41284
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 28, 2026 at 12:18 PM CEST, haibo.chen wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> In nxp_fspi_select_mem() the RX sample clock source (MCR0[RXCLKSRC])
> and the DLL control registers (DLLxCR) are reconfigured while the
> FlexSPI module is still enabled. According to the FlexSPI reference
> manual initialization sequence, MCR0 and the DLL control registers
> should be programmed while the module is in stop mode, i.e. with
> MCR0[MDIS] set to 1, and the module re-enabled (MCR0[MDIS] =3D 0)
> afterwards.
>
> Wrap the RX sample clock source selection and the DLL calibration/
> override reconfiguration in a stop-mode window to align with the RM
> and avoid reconfiguring timing-critical registers while the module is
> active.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

This will actually cause the following error on an i.MX 95 19x19 EVK
(imx95-19x19-evk.dts):

  nxp-fspi 425e0000.spi: DLL lock failed, please fix it!

Any ideas what causes this? I'm running the latest linux-next
kernel.

-michael

> ---
>  drivers/spi/spi-nxp-fspi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 6de6d432cdcb2ee383a02d72f20000045903e176..a426b8d92193a4e303f411cd1=
7c16cb31c3f3873 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -867,6 +867,7 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, s=
truct spi_device *spi,
>  	unsigned long rate =3D op->max_freq;
>  	int ret;
>  	uint64_t size_kb;
> +	u32 reg;
> =20
>  	/*
>  	 * Return when following condition all meet,
> @@ -896,6 +897,15 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, =
struct spi_device *spi,
> =20
>  	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(=
spi, 0));
> =20
> +	/*
> +	 * Per the FlexSPI reference manual (initialization sequence), MCR0 and
> +	 * the DLL control registers should be configured while the module is i=
n
> +	 * stop mode (MCR0[MDIS] =3D 1). Enter stop mode before reconfiguring t=
he
> +	 * RX sample clock source and the DLL, then exit stop mode afterwards.
> +	 */
> +	reg =3D fspi_readl(f, f->iobase + FSPI_MCR0);
> +	fspi_writel(f, reg | FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
> +
>  	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
>  	rate =3D min(f->max_rate, op->max_freq);
> =20
> @@ -928,6 +938,10 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, =
struct spi_device *spi,
>  	else
>  		nxp_fspi_dll_override(f);
> =20
> +	/* Exit stop mode now that MCR0 and the DLL have been reconfigured. */
> +	reg =3D fspi_readl(f, f->iobase + FSPI_MCR0);
> +	fspi_writel(f, reg & ~FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
> +
>  	f->pre_op_rate =3D op->max_freq;
> =20
>  	f->selected =3D spi_get_chipselect(spi, 0);


--0d7cb4d557e05dd47fa38394d5771c8becb400c5916a7003912143d41284
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCarT2ZBEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+I1DAYDgQn7Pr5KtAX2vXKAD3RkFpvSvC9mQaqMV
zC4Q7HsSu7+z8niOd7Yl8eLUMEwFWZoBf3pfPpomxj7kHKbpgp6UdOmHnEsJxDHJ
qT7pb9ChKagSC3LezJF1ounEOM9SCu/a/Q==
=14J4
-----END PGP SIGNATURE-----

--0d7cb4d557e05dd47fa38394d5771c8becb400c5916a7003912143d41284--
