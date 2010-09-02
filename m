From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/6] spi-imx: add CSPI and eCSPI support for i.MX51 MCU
Date: Thu, 2 Sep 2010 16:53:57 +0200
Message-ID: <20100902145357.GL14214@pengutronix.de>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net,
	s.hauer@pengutronix.de, amit.kucheria@canonical.com,
	linux-arm-kernel@lists.infradead.org
To: Jason Wang <jason77.wang@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello Jason,

On Thu, Sep 02, 2010 at 03:51:59PM +0800, Jason Wang wrote:
> There are 3 SPI controllers on i.MX51, one is called CSPI and is
> 100% compatible with the one on i.MX35, the other two are called
> eCSPI and are not compatible with existing controllers on other
> i.MX platforms, here we add support of these three controllers in
> the imx spi driver.
> =

> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
> ---
>  drivers/spi/spi_imx.c |  135 +++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 files changed, 131 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 7972e90..8d9c9da 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -155,6 +155,120 @@ static unsigned int spi_imx_clkdiv_2(unsigned int f=
in,
>  	return 7;
>  }
>  =

> +/* MX51 eCSPI post divider */
> +static unsigned int spi_imx_clkdiv_3(unsigned int fin,
> +		unsigned int fspi)
> +{
> +	int i, div =3D 1;
> +
> +	for (i =3D 0; i < 15; i++) {
> +		if (fspi * div >=3D fin)
> +			return i;
> +		div <<=3D 1;
> +	}
> +
> +	return 15;
> +}
This is different in Sascha's patch.  Didn't try yet to understand the
difference.

> +
> +#define MX51_INTREG_TEEN		(1 << 0)
> +#define MX51_INTREG_RREN		(1 << 3)
> +
> +#define MX51_CSPICTRL_ENABLE		(1 << 0)
> +#define MX51_CSPICTRL_XCH		(1 << 2)
> +
> +#define MX51_CSPICTRL_BL_SHIFT		20
> +#define MX51_CSPICTRL_CS_SHIFT		18
> +#define MX51_CSPICTRL_DR_SHIFT		8
> +#define MX51_CSPICTRL_MODE_SHIFT	4
> +#define MX51_CSPICONF_PHA_SHIFT		0
> +#define MX51_CSPICONF_POL_SHIFT		4
> +#define MX51_CSPICONF_SSPOL_SHIFT	12
> +#define MX51_CSPICONF_SSCTL_SHIFT	8
> +
> +#define MX51_CSPICTRL_CSMASK		0x3
> +#define MX51_CSPIINT			0x10
> +#define MX51_CSPICONF			0xC
> +#define MX51_CSPISTATUS			0x18
> +#define MX51_STATUS_RR			(1 << 3)
> +
> +#define MAX_CHIPSELECT_NUM 4
> +
> +static int get_chipselect(struct spi_imx_data *spi_imx,
> +			  struct spi_imx_config *config)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MAX_CHIPSELECT_NUM; i++) {
> +		if (config->cs =3D=3D spi_imx->chipselect[i])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +static void mx51_intctrl(struct spi_imx_data *spi_imx, int enable)
> +{
> +	unsigned int val =3D 0;
> +
> +	if (enable & MXC_INT_TE)
> +		val |=3D MX51_INTREG_TEEN;
> +	if (enable & MXC_INT_RR)
> +		val |=3D MX51_INTREG_RREN;
> +
> +	writel(val, spi_imx->base + MX51_CSPIINT);
> +}
> +
> +static void mx51_trigger(struct spi_imx_data *spi_imx)
> +{
> +	unsigned int reg;
> +
> +	reg =3D readl(spi_imx->base + MXC_CSPICTRL);
> +	reg |=3D MX51_CSPICTRL_XCH;
> +	writel(reg, spi_imx->base + MXC_CSPICTRL);
> +}
> +
> +static int mx51_config(struct spi_imx_data *spi_imx,
> +		struct spi_imx_config *config)
> +{
> +	unsigned int config_reg =3D 0;
> +	unsigned int ctrl_reg =3D MX51_CSPICTRL_ENABLE;
> +	int chan;
> +
> +	chan =3D get_chipselect(spi_imx, config);
> +	if (chan < 0)
> +		return chan;
can this happen?  Does that have to do with using a GPIO for CS?

> +	ctrl_reg |=3D (chan & MX51_CSPICTRL_CSMASK) << MX51_CSPICTRL_CS_SHIFT;
> +	ctrl_reg |=3D (1 << (chan & MX51_CSPICTRL_CSMASK)) <<
> +		MX51_CSPICTRL_MODE_SHIFT;
> +	ctrl_reg |=3D spi_imx_clkdiv_3(spi_imx->spi_clk, config->speed_hz) <<
> +		MX51_CSPICTRL_DR_SHIFT;
> +
> +	ctrl_reg |=3D (config->bpw - 1) << MX51_CSPICTRL_BL_SHIFT;
> +
> +
duplicated empty line

> +	if (config->mode & SPI_CPHA)
> +		config_reg |=3D (1 << (chan & MX51_CSPICTRL_CSMASK)) <<
> +			MX51_CSPICONF_PHA_SHIFT;
> +	if (config->mode & SPI_CPOL)
> +		config_reg |=3D (1 << (chan & MX51_CSPICTRL_CSMASK)) <<
> +			MX51_CSPICONF_POL_SHIFT;
> +	if (config->mode & SPI_CS_HIGH)
> +		config_reg |=3D (1 << (chan & MX51_CSPICTRL_CSMASK)) <<
> +			MX51_CSPICONF_SSPOL_SHIFT;
> +
> +	config_reg |=3D (1 << (chan & MX51_CSPICTRL_CSMASK)) <<
> +		MX51_CSPICONF_SSCTL_SHIFT;
> +
> +	writel(ctrl_reg, spi_imx->base + MXC_CSPICTRL);
> +	writel(config_reg, spi_imx->base + MX51_CSPICONF);
> +
> +	return 0;
> +}
> +
> +static int mx51_rx_available(struct spi_imx_data *spi_imx)
> +{
> +	return readl(spi_imx->base + MX51_CSPISTATUS) & MX51_STATUS_RR;
> +}
> +
>  #define MX31_INTREG_TEEN	(1 << 0)
>  #define MX31_INTREG_RREN	(1 << 3)
>  =

> @@ -209,7 +323,7 @@ static int mx31_config(struct spi_imx_data *spi_imx,
>  =

>  	if (cpu_is_mx31())
>  		reg |=3D (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
> -	else if (cpu_is_mx25() || cpu_is_mx35()) {
> +	else if (cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51()) {
>  		reg |=3D (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
>  		reg |=3D MX31_CSPICTRL_SSCTL;
>  	}
> @@ -223,7 +337,7 @@ static int mx31_config(struct spi_imx_data *spi_imx,
>  	if (config->cs < 0) {
>  		if (cpu_is_mx31())
>  			reg |=3D (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
> -		else if (cpu_is_mx25() || cpu_is_mx35())
> +		else if (cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51())
>  			reg |=3D (config->cs + 32) << MX35_CSPICTRL_CS_SHIFT;
>  	}
>  =

> @@ -567,7 +681,14 @@ static int __devinit spi_imx_probe(struct platform_d=
evice *pdev)
>  		goto out_iounmap;
>  	}
>  =

> -	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
> +	/* i.MX51 has two eCSPI and one CSPI controllers, eCSPI controllers are
> +	 * not compatible with existing SPI controllers on other i.MX platforms,
> +	 * while CSPI controller is 100% compatible with the one on the i.MX35.
> +	 * We set the platform device id to 2 for this CSPI at i.MX51 board init
> +	 * level to distinguish it from two eCSPI controllers.
> +	 */
This comment is missing in Sascha's driver.  I like it.
BTW, I'd like to make use of platform ids in this driver.  This would
make this ugly "on imx51 id2 is a cspi" distinction unnecessary.

> +	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35() ||
> +	    (cpu_is_mx51() && (pdev->id =3D=3D 2))) {
>  		spi_imx->intctrl =3D mx31_intctrl;
>  		spi_imx->config =3D mx31_config;
>  		spi_imx->trigger =3D mx31_trigger;
> @@ -582,6 +703,11 @@ static int __devinit spi_imx_probe(struct platform_d=
evice *pdev)
>  		spi_imx->config =3D mx1_config;
>  		spi_imx->trigger =3D mx1_trigger;
>  		spi_imx->rx_available =3D mx1_rx_available;
> +	} else if (cpu_is_mx51()) {
> +		spi_imx->intctrl =3D mx51_intctrl;
> +		spi_imx->config =3D mx51_config;
> +		spi_imx->trigger =3D mx51_trigger;
> +		spi_imx->rx_available =3D mx51_rx_available;
>  	} else
>  		BUG();
>  =

> @@ -599,7 +725,8 @@ static int __devinit spi_imx_probe(struct platform_de=
vice *pdev)
>  		writel(1, spi_imx->base + MXC_RESET);
>  =

>  	/* drain receive buffer */
> -	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35())
> +	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35() ||
> +	    (cpu_is_mx51() && (pdev->id =3D=3D 2)))
>  		while (readl(spi_imx->base + MX3_CSPISTAT) & MX3_CSPISTAT_RR)
>  			readl(spi_imx->base + MXC_CSPIRXDATA);
Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
