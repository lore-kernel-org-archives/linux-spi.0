From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/6] spi-imx: Add i.MX51 support
Date: Wed, 8 Sep 2010 23:33:16 -0600
Message-ID: <20100909053316.GK11833@angua.secretlab.ca>
References: <20100902143908.GK14214@pengutronix.de>
	<1283438523-19697-5-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: amit.kucheria@canonical.com, Sascha Hauer <s.hauer@pengutronix.de>,
	Jason Wang <jason77.wang@gmail.com>, linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1283438523-19697-5-git-send-email-u.kleine-koenig@pengutronix.de>
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

Hi Uwe,

On Thu, Sep 02, 2010 at 04:42:02PM +0200, Uwe Kleine-K=F6nig wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> =


A description of what is required to add imx51 support would be
appreciated by us poor patch reviewers.

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/spi/spi_imx.c |  123 +++++++++++++++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 120 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 7972e90..5ee2699 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -155,6 +155,117 @@ static unsigned int spi_imx_clkdiv_2(unsigned int f=
in,
>  	return 7;
>  }
>  =

> +/* MX51 */
> +static unsigned int spi_imx_clkdiv_3(unsigned int fin,
> +		unsigned int fspi)
> +{
> +	unsigned int div =3D 4, post =3D 0, pre =3D 0, res;
> +
> +	div =3D fin / fspi;
> +
> +	res =3D fin;
> +	while (res > (fspi * 16)) {
> +		post++;
> +		res =3D fin / (1 << post);
> +	}
> +
> +	pre =3D fin / (1 << post) / fspi;
> +
> +	return (post & 0xf) | ((pre & 0xf) << 4);
> +}
> +
> +#define MX51_CSPIRXDATA		0x00
> +#define MX51_CSPITXDATA		0x04
> +#define MX51_CSPICTRL		0x08
> +#define MX51_CSPICONFIG		0x0c
> +#define MX51_CSPIINT		0x10
> +#define MX51_CSPIDMA		0x14
> +#define MX51_CSPISTATUS		0x18
> +#define MX51_CSPIPERIOD		0x1c
> +#define MX51_CSPITEST		0x20
> +
> +#define MX51_INTREG_TEEN	(1 << 0)
> +#define MX51_INTREG_RREN	(1 << 3)
> +
> +#define MX51_CSPICTRL_ENABLE	(1 << 0)
> +#define MX51_CSPICTRL_XCH	(1 << 2)
> +#define MX51_CSPICTRL_DIV_SHIFT	8
> +#define MX51_CSPICTRL_MASTER(cs)	((1 << (cs)) << 4)
> +#define MX51_CSPICTRL_BL_SHIFT	20
> +#define MX51_CSPICTRL_CS(cs)	((cs) << 18)
> +
> +#define MX51_CSPICONFIG_PHA(cs)		((1 << (cs)) << 0)
> +#define MX51_CSPICONFIG_POL(cs)		((1 << (cs)) << 4)
> +#define MX51_CSPICONFIG_SSBCTRL(cs)	((1 << (cs)) << 8)
> +#define MX51_CSPICONFIG_SSBPOL(cs)	((1 << (cs)) << 12)
> +#define MX51_CSPICONFIG_DATACTRL(cs)	((1 << (cs)) << 16)
> +#define MX51_CSPICONFIG_SCLKCTRL(cs)	((1 << (cs)) << 20)
> +
> +#define MX51_STATUS_RR		(1 << 3)
> +
> +#define MX51_CSPITEST_LBC	(1 << 31)
> +
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
> +	int cs;
> +	u32 ctrl;
> +	u32 cfg =3D 0;
> +
> +#ifdef INTERNAL_LOOPBACK
> +	writel(MX51_CSPITEST_LBC, spi_imx->base + MX51_CSPITEST);
> +#endif
> +	if (config->cs < 0)
> +		cs =3D config->cs + 32;
> +	else
> +		cs =3D 0;
> +
> +	ctrl =3D MX51_CSPICTRL_MASTER(cs) | MX51_CSPICTRL_ENABLE;
> +	ctrl |=3D spi_imx_clkdiv_3(spi_imx->spi_clk, config->speed_hz) <<
> +		MX51_CSPICTRL_DIV_SHIFT;
> +
> +	ctrl |=3D (config->bpw - 1) << MX51_CSPICTRL_BL_SHIFT;
> +	cfg |=3D MX51_CSPICONFIG_SSBCTRL(cs);
> +	if (config->mode & SPI_CPHA)
> +		cfg |=3D MX51_CSPICONFIG_PHA(cs);
> +	if (config->mode & SPI_CPOL)
> +		cfg |=3D MX51_CSPICONFIG_POL(cs) | MX51_CSPICONFIG_SCLKCTRL(cs);
> +	if (config->mode & SPI_CS_HIGH)
> +		cfg |=3D MX51_CSPICONFIG_SSBPOL(cs);
> +	ctrl |=3D MX51_CSPICTRL_CS(cs);
> +
> +	writel(ctrl, spi_imx->base + MX51_CSPICTRL);
> +	writel(cfg, spi_imx->base + MX51_CSPICONFIG);
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

> @@ -209,7 +320,7 @@ static int mx31_config(struct spi_imx_data *spi_imx,
>  =

>  	if (cpu_is_mx31())
>  		reg |=3D (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
> -	else if (cpu_is_mx25() || cpu_is_mx35()) {
> +	else if (cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51()) {
>  		reg |=3D (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
>  		reg |=3D MX31_CSPICTRL_SSCTL;
>  	}
> @@ -223,7 +334,7 @@ static int mx31_config(struct spi_imx_data *spi_imx,
>  	if (config->cs < 0) {
>  		if (cpu_is_mx31())
>  			reg |=3D (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
> -		else if (cpu_is_mx25() || cpu_is_mx35())
> +		else if (cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51())
>  			reg |=3D (config->cs + 32) << MX35_CSPICTRL_CS_SHIFT;
>  	}
>  =

> @@ -567,7 +678,8 @@ static int __devinit spi_imx_probe(struct platform_de=
vice *pdev)
>  		goto out_iounmap;
>  	}
>  =

> -	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
> +	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35() ||
> +			(cpu_is_mx51() && pdev->id =3D=3D 2)) {

These lists are getting a bit silly.  There's got to be a better way.

Otherwise, looks okay.  Reply with an appropriate patch description
and I'll pick it up.

>  		spi_imx->intctrl =3D mx31_intctrl;
>  		spi_imx->config =3D mx31_config;
>  		spi_imx->trigger =3D mx31_trigger;
> @@ -582,6 +694,11 @@ static int __devinit spi_imx_probe(struct platform_d=
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

> -- =

> 1.7.1
> =
