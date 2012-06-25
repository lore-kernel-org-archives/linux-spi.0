From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
Date: Mon, 25 Jun 2012 15:30:31 +0200
Message-ID: <201206251530.32203.marex@denx.de>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
	<1340477033-2761-7-git-send-email-marex@denx.de>
	<CAOMZO5BYoU5=tJCUH1nkT24FJhhXXhNwF46yYREGJj7G33HdVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>,
	Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAOMZO5BYoU5=tJCUH1nkT24FJhhXXhNwF46yYREGJj7G33HdVg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Fabio Estevam,

> Hi Marek,
> 
> On Sat, Jun 23, 2012 at 3:43 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> > +       ssp->clk = clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(ssp->clk)) {
> > +               ret = PTR_ERR(ssp->clk);
> > +               goto out_spi_free;
> > +       }
> 
> You could use devm_clk_get here instead,
> 
> > +
> > +       clk_prepare_enable(ssp->clk);
> > +       ssp->clk_rate = clk_get_rate(ssp->clk) / 1000;
> > +
> > +       stmp_reset_block(ssp->base);
> > +
> > +       platform_set_drvdata(pdev, host);
> > +
> > +       ret = spi_register_master(host);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Cannot register SPI master, %d\n",
> > ret); +               goto out_clk_put;
> > +       }
> > +
> > +       return 0;
> > +
> > +out_clk_put:
> > +       clk_disable_unprepare(ssp->clk);
> > +       clk_put(ssp->clk);
> 
> ,and then you would not need this clk_put here.

Oh, good point! I'll wait a little bit more until someone else reviews it and 
then I'll resubmit new version.

btw. I'm already working on a combined PIO/DMA-capable version -- seems like 
using PIO for small transfers and DMA for large transfers is good strategy that 
gives me about 200kbps boost ;-)

> Driver looks good. Thanks for working on it.
> 
> Regards,
> 
> Fabio Estevam

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
