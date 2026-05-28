Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF23AFCEB;
	Thu, 28 May 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959393; cv=none; b=C5aQ0gQP6KecnzFHrQM7tCVqo6NnIArc46Y0usxr484XiAC8+putviUkUFzLTzAXA9Ctf2DDg20e3SnO33rj4aqoQT1Z/dDjV9X1VauWQy0As+rnsLDG+DbRP7RsSmTD4lY/PtfyM8FOqGj0L+mdtvBuJweD/SiDuR/k7zqR3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959393; c=relaxed/simple;
	bh=zQP0c+jgi886i4XR5PYV8viZkX45ujM6jT1H8LAhalQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJvvIVQYrX1Zra/jX6j82LN8WHkOJnDZrX+cDhcdJR6nKw0uQDMO+L3re5C9xoszbg1hvcobgxevwvQHdHxdQJpNgnV1D8zd4oVdCJAMmaZy+oUkmdoCTHzhD0n8mGbwH9vm/fJwgRyHNzTd7RyuEGJHgfMIRZ8fv2W/HukZAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JbpICHl6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JbpICHl6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7A8DDC62445;
	Thu, 28 May 2026 09:09:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4EE8760495;
	Thu, 28 May 2026 09:09:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB12A10888CB6;
	Thu, 28 May 2026 11:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779959388; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BZ7YWBPJ73LaBuaYlU4y3harXsDdWT2FPUtyurIEQtI=;
	b=JbpICHl6Nv927vwgUexKS/+76lFTSRksmGdqfNyprlDOkbC/8IbCvnZbFusWMZeBVDhU6h
	Pnl7JPuEp2YEvkypY1BsE5qi+UO4KBck2P6tsi+PK6Y44xnf6VELH6dlg/s5QkENfYqH5d
	/FdLte0sUItMcL4g2AK6bTvx64RiH8FpUmyrZUzUgNmfpa3cJI1QJX3UFfYBnaoAm2w/Lx
	kbZqYUHct2NjQPXWP4DIlkUPUZaELr/6mjin88ag16WPr33VKAPBplIGJtVyDJD8Y/QnOQ
	/h8aeoUSa5GxIeZIuq9Ka9PJOiMVMi+jyZ3RJ5n8l/i85lCtD7pIbWJhu2SRag==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 10/13] spi: cadence-quadspi: enable PHY for direct
 reads and indirect writes
In-Reply-To: <20260527175527.2247679-11-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:25:24 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-11-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 11:09:44 +0200
Message-ID: <87se7bgasn.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 27/05/2026 at 23:25:24 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> After PHY tuning completes, data transfers still use the default
> read-capture path. The PHY pipeline must be activated around each
> eligible transfer to benefit from the calibrated delay settings.
>
> Add cqspi_phy_enable() to toggle PHY mode. Enabling sets the calibrated
> read-capture delay, asserts PHY_EN and PHY_PIPELINE, and decrements the
> dummy cycle count by one since the PHY pipeline absorbs that latency.
> Disabling reverses all three. Returns cqspi_wait_idle() so callers can
> abort if the controller stalls on enable; disable is best-effort.
>
> Split cqspi_direct_read_execute() so PHY-eligible reads run DMA over the
> 16-byte-aligned middle section with PHY active, while unaligned head and
> tail bytes are transferred without PHY. PHY is used when use_phy is set,
> the transfer exceeds 16 bytes, and the frequency matches the tuned rate.
> cqspi_memcpy_fromio() handles small and non-DMA-able transfers, with
> special handling for 8D-8D-8D to ensure 2-byte-aligned I/O accesses.
>
> For indirect writes, PHY is enabled for transfers of at least 1 KB

kiB :-)

> where the setup overhead is amortized.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 181 ++++++++++++++++++++++++++++--
>  1 file changed, 171 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-=
quadspi.c
> index 72208d376305..80e7c572ab80 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -564,6 +564,61 @@ static void cqspi_readdata_capture(struct cqspi_st *=
cqspi, const bool bypass,
>  	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
>  }
>=20=20
> +static int cqspi_phy_enable(struct cqspi_flash_pdata *f_pdata, bool
> enable)

I'm fine with the logic, just the naming is very "TI" specific here. Can
we name the helper "cqspi_tune_phy(f_pdata, enable)"?

[...]

>  static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
>  {
>  	void __iomem *reg_base =3D cqspi->iobase;
> @@ -1191,6 +1246,7 @@ static int cqspi_indirect_write_execute(struct cqsp=
i_flash_pdata *f_pdata,
>  	void __iomem *reg_base =3D cqspi->iobase;
>  	unsigned int remaining =3D n_tx;
>  	unsigned int write_bytes;
> +	bool use_phy_write;
>  	int ret;
>=20=20
>  	if (!refcount_read(&cqspi->refcount))
> @@ -1226,6 +1282,15 @@ static int cqspi_indirect_write_execute(struct cqs=
pi_flash_pdata *f_pdata,
>  	if (cqspi->apb_ahb_hazard)
>  		readl(reg_base + CQSPI_REG_INDIRECTWR);
>=20=20
> +	/* Use PHY only for large writes where setup overhead is amortized */
> +	use_phy_write =3D n_tx >=3D SZ_1K && f_pdata->use_phy;

Maybe also "f_pdata->use_tuned_phy?

> +	if (use_phy_write) {
> +		ret =3D cqspi_phy_enable(f_pdata, true);
> +		if (ret)
> +			goto failwr;
> +	}
> +
>  	while (remaining > 0) {
>  		size_t write_words, mod_bytes;
>=20=20
> @@ -1266,6 +1331,9 @@ static int cqspi_indirect_write_execute(struct cqsp=
i_flash_pdata *f_pdata,
>  		goto failwr;
>  	}
>=20=20
> +	if (use_phy_write)
> +		cqspi_phy_enable(f_pdata, false);
> +
>  	/* Disable interrupt. */
>  	writel(0, reg_base + CQSPI_REG_IRQMASK);
>=20=20
> @@ -1277,6 +1345,9 @@ static int cqspi_indirect_write_execute(struct cqsp=
i_flash_pdata *f_pdata,
>  	return 0;
>=20=20
>  failwr:
> +	if (use_phy_write)
> +		cqspi_phy_enable(f_pdata, false);
> +
>  	/* Disable interrupt. */
>  	writel(0, reg_base + CQSPI_REG_IRQMASK);
>=20=20
> @@ -1448,8 +1519,15 @@ static void cqspi_rx_dma_callback(void *param)
>  	complete(&cqspi->rx_dma_complete);
>  }
>=20=20
> -static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
> -				     u_char *buf, loff_t from, size_t len)
> +static bool cqspi_use_phy(struct cqspi_flash_pdata *f_pdata,
> +			  const struct spi_mem_op *op)
> +{
> +	return f_pdata->use_phy && op->data.nbytes > 16 &&

Why is the check looking for 16 here, and 1kiB above?

> +	       op->max_freq =3D=3D f_pdata->max_clk_rate;
> +}
> +
> +static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_ch=
ar *buf,
> +				 loff_t from, size_t len)
>  {
>  	struct cqspi_st *cqspi =3D f_pdata->cqspi;
>  	struct device *dev =3D &cqspi->pdev->dev;
> @@ -1461,19 +1539,14 @@ static int cqspi_direct_read_execute(struct cqspi=
_flash_pdata *f_pdata,
>  	dma_addr_t dma_dst;
>  	struct device *ddev;
>=20=20
> -	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
> -		memcpy_fromio(buf, cqspi->ahb_base + from, len);
> -		return 0;
> -	}

This (and changes below) don't seem to be directly related to the PHY
addition, could we have those changes done in a separated patch, before
introducing PHY tuning use?

> -
>  	ddev =3D cqspi->rx_chan->device->dev;
>  	dma_dst =3D dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
>  	if (dma_mapping_error(ddev, dma_dst)) {
>  		dev_err(dev, "dma mapping failed\n");
>  		return -ENOMEM;
>  	}
> -	tx =3D dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src,
> -				       len, flags);
> +	tx =3D dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src, len,
> +				       flags);

Not related to the change, isn't it?

>  	if (!tx) {
>  		dev_err(dev, "device_prep_dma_memcpy error\n");
>  		ret =3D -EIO;
> @@ -1507,6 +1580,94 @@ static int cqspi_direct_read_execute(struct cqspi_=
flash_pdata *f_pdata,
>  	return ret;
>  }
>=20=20

[...]

>  static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
>  			  const struct spi_mem_op *op)
>  {
> @@ -1524,7 +1685,7 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata =
*f_pdata,
>=20=20
>  	if ((cqspi->use_direct_mode && ((from + len) <=3D cqspi->ahb_size)) ||
>  	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
> -		return cqspi_direct_read_execute(f_pdata, buf, from, len);
> +		return cqspi_direct_read_execute(f_pdata, op);

This change could also be done in a different commit.

>=20=20
>  	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
>  	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) =3D=3D 0))

Thanks,
Miqu=C3=A8l
