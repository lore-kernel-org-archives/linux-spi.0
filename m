From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: mmc_spi lowlevel onetime retry?
Date: Fri, 18 Apr 2008 08:24:09 +0200
Message-ID: <20080418082409.09917b91@mjolnir.drzeus.cx>
References: <47ECDED4.90404@gmail.com> <200804151120.27683.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200804151120.27683.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Tue, 15 Apr 2008 11:20:27 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> On Friday 28 March 2008, Hans wrote:
> > 
> > I know i did the same to my old spi_mmc driver to improve stability. 
> > However, i always got the feeling this was not the right way to do it. 
> > Books and others told med to end_request with a status != 0 and let 
> > block layer resubmit the request(eventually) for me to retry. Whats the 
> > correct policy for this? 
> 
> Low level drivers should as a rule never retry unless they're
> explicitly told to do so.  The current MMC stack doesn't have
> a way to give such instructions, but it *should* have ways to
> retry itself.
> 

It has, but see below...

> 
> Since as far as I know the MMC drivers are not expected to
> retry commands, I'd expect the upper MMC/SD/SDIO code to do
> be issuing any retries.
> 
> In general, the lowlevel code isn't expected to understand
> whether it's even safe to retry like that.  It's supposed to
> understand protocol patterns, not command semantics ... and
> there's no reason to believe that a block write must always
> be idempotent.
> 

The problem is that the mmc_block driver doesn't know what's safe
either. We could add retries for reads as that should always be safe.
But we can't do it for writes as we're supposed to at least give the
guarantee that if given n blocks, we will write 0 to n blocks in a
continuous manner. Retrying a write might end up with a random
assortments of blocks on the media.

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
