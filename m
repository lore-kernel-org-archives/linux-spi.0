Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38994F55A5;
	Wed,  9 Sep 2026 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962101; cv=none; b=n4zkM1y9xgnGXIpNBqX1A/Lyuk67upX/P/114A1Eu2KyA2OPfDrw8twIMxev67xJsoOQGxL+fewTbBkR5RVUeFD8GRMGr15BV1G4lbjzscOUrTKGC8jEekFWl/kax/v4+02fdZjoirlalDfXB8UypykjbzcDbV5GrSgvnE+3hls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962101; c=relaxed/simple;
	bh=8igw4+GL904N8sIe6g1uPOL6GHbFNdVYipx8uF75oOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A+efPrjIUQdPd7jxEiIRA52ZM0fDhc6aBwsEHG73HmGMVgr1YzvXQAWeMt1ZFKlMULLN9bvNbjjqBq4qykgzz/TLVsd98tLCkahlz6Bb9nwwM5eb8w3orNpmOr0mj6q1kK0k5aq2jiBqCPdgBSJ3niS6NSC8pEUCp96/jEwKvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: eleanor.lin@realtek.com
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: robh@kernel.org
X-PTX-Original-Recipient: krzk+dt@kernel.org
X-PTX-Original-Recipient: conor+dt@kernel.org
X-PTX-Original-Recipient: james.tai@realtek.com
X-PTX-Original-Recipient: cy.huang@realtek.com
X-PTX-Original-Recipient: stanley_chang@realtek.com
X-PTX-Original-Recipient: jyanchou@realtek.com
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: devicetree@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B238C20590C;
	Wed, 09 Sep 2026 15:54:55 +0200 (CEST)
Message-ID: <c647c66bdb3d87157a5684b755c95123fe9ba198.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/2] spi: spi-mem: Add Realtek SPI NOR flash
 controller driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yu-Chun Lin <eleanor.lin@realtek.com>, broonie@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: james.tai@realtek.com, cy.huang@realtek.com, stanley_chang@realtek.com, 
	jyanchou@realtek.com, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 15:54:55 +0200
In-Reply-To: <20260909125701.273314-3-eleanor.lin@realtek.com>
References: <20260909125701.273314-1-eleanor.lin@realtek.com>
	 <20260909125701.273314-3-eleanor.lin@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mi, 2026-09-09 at 20:57 +0800, Yu-Chun Lin wrote:
> From: Jyan Chou <jyanchou@realtek.com>
>=20
> Add a spi-mem driver for the SPI NOR Flash Controller (SFC) found on Real=
tek
> DHC SoC. SFC supports Dual I/O.
>=20
> Implement the exec_op API for regular control commands and the dirmap API
> for hardware-accelerated read/write operations.
>=20
> The controller is described by three register ranges. The first one (ctrl=
)
> holds the control registers. The second one (dma) holds the DMA engine
> registers, used to transfer the payload between the flash and main memory=
.
> The third range is the memory aperture (dirmap) that maps the flash
> contents.
>=20
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> ---
> Changes since v2:
> - Add Yu-Chun's last name.
> - Specify "NOR" in the commit message and descriptions to avoid future
> conflicts with SPI NAND or GSPI.
> - Make SPDX license and copyright notice headers in C++-style.
> - Drop driver-internal polling (rtk_spi_read_status()), leaving the statu=
s
> polling and timeout handling to framework.
> - Track the 4-byte addressing state and properly restore it in rtk_spi_in=
it()
> to prevent state loss during runtime PM suspend/resume.
> - Add hardware cleanup in rtk_spi_dma_transfer() to explicitly trigger a
> graceful stop of the DMA engine if a timeout occurs.
> - Check bounds against the direct mapping window (dirmap_size) in both PI=
O and
> DMA transfer paths.
> - Add reset_control_assert() in the probe error path and .remove().
> - Replace RUNTIME_PM_OPS() + SYSTEM_SLEEP_PM_OPS() with
> DEFINE_RUNTIME_DEV_PM_OPS().
> ---
>  MAINTAINERS               |   6 +
>  drivers/spi/Kconfig       |  10 +
>  drivers/spi/Makefile      |   1 +
>  drivers/spi/spi-rtk-nor.c | 623 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 640 insertions(+)
>  create mode 100644 drivers/spi/spi-rtk-nor.c
>=20
[...]
> diff --git a/drivers/spi/spi-rtk-nor.c b/drivers/spi/spi-rtk-nor.c
> new file mode 100644
> index 000000000000..5ccfa234b6b1
> --- /dev/null
> +++ b/drivers/spi/spi-rtk-nor.c
> @@ -0,0 +1,623 @@
[...]
> +static int rtk_spi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct spi_controller *ctrl;
> +	struct rtk_spi_host *host;
> +	struct resource *res;
> +	int ret;
> +
> +	ctrl =3D devm_spi_alloc_host(dev, sizeof(*host));
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ctrl);
> +	host =3D spi_controller_get_devdata(ctrl);
> +	host->dev =3D dev;
> +
> +	host->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(host->clk))
> +		return PTR_ERR(host->clk);
> +
> +	ret =3D clk_prepare_enable(host->clk);
> +	if (ret)
> +		return ret;
> +
> +	host->rstc =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(host->rstc)) {
> +		ret =3D PTR_ERR(host->rstc);
> +		goto err_disable_clk;

If you moved clk_prepare_enable() below this, you could just return
here.

> +	}
> +
> +	reset_control_assert(host->rstc);
> +	usleep_range(10, 20);
> +	reset_control_deassert(host->rstc);
> +
> +	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(35));
> +	if (ret) {
> +		dev_err(dev, "Failed to set dma mask\n");
> +		goto err_disable_clk;

No reset_control_assert() in this error path?

> +	}
> +
> +	host->buffer =3D dmam_alloc_coherent(dev, SFC_DMA_MAX_LEN,
> +					   &host->dma_buffer, GFP_KERNEL);
> +	if (!host->buffer) {
> +		ret =3D -ENOMEM;
> +		goto err_disable_clk;
> +	}
> +
> +	host->regbase =3D devm_platform_ioremap_resource_byname(pdev, "ctrl");
> +	if (IS_ERR(host->regbase)) {
> +		ret =3D PTR_ERR(host->regbase);
> +		goto err_disable_clk;
> +	}
> +
> +	host->mdbase =3D devm_platform_ioremap_resource_byname(pdev, "dma");
> +	if (IS_ERR(host->mdbase)) {
> +		ret =3D PTR_ERR(host->mdbase);
> +		goto err_disable_clk;
> +	}
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
> +	host->iobase =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(host->iobase)) {
> +		ret =3D PTR_ERR(host->iobase);
> +		goto err_disable_clk;
> +	}

It looks to me like all these dmam_ and devm_ initialization calls
should be moved up before the clock enable and reset assert/deassert.

> +
> +	host->dirmap_size =3D resource_size(res);
> +	host->flash_phys_base =3D res->start;
> +	host->is_4byte =3D false;
> +
> +	ctrl->mode_bits =3D SPI_RX_DUAL | SPI_TX_DUAL;
> +	ctrl->bus_num =3D -1;
> +	ctrl->mem_ops =3D &rtk_spi_mem_ops;
> +	ctrl->num_chipselect =3D 1;
> +	ctrl->auto_runtime_pm =3D true;
> +
> +	rtk_spi_init(host);

This is the first call that actually needs clocks running and reset
triggered.

> +
> +	pm_runtime_set_autosuspend_delay(dev, SFC_AUTOSUSPEND_TIMEOUT);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_noresume(dev);
> +
> +	ret =3D spi_register_controller(ctrl);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register controller\n");
> +		goto err_pm_disable;
> +	}
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +
> +err_pm_disable:
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
> +	reset_control_assert(host->rstc);
> +
> +err_disable_clk:
> +	clk_disable_unprepare(host->clk);
> +
> +	return ret;
> +}
> +
> +static void rtk_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctrl =3D platform_get_drvdata(pdev);
> +	struct rtk_spi_host *host =3D spi_controller_get_devdata(ctrl);
> +	struct device *dev =3D &pdev->dev;
> +
> +	spi_unregister_controller(ctrl);
> +
> +	pm_runtime_get_sync(dev);
> +	pm_runtime_disable(dev);
> +	reset_control_assert(host->rstc);
> +	clk_disable_unprepare(host->clk);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(dev);

Why is this cleanup order different from the probe error path?


regards
Philipp
