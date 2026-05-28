Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE602389E05;
	Thu, 28 May 2026 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958508; cv=none; b=DCbyvEWqH/aGCbgxpTcORvUy93bEGZlhlf7rQyxzXAVwO9nYPfBhbbCeFrid2mtA+oWtl3Xkgf07HXyoR+siYAAPSo7lkfEWfsdvX2DGFRPaedeo5WtObPBLVKGtcQj8YN8wbL8DhiIY7Mp8OJR4p2+ZvWBLzY9KAmQQiGljkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958508; c=relaxed/simple;
	bh=Ugo6u4SyugBnQM5lEoIXKmIhUXIcvCin4jcxhvCcREY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jz9cu0bBC84yCBViq/R3Sz0mgw+SREwKymcR8ALPDpK+N0RMWlgrrkqwbyQWQaL6ohJ9tQYGrmqJ3ASNs3yWUbZ4Ka+D1ldkuWWfQDKJ6xkY74k9x156XncPlJH1eoGlvO27TS8Jkv+8lrsYD6V4g4TRxebVCa4UtihZ1GWfL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tewPilAf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tewPilAf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5FFAEC62445;
	Thu, 28 May 2026 08:55:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D40060495;
	Thu, 28 May 2026 08:55:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F6631088877F;
	Thu, 28 May 2026 10:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779958502; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mms8zVeKVl4m3zXRZxt6cX5JkM7V/uTQ+FCIhnWPTuw=;
	b=tewPilAf9ErtzNRl134ztaKZBbhMd+BtcE9t7Nz1h6+7C3DIYKS4DtVVrP3WCJh+Nq5aMX
	mh3W+V6DCpel514WkiYhPuKb2uquo40VTYRC5UPGMuZuGBnVIVvVR/Rb6Us6nB4vNshfP/
	nbACcBMdiYT3FDAf0sZS0h9JBGnQG2n6Kt6VXwRBlb9A2msSHUR+Ikd3mCcBvOD5JPYzj5
	MRGBEAMuDd75Lrhxo/ImM4r/Gji1OAD+DSlQY++ncaPsAAAJwNPMIpB1A9XazJAhozmvbc
	za8xfmesB+NbJ9uydXwwezYFnH2UeicFHQcoXegtu6Y1ZxeHVrQucCx0humGlQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 08/13] spi: cadence-quadspi: add PHY tuning support
In-Reply-To: <20260527175527.2247679-9-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:25:22 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-9-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 10:54:58 +0200
Message-ID: <874ijrhq1p.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 27/05/2026 at 23:25:22 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> The Cadence QSPI controller supports a delay-line PHY for high-speed
> operation. Without calibration the PHY is unused and read capture relies
> on a fixed delay, limiting throughput at frequencies above the base
> operating speed.
>
> Add an execute_tuning callback that performs delay-line calibration using
> a known data pattern written to a dedicated flash region. The pattern is
> either read from a NOR partition identified by the DT property
> cdns,phy-pattern-partition, or written to the NAND page cache before
> each calibration read.
>
> For DDR protocols (8D-8D-8D) a 2D sweep of (rx_delay, tx_delay) pairs
> is performed to find the widest passing region in the combined RX/TX
> space. Binary search locates the gap boundary between passing regions
> when two separate windows exist; the final operating point is placed at
> the centre of the larger region with a small temperature-dependent
> offset.
>
> For SDR protocols a 1D sweep of the RX delay is sufficient. Two windows
> at adjacent read_delay values are measured; the wider one's midpoint is
> selected.
>
> The tuning infrastructure is platform-specific: only am654-based OSPI
> controllers populate the execute_tuning hook. All other platform data
> entries return -EOPNOTSUPP and are unaffected.
>
> spi-max-frequency may carry two values in DT; the second (higher) value
> is the tuned target rate stored in max_clk_rate. When only one value is
> present max_clk_rate is zero and tuning is skipped.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---

There are more than 1800 new lines for the PHY tuning procedure. I left
that decision to Mark of course, by maybe we should move that into
another .c file.

> +static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
> +					   struct spi_mem_op *read_op,
> +					   struct spi_mem_op *write_op)
> +{
> +	struct cqspi_st *cqspi =3D
> +		spi_controller_get_devdata(mem->spi->controller);
> +	struct cqspi_flash_pdata *f_pdata;
> +	struct device *dev =3D &cqspi->pdev->dev;
> +	u32 base_speed;
> +	u32 phy_offset =3D 0;
> +	int ret;
> +
> +	f_pdata =3D &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
> +
> +	/*
> +	 * A second spi-max-frequency value (the higher clock rate) must be
> +	 * present for tiered speed support.  Without it there is nothing to
> +	 * calibrate towards, so skip tuning gracefully.
> +	 */
> +	if (!f_pdata->max_clk_rate) {
> +		dev_dbg(dev, "No higher clock rate configured, skipping tuning\n");
> +		return 0;
> +	}
> +
> +	base_speed =3D mem->spi->base_speed_hz;
> +
> +	if (write_op) {
> +		/*
> +		 * For NAND: write the calibration pattern to the page cache.
> +		 * This uses write_op at the safe base speed (base_speed_hz is
> +		 * still active) so the write itself is reliable.
> +		 */
> +		ret =3D cqspi_write_pattern_to_cache(f_pdata, mem, write_op);
> +		if (ret) {
> +			dev_warn(dev,
> +				 "failed to write pattern to cache: %d, skipping tuning\n",
> +				 ret);
> +			goto out;
> +		}
> +
> +		f_pdata->phy_write_op =3D *write_op;
> +	} else {
> +		ret =3D cqspi_get_phy_pattern_offset(dev, &phy_offset);
> +		if (ret) {
> +			dev_warn(dev,
> +				 "pattern partition not found: %d, skipping tuning\n",
> +				 ret);
> +			goto out;
> +		}
> +
> +		read_op->addr.val =3D phy_offset;
> +	}
> +
> +	/*
> +	 * Verify the calibration pattern exists using the conservative base
> +	 * speed.  At high clock rates the DLL is not yet trained, so DTR
> +	 * data capture is unreliable and the read would return garbage.
> +	 * Setting max_freq to 0 here causes apply_base_freq_cap() to cap the
> +	 * read to base_speed_hz, which is well within reliable DTR margins.
> +	 * max_freq is restored to max_speed_hz for the tuning-loop reads
> +	 * after base_speed_hz is cleared below.
> +	 */
> +	f_pdata->phy_read_op =3D *read_op;
> +	f_pdata->phy_read_op.max_freq =3D 0;
> +
> +	ret =3D cqspi_phy_check_pattern(f_pdata, mem);
> +	if (ret) {
> +		dev_err(dev, "pattern not found: %d, skipping tuning\n", ret);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Pattern confirmed.  Now clear base_speed_hz so that tuning-loop
> +	 * exec_op calls run at max_speed_hz, and restore phy_read_op.max_freq
> +	 * so those reads also use the full speed.
> +	 */
> +	mem->spi->base_speed_hz =3D 0;

If there is a way to avoid touching the core parameters, I would be for
using it, but maybe it is simpler to do it this way.

> +	f_pdata->phy_read_op.max_freq =3D mem->spi->max_speed_hz;
> +
> +	if (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
> +	    read_op->data.dtr) {
> +		f_pdata->use_dqs =3D true;
> +		cqspi_phy_pre_config(cqspi, f_pdata, false);
> +		ret =3D cqspi_phy_tuning_ddr(f_pdata, mem);
> +	} else {
> +		f_pdata->use_dqs =3D false;
> +		cqspi_phy_pre_config(cqspi, f_pdata, true);
> +		ret =3D cqspi_phy_tuning_sdr(f_pdata, mem);
> +	}
> +
> +	if (ret)
> +		dev_warn(dev, "tuning failed: %d\n", ret);
> +
> +	cqspi_phy_post_config(cqspi, f_pdata->read_delay);
> +
> +out:
> +	/*
> +	 * Always restore the conservative base speed cap.  On success, write
> +	 * back the validated maximum speed into the caller's op templates so
> +	 * that those specific ops bypass the cap in subsequent exec_op calls.
> +	 */
> +	mem->spi->base_speed_hz =3D base_speed;
> +	if (!ret) {
> +		read_op->max_freq =3D mem->spi->max_speed_hz;
> +		if (write_op)
> +			write_op->max_freq =3D mem->spi->max_speed_hz;
> +	}

Neat.

> +
> +	return ret;
> +}
> +
> +static int cqspi_mem_op_execute_tuning(struct spi_mem *mem,
> +				       struct spi_mem_op *read_op,
> +				       struct spi_mem_op *write_op)
> +{
> +	struct cqspi_st *cqspi =3D
> +		spi_controller_get_devdata(mem->spi->controller);
> +
> +	if (!cqspi->ddata->execute_tuning)
> +		return -EOPNOTSUPP;
> +
> +	return cqspi->ddata->execute_tuning(mem, read_op, write_op);
> +}
> +
>  static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
>  				    struct cqspi_flash_pdata *f_pdata,
>  				    struct device_node *np)
>  {
> +	int nfreq, ret;
> +
>  	if (of_property_read_u32(np, "cdns,read-delay", &f_pdata->read_delay)) {
>  		dev_err(&pdev->dev, "couldn't determine read-delay\n");
>  		return -ENXIO;
> @@ -1584,7 +3343,26 @@ static int cqspi_of_get_flash_pdata(struct platfor=
m_device *pdev,
>  		return -ENXIO;
>  	}
>=20=20
> -	if (of_property_read_u32(np, "spi-max-frequency", &f_pdata->clk_rate)) {
> +	/*
> +	 * spi-max-frequency accepts one or two values:
> +	 *   <max-freq>             - single rate; no tiered speed support
> +	 *   <base-freq max-freq>   - conservative default and higher maximum
> +	 *
> +	 * With two values the SPI core sets spi->base_speed_hz =3D base-freq a=
nd
> +	 * spi->max_speed_hz =3D max-freq.  Store the second value here as the
> +	 * controller's higher rate target for calibration.
> +	 */
> +	nfreq =3D of_property_count_u32_elems(np, "spi-max-frequency");
> +	if (nfreq =3D=3D 2) {
> +		ret =3D of_property_read_u32_index(np, "spi-max-frequency", 1,
> +						 &f_pdata->max_clk_rate);
> +		if (ret) {
> +			dev_err(&pdev->dev, "couldn't read spi-max-frequency[1]\n");
> +			return ret;
> +		}
> +	} else if (nfreq =3D=3D 1) {
> +		f_pdata->max_clk_rate =3D 0;
> +	} else {
>  		dev_err(&pdev->dev, "couldn't determine spi-max-frequency\n");
>  		return -ENXIO;
>  	}

Why do we repeat that operation in the driver? Can't we just use what
the core has already done for us? Seems like we are parsing the same
data twice (even before this patchset).

Thanks,
Miqu=C3=A8l
