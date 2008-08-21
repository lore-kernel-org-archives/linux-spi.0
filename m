From: Erwin Authried <eauth-T13/FXdtSm+ALaLeEb27IQ@public.gmane.org>
Subject: Re: SD-over-SPI with shared SPI bus
Date: Thu, 21 Aug 2008 14:04:47 +0200
Message-ID: <1219320287.6516.12.camel@timing-laptop>
References: <20080821104615.7zxonbllsgg0gw0o@v1539.ncsrv.de>
	<1219311387.3496.40.camel@justakiss.home.at>
	<20080821114750.uw580nkdssok4o84@v1539.ncsrv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Hendrik Sattler <post-azCMwr5LJFZ+Wm55xJeGF4QuADTiUCJX@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080821114750.uw580nkdssok4o84-mcLvVI60cSeH+6FY6glk5g@public.gmane.org>
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

Am Donnerstag, den 21.08.2008, 11:47 +0200 schrieb Hendrik Sattler:
> Zitat von Erwin Authried <eauth-T13/FXdtSm+ALaLeEb27IQ@public.gmane.org>:
> 
> > Am Donnerstag, den 21.08.2008, 10:46 +0200 schrieb Hendrik Sattler:
> >> Hi,
> >>
> >> I contact you because you are mentioned in the MAINTAINERS file of
> >> linux-2.6.26 for the mmc_spi drive and SPI subsystem.
> >>
> >> I want to share the bus with other SPI devices. The drivers mentions
> >> pending updates that would allow that.
> >> Are those available somewhere?
> >>
> >> If not, the changes seem to fairly trivial: change SPI controller
> >> drivers to allow adding a spi_transfer to an spi_message during the
> >> complete() callback or add another callback that can do this.
> >
> > Hi,
> >
> > I have done this in a slightly different, rather simple way. I have
> > added a new "transfer_end" callback function pointer to the spi_transfer
> > structure. This function can have three return values:
> >
> > <0 ... stop spi message after the transfer
> > 0  ... continue with next transfer
> > 1  ... repeat current transfer
> >
> > If the transfer_end callback is not required, the function pointer must
> > be set to NULL.
> >
> > I have modified the bitbang driver for this new functionality. In
> > addition, the mmc_spi driver has been changed to make use of the
> > callback function. It is necessary to pack all transfers that must be
> > done without being interrupted into a single message. I have done a lot
> > of testing with a SD card on a shared bus with a lot of other activity,
> > and I couldn't see any problems.
> 
> I'd imagine something like this but instead of the return code, let it  
> fill/clear spi_message::transfers as it likes during this callback and  
> let the caller check the that after the callback (list_empty()).
> 
I wanted to keep it simple. You can modify the buffers in the callback
function and repeat that transfer (with return code 1), thus there are
virtually no restrictions in the message transfers.

> Nice to know that there are no further pitfalls :)
There are a few hacks that I had to do during initialization of the SD
card. The cards seem to be quite fuzzy if someone else is using the bus
during this phase. I'll need some time to see if my changes are working
with the actual version, and I'll post the patch then.

Regards,
Erwin



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
