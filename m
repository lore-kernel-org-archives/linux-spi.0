From: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 6/6] ASoC: fsl: add imx-wm8974 machine driver
Date: Fri, 9 Nov 2012 19:54:01 +0100
Message-ID: <20121109185401.GA3660@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
	<1352469625-32024-7-git-send-email-s.trumtrar@pengutronix.de>
	<20121109153629.GK23807@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121109153629.GK23807-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Nov 09, 2012 at 03:36:30PM +0000, Mark Brown wrote:
> On Fri, Nov 09, 2012 at 03:00:25PM +0100, Steffen Trumtrar wrote:
> 
> > +static int imx_wm8974_dai_init(struct snd_soc_pcm_runtime *rtd)
> > +{
> > +	struct imx_wm8974_data *data = container_of(rtd->card,
> > +					struct imx_wm8974_data, card);
> > +	struct device *dev = rtd->card->dev;
> > +	int ret;
> > +
> > +	/* the pll stability peaks at N=8 and around 90MHz.
> > +	 * This values are best reached with a 12.288MHz or
> > +	 * 11.289MHz clock. As the first is closer to N=8 in
> > +	 * more situations, chose 12.288MHz as the target clock
> > +	 * (ref: datasheet section "Master Clock and Phase Locked Loop")*/
> > +	ret = snd_soc_dai_set_pll(rtd->codec_dai, 0, 0, data->clk_frequency,
> > +		12288000);
> 
> This seems far from ideal - it's starting the PLL at system boot and
> just leaving it running.  This will be power inefficient when the system
> is not playing audio as the PLL will be consuming power but not used for
> anything.  You could also do the same thing with the MCLK.
> 
> Note also that a 12.288MHz clock is only suitable for 8kHz based sample
> rates, for CD audio 44.1kHz based rates like most media files 11.2896MHz
> should be chosen.  The driver may want to switch dynamically at runtime
> to support the widest possible range of rates.
> 

Maybe I had a weird test system, but I only got correct audio with the
12.288 MHz clock from the PLL. And this was for 48Khz and 44Khz audio.
So, as the datasheet was not really that clear about the clock as you
are, I chose the above clock freq.


> > +	data->codec_clk = clk_get(&codec_pdev->dev, NULL);
> > +	if (IS_ERR(data->codec_clk)) {
> 
> devm_clk_get() - this'd free the clock that's leaked on removal.

Okay

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
