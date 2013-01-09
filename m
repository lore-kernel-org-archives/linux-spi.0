From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Tue, 8 Jan 2013 20:25:35 -0800
Message-ID: <20130109042535.GL19691@intel.com>
References: <1353464203.20353.6.camel@bichao>
	<CACRpkdad3fHxWRpRqD-eP8-sKKexN+s-JZCT6XLggv92Q=5kMA@mail.gmail.com>
	<1355809660.11831.284.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alan-b5Z7lJ3WibVrdx17CPfAsdBPR1lH4CV8@public.gmane.org
To: chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1355809660.11831.284.camel@bichao>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 18, 2012 at 01:47:40PM +0800, chao bi wrote:
> Dear Linus,
> Thanks for your kind comments. Seems you were viewing the 1st version, I've
> submitted 2nd version and to deliver the 3rd version soon, will include you
> for review.
Was the third version posted?

Also I have some questions on this approach. Is this driver for SSP ip or SPI
ip, looks like latter. In both the cases there are some existing drivers in
kernel and adding one more IMHO doesnt make sense. What we really need a
common core for dw IP and SSP IP (i think pxa uses same stuff). That way lot of
code will get reduced from driver
> > 
> > > +#define SRAM_BASE_ADDR 0xfffdc000
> > 
> > Should be passed as resource, se above reasoning for the
> > "I2C" base address. What happens on next ASIC spin when
> > the engineer move this base offset etc, don't you have any
> > system discovery?
> This is fix value for Moorestown & Medfield platforms as what is
> declared in the file header. If any hardware change, the address should
> be changed accordantly.
Why do you wnat to change this latter, pls add it as a resouce or since this is
a PCI device you can use PCI table driver data. 

Also why would SSP care about SRAM, I am not sure I follow it??
Lastly if you have dedicated SRAM for your use, it should be in PCI BAR and not
hard coded like this!!

--
~Vinod

------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
