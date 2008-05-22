From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling
	support for the card	detectline
Date: Thu, 22 May 2008 16:38:38 +0400
Message-ID: <20080522123838.GA27149@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F16E6A@zch01exm21.fsl.freescale.net>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Tabi Timur <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: Chen Gong <G.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <58A20A281BAF1047B4EAE68DE5C0BDC2F16E6A-bKEhWGtIRULiD3AT8lUqWFjVikpgYyvb5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 19, 2008 at 11:02:13AM +0800, Chen Gong wrote:
> 
> > -----Original Message-----
> > From: linuxppc-dev-bounces+b11801=freescale.com-mnsaURCQ41sdnm+yROfE0A@public.gmane.org 
> > [mailto:linuxppc-dev-bounces+b11801=freescale.com-mnsaURCQ41sdnm+yROfE0A@public.gmane.org] 
> > On Behalf Of Anton Vorontsov
> > Sent: 2008?5?17? 0:51
> > To: Kumar Gala; David Brownell; Pierre Ossman
> > Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org; 
> > spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; 
> > linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Tabi Timur
> > Subject: [PATCH 3/4] [MMC] mmc_spi: add polling support for 
> > the card detectline
> > 
> > Some boards do not use interrupts on the CD line, so we want 
> > to poll the CD and see if there was a change. 1 second poll 
> > interval seems resonable.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> > ---
> >  drivers/mmc/host/mmc_spi.c  |   51 
> 
> I want to know whether every card working well ? Because I'm working
> For 83xx MMC-over-SPI support, the presented concrete methods I used as
> you do,
> but only 256M card seems good, 512M or 1G/2G card all have some problems

So far I don't have cards larger than 256M. Will try to get one though.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
