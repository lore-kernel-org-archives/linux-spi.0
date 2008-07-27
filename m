From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/4] [SPI] [POWERPC] spi_mpc83xx:
	handles Freescale	MPC8610 as well
Date: Sun, 27 Jul 2008 15:12:58 -0700
Message-ID: <200807271512.58969.david-b@pacbell.net>
References: <20080516165052.GA24196@polina.dev.rtsoft.ru>
	<20080516190438.GA2758@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080516190438.GA2758-tDB31bHjl+hpTrP2zolEsF6hYfS7NtTn@public.gmane.org>
Content-Disposition: inline
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

On Friday 16 May 2008, Scott Wood wrote:
> On Fri, May 16, 2008 at 08:50:52PM +0400, Anton Vorontsov wrote:
> >  config SPI_MPC83xx
> >  	tristate "Freescale MPC83xx/QUICC Engine SPI controller"
> > -	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE) && EXPERIMENTAL
> > +	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE || PPC_86xx) && EXPERIMENTAL
> 
> How about "depends on SPI_MASTER && FSL_SOC && EXPERIMENTAL"?
> 
> Plus, we should change the option text to something like "MPC8xxx SPI
> controller".

Is there an approved-by-powerpc-folk version of this patch yet?
(Noting that SPI_MASTER is now implicit ...)




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
