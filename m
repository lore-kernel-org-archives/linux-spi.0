From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling
 support for the card detect line
Date: Thu, 22 May 2008 21:34:32 +0200
Message-ID: <20080522213432.4a50629b@mjolnir.drzeus.cx>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<20080517133633.5aa26938@mjolnir.drzeus.cx>
	<20080521184713.GA30284@polina.dev.rtsoft.ru>
	<20080521212831.523f344b@mjolnir.drzeus.cx>
	<20080522181713.GA26918@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080522181713.GA26918-PHTr8nzUCjejyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
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

On Thu, 22 May 2008 22:17:13 +0400
Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org> wrote:

> On Wed, May 21, 2008 at 09:28:31PM +0200, Pierre Ossman wrote:
> > 
> > Fair enough. You should probably add a comment about this somewhere so
> > that people do not call get_cd() in the core request function and
> > similar places. Place it so that both get_cd() and get_ro() are covered
> > though, as it should be relevant for both.
> 
> I think this is applicable to the .set_ios() too.
> 

Indeed. That tends to be more obvious that it is costly though.

> > 
> > This can be solved by allowing get_cd() to return an error that will be
> > treated as if get_cd() wasn't defined. -ENODEV seems suitable.
> 
> -ENOSYS (not implemented) sounds better for this purpose...
> 

Even better. :)

> > (get_ro() needs the same treatment, but I haven't gotten around to
> > that)
> 
> Ok. How about this version?
> 

Perfect. Unless there is some way you can pass flags in platform data?
Using the lack of an init() to determine the need for polling is a bit
circumstantial.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
