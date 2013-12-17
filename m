From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 7/7] mtd: spi-nor: Add Freescale QuadSpi driver
Date: Tue, 17 Dec 2013 14:16:18 +0100
Message-ID: <201312171416.18560.marex@denx.de>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com> <1387184330-14448-8-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
	angus.clark@st.com, lee.jones@linaro.org, pekon@ti.com,
	sourav.poddar@ti.com, broonie@linaro.org,
	linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	b44548@freescale.com, b18965@freescale.com, shawn.guo@linaro.org
To: Huang Shijie <b32955@freescale.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1387184330-14448-8-git-send-email-b32955@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday, December 16, 2013 at 09:58:50 AM, Huang Shijie wrote:
[...]

> +/* Macros for constructing the LUT register. */
> +#define LUT0(ins, pad, opr)						\
> +		(((opr) << OPRND0_SHIFT) | ((LUT_##pad) << PAD0_SHIFT) | \
> +		((LUT_##ins) << INSTR0_SHIFT))
> +
> +#define LUT1(ins, pad, opr)	(LUT0(ins, pad, opr) << OPRND1_SHIFT)

Change this into an inline function, that way you'd get type-checking here.

[...]

> +enum fsl_qspi_devtype {
> +	FSL_QUADSPI_VYBRID,
> +	FSL_QUADSPI_IMX6SLX

Will the SLX be only a single-core chip?

> +};
> +
> +struct fsl_qspi_devtype_data {
> +	enum fsl_qspi_devtype devtype;
> +	u32 memmap_base;
> +	int rxfifo;
> +	int txfifo;
> +};
> +
> +static struct fsl_qspi_devtype_data vybrid_data = {
> +	.devtype = FSL_QUADSPI_VYBRID,
> +	.memmap_base = 0x20000000,

This memmap_base should come from DT prop.

> +	.rxfifo = 128,
> +	.txfifo = 64

Ditto for both of these too. They're HW props.

> +};
[...]

Best regards,
Marek Vasut
