Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794749446;
	b=Mm7vQ8G7zjGiixiDuS5ge8Vd8gu2dSljNXtECUr7ExVsD2z8sniMRnYxXtB+8+l7pMjK
	 1lc6mIru2gEsAj/a6uo80Vmn5SSsL/zwiyevGM/3SMCXuDVNrLyoFSQQBoRH5LSSsFEYT
	 67rRozlrqffmq2TBUndcu+jLEzTNA2gyApPZdJaQBVY6z37gTn3FSb1W+wgi9qvSHUCOo
	 OVT24j/vnOJ/o/fL66qoD2RSMYjjjN5zc995u+a97DwQg+TzDs1YUT8Z9+KH0CB0ine1N
	 L6Y6KkPRio3JPdGoHFh983UEffUcAGU3xsgetqJy7K5a+jEaoBX4kdE15jV17nBGUWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794749446;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BFJvKVhH5INfNQgu/CQEYJJqodEEEvt0XMiAlZaDCO8=;
	b=D4bNT89/4cE8vXyK/aTQStFxqdpMncR2VN4b+yq8ogvboljdvVsXTH8WsORurY4FZRQx
	 cZfEkwLDRk/FFyiTUc4R0i/gLE75mBjR2a7m27Kl2jCKaXHxG9mY3teUaLpBg95iUTMnk
	 BVk2HkslfzMnUJ4QFWtXtXwtrQU4ltbnvpi93Ej3bKCGT1qJrgcHLPj/w07yGmexYRiaT
	 wOMREstB9W4DUNewxrToij55hxOYcquMTR1OQ+RUzmMSV/Iy7UlrkD/3N6c69L0o2iuOi
	 SPvCKPHDIOsDJhp+mQECCH6aRqWaWn7cJJih6ASsds7Z068d/5VlAdnxSVK9E67ZwhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=biO4OCoT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6D606A31D;
	Sun, 15 Nov 2026 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=biO4OCoT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28411F000C4;
	Sun, 15 Nov 2026 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794749445;
	bh=BFJvKVhH5INfNQgu/CQEYJJqodEEEvt0XMiAlZaDCO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=biO4OCoT9LK26HFXawWMg47PKjOOhQ5lxWOn54+c57WmYerA/vMo8s0/Lg5iNYRtv
	 xcK69kSqZJhOvmlEIE4rZgCsi7VO6RLU7h088yTrlTQ07V/YXANYaycrb89nO4YwkL
	 p34tVDjyD1rVQiFwB30bHusvCUpZ+JuDPJ/frXBhKtMjtXWbcLHc88Xt5/tnb9+UEQ
	 CRjPURYSob1TXUgmPyruC88XMfAX35fXj2ETOeRvqRqojpUE7OKVU78VZyQEuOiFcp
	 DtxB+UjDBwDe5v6hJeNdNNIKwdStzJIvEjpgO9paba/tU2UaFa08FU7KwGWAK6aQcs
	 1miF+YJuZ/9/Q==
Date: Sun, 15 Nov 2026 21:10:23 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: PaulCercueil <paul.cercueil@bootlin.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	George Cherian <gcherian@marvell.com>
Subject: Re: [PATCH v3 6/6] spi: cadence-xspi: Add workaround for old Marvell
 firmwares
Message-ID: <avmvP5EQqMV_FKqI@xhacker>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112143050.53347-7-paul.cercueil@bootlin.com>

On Thu, Nov 12, 2026 at 03:30:50PM +0100, Paul Cercueil wrote:
> From: Tanmay Jagdale <tanmay@marvell.com>
> 
> Older firmwares from Marvell used the cdns,xspi-nor compatible string
> for the Marvell-specific xSPI IP, which is incompatible.
> 
> Add a workaround to support this case, checking for a Marvell board in
> the DTB or the ACPI tables.

+ DT maintainers,

I want to query a rule here: does mainlined driver need to care
about out-of-tree dtb bug?

> 
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
> Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
> 
> ---
> 
> v2: Replace the workaround based on the presence of the "xfer" resource
>     with a mechanism that identifies a Marvell SoC based on the board's
>     compatible string on DTB, and the DSDT table on ACPI.
> 
> v3: Wrap ACPI specific code with CONFIG_ACPI guards, as some of the
>     functions and structs aren't defined without CONFIG_ACPI.
> ---
>  drivers/spi/spi-cadence-xspi.c | 41 +++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
> index 8fa58a0412e3..7b06b95af794 100644
> --- a/drivers/spi/spi-cadence-xspi.c
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -2,6 +2,7 @@
>  // Cadence XSPI flash controller driver
>  // Copyright (C) 2020-21 Cadence
>  
> +#include <linux/acpi.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -11,11 +12,13 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
> +#include <linux/string.h>
>  #include <linux/bitfield.h>
>  #include <linux/limits.h>
>  #include <linux/log2.h>
> @@ -775,7 +778,6 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
>  		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
>  }
>  
> -#ifdef CONFIG_64BIT
>  static struct cdns_xspi_driver_data marvell_driver_data = {
>  	.mrvl_hw_overlay = true,
>  	.dll_phy_ctrl = MARVELL_REGS_DLL_PHY_CTRL,
> @@ -788,6 +790,7 @@ static struct cdns_xspi_driver_data marvell_driver_data = {
>  	.rfile_phy_dll_slave_ctrl = MARVELL_RFILE_PHY_DLL_SLAVE_CTRL,
>  };
>  
> +#ifdef CONFIG_64BIT
>  static const int cdns_mrvl_xspi_clk_div_list[] = {
>  	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
>  	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
> @@ -1228,6 +1231,33 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
>  }
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_platform_list mrvl_platform_list[] = {
> +	{
> +		.oem_id = "MRVL  ",
> +		.oem_table_id = "CN10K",
> +		.table = ACPI_SIG_DSDT,
> +		.pred = all_versions,
> +	},
> +	{ }
> +};
> +#endif
> +
> +static inline bool cdns_is_marvell(struct device *dev)
> +{
> +	const char *compatible;
> +
> +#ifdef CONFIG_ACPI
> +	if (has_acpi_companion(dev))
> +		return acpi_match_platform_list(mrvl_platform_list) >= 0;
> +#endif
> +
> +	if (of_machine_read_compatible(&compatible, 0) < 0)
> +		return false; /* shouldn't actually happen */
> +
> +	return strstarts(compatible, "marvell,");
> +}
> +
>  static int cdns_xspi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1249,6 +1279,15 @@ static int cdns_xspi_probe(struct platform_device *pdev)
>  	if (!cdns_xspi->driver_data)
>  		return -ENODEV;
>  
> +	if (IS_ENABLED(CONFIG_64BIT) &&
> +	    !cdns_xspi->driver_data->mrvl_hw_overlay &&
> +	    cdns_is_marvell(dev)) {
> +		/* Some old firmwares use the base compatible string... */
> +
> +		dev_warn(dev, "Using the cdns,xspi-nor compatible string on a Marvell SoC. Please fix firmware!\n");
> +		cdns_xspi->driver_data = &marvell_driver_data;
> +	}
> +
>  	host->mem_ops = &cadence_xspi_mem_ops;
>  	cdns_xspi->sdma_handler = &cdns_xspi_sdma_handle;
>  	cdns_xspi->set_interrupts_handler = &cdns_xspi_set_interrupts;
> -- 
> 2.47.3
> 
