From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 2/6] i.MX5/clock: add eCSPI and CSPI clock definitions
Date: Fri, 03 Sep 2010 14:22:08 +0800
Message-ID: <4C809410.9090602@gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-3-git-send-email-jason77.wang@gmail.com>
	<20100902150112.GM14214@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Cc: Jason Wang <jason77.wang@gmail.com>, s.hauer@pengutronix.de,
	grant.likely@secretlab.ca, amit.kucheria@canonical.com,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100902150112.GM14214@pengutronix.de>
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

Uwe Kleine-K=F6nig wrote:
> On Thu, Sep 02, 2010 at 03:52:00PM +0800, Jason Wang wrote:
>   =

>> i.MX51 has two eCSPI and one CSPI controllers, now add clock
>> definitions and registrations for these controllers.
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>>  arch/arm/mach-mx5/clock-mx51.c |   79 +++++++++++++++++++++++++++++++++=
+++++++
>>  1 files changed, 79 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx=
51.c
>> index 6af69de..217c3f3 100644
>> --- a/arch/arm/mach-mx5/clock-mx51.c
>> +++ b/arch/arm/mach-mx5/clock-mx51.c
>> @@ -38,6 +38,7 @@ static struct clk periph_apm_clk;
>>  static struct clk ahb_clk;
>>  static struct clk ipg_clk;
>>  static struct clk usboh3_clk;
>> +static struct clk spba_clk;
>>  =

>>  #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) =3D 1ms */
>>  =

>> @@ -52,6 +53,18 @@ static int _clk_ccgr_enable(struct clk *clk)
>>  	return 0;
>>  }
>>  =

>> +static int _clk_ccgr_enable_inrun(struct clk *clk)
>> +{
>> +	u32 reg;
>> +
>> +	reg =3D __raw_readl(clk->enable_reg);
>> +	reg &=3D ~(MXC_CCM_CCGRx_CG_MASK << clk->enable_shift);
>> +	reg |=3D MXC_CCM_CCGRx_MOD_IDLE << clk->enable_shift;
>> +	__raw_writel(reg, clk->enable_reg);
>> +
>> +	return 0;
>> +}
>> +
>>     =

> imho this should be consolidated in something like:
>
> static int _clk_ccgr_setclk(struct clk *clk, unsigned mode)
> {
> 	...
> }
>
> #define _clk_ccgr_enable(clk) _clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_ON)
> #define _clk_ccgr_disable(clk) _clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_OF=
F)
> #define _clk_ccgr_enable_inrun(clk) _clk_ccgr_setclk(clk, MXC_CCM_CCGRx_M=
OD_IDLE)
>
>   =

It makes  code more concise. On the other hand, too many macros will
add troubles when we use kgdb to perform sourcecode-level debug.

Anyway, i agree your suggestion.
>>  static void _clk_ccgr_disable(struct clk *clk)
>>  {
>>  	u32 reg;
>> @@ -762,6 +775,61 @@ static struct clk kpp_clk =3D {
>>  	.id =3D 0,
>>  };
>>  =

>> +/* eCSPI */
>> +static unsigned long _clk_ecspi_getrate(struct clk *clk)
>> +{
>> +	u32 reg, prediv, podf;
>> +	unsigned long ret;
>> +
>> +	reg =3D __raw_readl(MXC_CCM_CSCDR2);
>> +	prediv =3D ((reg & MXC_CCM_CSCDR2_CSPI_CLK_PRED_MASK) >>
>> +		  MXC_CCM_CSCDR2_CSPI_CLK_PRED_OFFSET) + 1;
>> +	if (prediv =3D=3D 1)
>> +		BUG();
>> +	podf =3D ((reg & MXC_CCM_CSCDR2_CSPI_CLK_PODF_MASK) >>
>> +		MXC_CCM_CSCDR2_CSPI_CLK_PODF_OFFSET) + 1;
>> +
>> +	ret =3D clk_get_rate(clk->parent) / (prediv * podf);
>> +	return ret;
>> +}
>> +
>> +static int _clk_ecspi_set_parent(struct clk *clk, struct clk *parent)
>> +{
>> +	u32 reg, mux;
>> +
>> +	mux =3D _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
>> +		       &lp_apm_clk);
>> +	reg =3D __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_CSPI_CLK_SEL_MAS=
K;
>> +	reg |=3D mux << MXC_CCM_CSCMR1_CSPI_CLK_SEL_OFFSET;
>> +	__raw_writel(reg, MXC_CCM_CSCMR1);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct clk ecspi_main_clk =3D {
>> +	.parent =3D &pll3_sw_clk,
>> +	.get_rate =3D _clk_ecspi_getrate,
>> +	.set_parent =3D _clk_ecspi_set_parent,
>>     =

> Sascha didn't implement set_parent
>
>   =

ecspi really can change parent root clock.
>> +};
>> +
>> +static struct clk ecspi1_ipg_clk =3D {
>> +	.parent =3D &ipg_clk,
>> +	.secondary =3D &spba_clk,
>> +	.enable_reg =3D MXC_CCM_CCGR4,
>> +	.enable_shift =3D MXC_CCM_CCGRx_CG9_OFFSET,
>> +	.enable =3D _clk_ccgr_enable_inrun,
>> +	.disable =3D _clk_ccgr_disable,
>> +};
>> +
>> +static struct clk ecspi2_ipg_clk =3D {
>> +	.parent =3D &ipg_clk,
>> +	.secondary =3D &aips_tz2_clk,
>> +	.enable_reg =3D MXC_CCM_CCGR4,
>> +	.enable_shift =3D MXC_CCM_CCGRx_CG11_OFFSET,
>> +	.enable =3D _clk_ccgr_enable_inrun,
>> +	.disable =3D _clk_ccgr_disable,
>> +};
>> +
>>  #define DEFINE_CLOCK(name, i, er, es, gr, sr, p, s)	\
>>  	static struct clk name =3D {			\
>>  		.id		=3D i,			\
>> @@ -814,6 +882,14 @@ DEFINE_CLOCK(hsi2c_clk, 0, MXC_CCM_CCGR1, MXC_CCM_C=
CGRx_CG11_OFFSET,
>>  DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
>>  	NULL,  NULL, &ipg_clk, NULL);
>>  =

>> +/* eCSPI & CSPI */
>> +DEFINE_CLOCK(cspi1_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG10_OFFSET,
>> +	NULL, NULL, &ecspi_main_clk, &ecspi1_ipg_clk);
>> +DEFINE_CLOCK(cspi2_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG12_OFFSET,
>> +	NULL, NULL, &ecspi_main_clk, &ecspi2_ipg_clk);
>> +DEFINE_CLOCK(cspi3_clk, 2, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG13_OFFSET,
>> +	NULL, NULL, &ipg_clk, NULL);
>> +
>>     =

> Maybe use ecspi1_clk, cspi2_clk, cspi_clk here?  I thought about this,
> too, for our code, couldn't really decide.  What do you think?
>
>   =

Agree.
>>  #define _REGISTER_CLOCK(d, n, c) \
>>         { \
>>  		.dev_id =3D d, \
>> @@ -837,6 +913,9 @@ static struct clk_lookup lookups[] =3D {
>>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
>>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
>>  	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
>> +	_REGISTER_CLOCK("spi_imx.0", NULL, cspi1_clk)
>> +	_REGISTER_CLOCK("spi_imx.1", NULL, cspi2_clk)
>> +	_REGISTER_CLOCK("spi_imx.2", NULL, cspi3_clk)
>>  };
>>  =

>>     =

>
> Best regards
> Uwe
>
>   =
