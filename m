From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 0/8] SoC and board integration for RSPI on RZ/A1H
Date: Tue, 07 Jan 2014 16:01:30 +0100
Message-ID: <5395895.snn5ED4YEr@avalon>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org> <20140107012628.GD2196@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140107012628.GD2196-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Simon,

On Tuesday 07 January 2014 10:26:28 Simon Horman wrote:
> On Fri, Dec 27, 2013 at 09:15:54PM +0100, Geert Uytterhoeven wrote:
> > This patch series integrates Renesas RSPI on the RZ/A1H aka R7S72100 SoC,
> > and the Genmai development board.
> > 
> > The series is based on renesas-devel-v3.13-rc5-20131226, with Magnus'
> > pinctrl, Wolfram's riic, and Simon's sh_eth work applied on top.
> > 
> > It was tested on the Genmai development board (genmai-reference), using
> > an in-kernel version of Documentation/spi/spidev_test.c, exercising
> > loopback mode on rspi1, with the same outcome as the SDK reference code.
> > 
> > Notes:
> >   1. The proposed DT bindings also talk about QSPI on the R8A779x, as
> >      those SoCs use the same driver.
> >   
> >   2. As the actual spi-rspi driver doesn't use DT yet, platform devices
> >      and spi board info are still used from C to instantiate SPI buses and
> >      their children, while pinctrl is performed by DT.
> >   
> >   3. It will not work with the non-reference version of genmai, due to
> >      missing pinmux configuration in setup-r7s72100.c.
> >   
> >   4. Patches [4/8] and [5/8] are new.
> >   
> >     [1/8] pinctrl: sh-pfc: r7s72100: Add RSPI support
> 
> I believe that Laurent should handle this.

I will, but I'm waiting for Magnus to resubmit the base r7s72100 pinctrl patch 
series.

> >     [2/8] ARM: shmobile: r7s72100: Add RSPI clocks
> 
> This seems fine and independent of the other patches.
> But unfortunately it no longer applies.
> 
> Feel free to rebase it if you would like me to queue it up sooner
> than later.
> 
> >     [3/8] ARM: shmobile: r7s72100: Add RSPI platform devices
> 
> I assume this depends on 1/3.
> 
> Please add a patch to update the koelsch defconfig.
> 
> >     [4/8] ARM: shmobile: genmai: Add RSPI children (NEW)
> 
> This seems reasonable but I assume it depends on earlier patches.
> 
> Please add a patch to update the koelsch defconfig or Kconfig.
> 
> >     [5/8] [RFC] ARM: shmobile: genmai: Add preliminary RSPI pinmux (NEW)
> >     [6/8] [RFC] Documentation: dt: Add Renesas RSPI/QSPI bindings
> >     [7/8] [RFC] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
> >     [8/8] [RFC] ARM: shmobile: genmai reference: Add RSPI nodes

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
