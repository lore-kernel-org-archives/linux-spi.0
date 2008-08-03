From: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFT PATCH] SuperH HSPI controller driver.
Date: Mon, 4 Aug 2008 08:57:02 +0900
Message-ID: <20080803235702.GB6682__27324.9055179351$1217807944$gmane$org@linux-sh.org>
References: <20080721090744.GA16714@roarinelk.homelinux.net>
	<20080803235247.GA6682@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>,
	David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080803235247.GA6682-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
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

On Mon, Aug 04, 2008 at 08:52:47AM +0900, Paul Mundt wrote:
> On Mon, Jul 21, 2008 at 11:07:44AM +0200, Manuel Lauss wrote:
> > Here is a very simple driver for the HSPI block on many SuperH processors.
> > I could only subject it to limited testings, as my sole SPI device here is
> > a write-only 8bit digital poti.  It seems to do the right thing as far as
> > I could see on an oscilloscope.
> > 
> > The driver doesn't do DMA and pushes/pops bytes one-at-a-time from/to fifos
> > (I'm going to fix that at a later time).
> > 
> > Please test and comment!
> > 
> > Thanks,
> > 	Manuel Lauss
> > 
> > ---
> > 
> > A simple driver for the HSPI block found on many SuperH processors.
> > 
> > Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> 
> I have no outstanding issues with this, though I did just break it with
> the header reorg. If David is fine with it and wants to Ack it, I can
> take it through my tree.

Taking a quick look at it again, I think you should be able to reuse
arch/sh/include/asm/spi.h as-is, and just drop the header you have now.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
