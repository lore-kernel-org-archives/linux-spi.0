From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: SPI or CSPI transfers using DMA
Date: Thu, 20 Nov 2008 13:39:28 -0800
Message-ID: <200811201339.28627.david-b@pacbell.net>
References: <10811398.477881225431989704.JavaMail.nabble@isper.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: magene-5892unH0nlnYtjvyW6yDsg@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <10811398.477881225431989704.JavaMail.nabble-eSX/vLDKhQvUl7QJpGZvuQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 30 October 2008, magene-5892unH0nlnYtjvyW6yDsg@public.gmane.org wrote:
> I've been developing an application on an Eurotech (formerly
> Applied Data Systems) Bitsy Xb PXA270 board

And there I thought "bitsy" was an SA-1100 board from Digital.  ;)


> that reads data from and ADC at about 50 kSamples/sec. 

So about 20 usec per sample ... that's a bit much for a
non-dedicated chunk of hardware.  You didn't describe
the ADC involved; at that rate the details matter.
(Does it constantly sample, or do you need to issue a
command for each sample and play with chipselect?)

If you need timestamps on your samples, I'd plan to
avoid current general purpose frameworks on Linux.
They're not geared towards that sort of design.


> It 
> works fine when I poll the SPI port for data but I get some
> drop outs in the data, probably when the OS is off doing something
> else. 

Probably.  :)


> I'd like to use DMA put the DMA engine on the PXA270 has 
> a pretty steep learning curve.  Does anyone have a code example
> that could help jumpstart me? 

Our resident expert from Woods Hole has a similar data
streaming application, using PXA and DMA.  Maybe he can
share a few words of wisdom ... 


> I may be upgrading to a i.MX31 
> based board and similar examples with that device's CSPI and DMA
> would also be helpful.         

I don't know what application you're looking at, but
with some of them it might be advantageous to dedicate
a microcontroller to collecting and timestamping your
samples, then writing them into memory (an SRAM?).

Then the PXA (or i.MX) could pull them out on a more
leisurely schedule, preprocess in bulk, etc.

- Dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
