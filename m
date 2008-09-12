From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx_spi introduce chip
 select gpio to simplify the common cases
Date: Fri, 12 Sep 2008 19:18:17 +0100
Message-ID: <48CAB269.8080301@cam.ac.uk>
References: <f17812d70809040221y477ec4x5c05460650266be8@mail.gmail.com>
	<200809102308.31675.david-b@pacbell.net>
	<48C91DFD.5020308@whoi.edu>
	<200809111135.44364.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200809111135.44364.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

David Brownell wrote:
> On Thursday 11 September 2008, Ned Forrester wrote:
> 
>> I'm puzzled.  What is there about the pxa2xx_spi.c that would be
>> simplified by doing anything with respect to SSPFRM?
> 
> The usage model ... callers must understand that option,
> evaluate whether it's even usable on their board, and
> then have an extra set of possibilities to debug.  And
> it's not a model needed with other SPI controllers...
> 
> The code ... has to support that more complex model.
> 
> Developers ... have to answer questions about that
> mechanism when they could be doing more useful things.

Having converted the boards I use over to a gpio model
(was all sfrm based before) I agree that this is probably 
the way to go.

There are a few use cases though where using the hardware
support (though broken as it is) would give higher performance.

For some devices it is necessary to deselect them for
between transfers for an amount of time equal to say 
4 times the SCK period.  Clearly the only way to
make this happen on various spi controllers is to 
set mdelay_usecs to the best value you can manage.
(at high speed this is somewhat tedious, and in most cases
the time to turn the gpio off and on again is sufficient)

However, there is always a fixed min delay between the 
transfers due to the passing of interrupts back to the
driver etc so in many cases the use of SFRM allows
this to be harnessed as it switches much closer to the
actual transmission than a gpio based control. 

As an example, take the vti sca3000 range of accelerometers.
The specs say that they must be deselected for 4 * the SCK
period.  As some of these devices go at 325kHz this comes
to 12.3 microsecs and a typical time I've observed for gpio
deselecting is only 7 microsecs this would be a device that
would benefit from such strategy (as long as the board
config had the option of specifying a minimum delay between
SRFM being deselected and control hitting the delay_usecs
code in pxa2xx_spi.c.

Still, despite the above being the case, I'm inclined
to agree that at the very least people should be strongly
discouraged from using SRFM!

Jonathan

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
