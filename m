From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 2/6] i.MX5/clock: add eCSPI and CSPI clock definitions
Date: Mon, 13 Sep 2010 11:31:12 +0800
Message-ID: <4C8D9B00.8080004@gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-3-git-send-email-jason77.wang@gmail.com>
	<20100902150112.GM14214@pengutronix.de>
	<4C809410.9090602@gmail.com>
	<20100910094714.GF30558@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Cc: Jason Wang <jason77.wang@gmail.com>, s.hauer@pengutronix.de,
	grant.likely@secretlab.ca, amit.kucheria@canonical.com,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100910094714.GF30558@pengutronix.de>
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
> Hello Jason,
>
> I currently merge your and our patch set.  Will follow up with the
> result hopefully later today.
>
> On Fri, Sep 03, 2010 at 02:22:08PM +0800, Jason Wang wrote:
>   =

>>>>  @@ -52,6 +53,18 @@ static int _clk_ccgr_enable(struct clk *clk)
>>>>  	return 0;
>>>>  }
>>>>  +static int _clk_ccgr_enable_inrun(struct clk *clk)
>>>> +{
>>>> +	u32 reg;
>>>> +
>>>> +	reg =3D __raw_readl(clk->enable_reg);
>>>> +	reg &=3D ~(MXC_CCM_CCGRx_CG_MASK << clk->enable_shift);
>>>> +	reg |=3D MXC_CCM_CCGRx_MOD_IDLE << clk->enable_shift;
>>>> +	__raw_writel(reg, clk->enable_reg);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>     =

>>>>         =

>>> imho this should be consolidated in something like:
>>>
>>> static int _clk_ccgr_setclk(struct clk *clk, unsigned mode)
>>> {
>>> 	...
>>> }
>>>
>>> #define _clk_ccgr_enable(clk) _clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_O=
N)
>>> #define _clk_ccgr_disable(clk) _clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_=
OFF)
>>> #define _clk_ccgr_enable_inrun(clk) _clk_ccgr_setclk(clk, MXC_CCM_CCGRx=
_MOD_IDLE)
>>>
>>>   =

>>>       =

>> It makes  code more concise. On the other hand, too many macros will
>> add troubles when we use kgdb to perform sourcecode-level debug.
>>     =

> Using macros doesn't work here, as they are used as callbacks.  Still
> made it with functions.  Then (apart from the return value)
> _clk_ccgr_enable_inrun and _clk_ccgr_disable_inwait are identically.
> I wonder if this is intended?
>
>   =

This is from Freescale's original design.

enalble_inrun =3D disable_inwait  =3D paritial enable =3D partial disable.
(clock is enable in free run mode, while is disable in wait/stop mode.)

This function can be both an enable callback and a disable callback.
I guess that assign this function two names just for logic clear.
>> Anyway, i agree your suggestion.
>>     =

>>>>  static void _clk_ccgr_disable(struct clk *clk)
>>>>  {
>>>>  	u32 reg;
>>>> @@ -762,6 +775,61 @@ static struct clk kpp_clk =3D {
>>>>  	.id =3D 0,
>>>>  };
>>>>  +/* eCSPI */
>>>> +static unsigned long _clk_ecspi_getrate(struct clk *clk)
>>>> +{
>>>> +	u32 reg, prediv, podf;
>>>> +	unsigned long ret;
>>>> +
>>>> +	reg =3D __raw_readl(MXC_CCM_CSCDR2);
>>>> +	prediv =3D ((reg & MXC_CCM_CSCDR2_CSPI_CLK_PRED_MASK) >>
>>>> +		  MXC_CCM_CSCDR2_CSPI_CLK_PRED_OFFSET) + 1;
>>>> +	if (prediv =3D=3D 1)
>>>> +		BUG();
>>>> +	podf =3D ((reg & MXC_CCM_CSCDR2_CSPI_CLK_PODF_MASK) >>
>>>> +		MXC_CCM_CSCDR2_CSPI_CLK_PODF_OFFSET) + 1;
>>>> +
>>>> +	ret =3D clk_get_rate(clk->parent) / (prediv * podf);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int _clk_ecspi_set_parent(struct clk *clk, struct clk *parent)
>>>> +{
>>>> +	u32 reg, mux;
>>>> +
>>>> +	mux =3D _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
>>>> +		       &lp_apm_clk);
>>>> +	reg =3D __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_CSPI_CLK_SEL_M=
ASK;
>>>> +	reg |=3D mux << MXC_CCM_CSCMR1_CSPI_CLK_SEL_OFFSET;
>>>> +	__raw_writel(reg, MXC_CCM_CSCMR1);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static struct clk ecspi_main_clk =3D {
>>>> +	.parent =3D &pll3_sw_clk,
>>>> +	.get_rate =3D _clk_ecspi_getrate,
>>>> +	.set_parent =3D _clk_ecspi_set_parent,
>>>>     =

>>>>         =

>>> Sascha didn't implement set_parent
>>>
>>>   =

>>>       =

>> ecspi really can change parent root clock.
>>     =

>>>> +};
>>>> +
>>>> +static struct clk ecspi1_ipg_clk =3D {
>>>> +	.parent =3D &ipg_clk,
>>>> +	.secondary =3D &spba_clk,
>>>> +	.enable_reg =3D MXC_CCM_CCGR4,
>>>> +	.enable_shift =3D MXC_CCM_CCGRx_CG9_OFFSET,
>>>> +	.enable =3D _clk_ccgr_enable_inrun,
>>>> +	.disable =3D _clk_ccgr_disable,
>>>> +};
>>>> +
>>>> +static struct clk ecspi2_ipg_clk =3D {
>>>> +	.parent =3D &ipg_clk,
>>>> +	.secondary =3D &aips_tz2_clk,
>>>> +	.enable_reg =3D MXC_CCM_CCGR4,
>>>> +	.enable_shift =3D MXC_CCM_CCGRx_CG11_OFFSET,
>>>> +	.enable =3D _clk_ccgr_enable_inrun,
>>>> +	.disable =3D _clk_ccgr_disable,
>>>> +};
>>>>         =

> aips_tz2_clk is wrong here, no?  Sascha used spba_clk here, too.  I
> didn't found out yet how to read that out of the reference manual.
>
>   =

Just guess from Freescale original design and "charpter 2 Memory Map" of
MCIMX51RM.pdf.

eCSPI1 is in the AIPS_TZ1(spba) ip module, while eCSPI2 is in the AIPS_TZ2
ip module, so they have different "secondary ipg parent clock".

Thanks,
Jason.
> Best regards
> Uwe
>
>   =
