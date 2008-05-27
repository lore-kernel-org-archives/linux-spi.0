From: "Chen Gong" <G.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling
	support for thecarddetectline
Date: Tue, 27 May 2008 10:11:45 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2F5939E@zch01exm21.fsl.freescale.net>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F16E6A@zch01exm21.fsl.freescale.net>
	<20080522123838.GA27149@polina.dev.rtsoft.ru>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F176EF@zch01exm21.fsl.freescale.net>
	<20080526153747.GA31663@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Tabi Timur <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080526153747.GA31663-PHTr8nzUCjejyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
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

 

> -----Original Message-----
> From: Anton Vorontsov [mailto:avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org] 
> Sent: 2008?5?26? 23:38
> To: Chen Gong
> Cc: Kumar Gala; David Brownell; Pierre Ossman; 
> linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org; 
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; 
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Tabi Timur
> Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling support 
> for thecarddetectline
> 
> On Thu, May 22, 2008 at 09:44:57PM +0800, Chen Gong wrote:
> [...]
> > > > I want to know whether every card working well ? Because
> > > I'm working
> > > > For 83xx MMC-over-SPI support, the presented concrete
> > > methods I used
> > > > as you do, but only 256M card seems good, 512M or 1G/2G
> > > card all have
> > > > some problems
> > > 
> > > So far I don't have cards larger than 256M. Will try to get one 
> > > though.
> > > 
> > Thanks, if you have any new test report pls contact me.
> 
> Just tested with Apacer 1GB MicroSD (connected through dumb 
> adapter), it works quite well here. I've successfully wrote 
> 10 mb file onto ext2 formatted partition...

Oh, thanks for your info. The card I used is Kingston 1G SD card.

> 
> > BTW, a fews days ago Joakim Tjernlund made a heavy fix for 
> > spi_mpc83xx.c to resolve clock glitch. But it looks no any 
> impact for 
> > me, but maybe it has positive effect for you.
> 
> Yup, I use it.
> 
> Btw, which mmc driver are you using? The one from MPC8610HPCD 
> BSP or mainline's mmc_spi?

:-( the mmc driver now in the MPC8610HPCD BSP is ported from uClinux
 by me, it has many problems, because at that time MMC-over-SPI driver
doen't exist in the kernel.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
