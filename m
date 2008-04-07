From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: spi_bitbang cs_change hinting fix
Date: Sun, 6 Apr 2008 22:09:47 -0700
Message-ID: <200804062209.47470.david-b@pacbell.net>
References: <47D6597F.4040503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47D6597F.4040503-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

On Tuesday 11 March 2008, Jan Nikitenko wrote:
> I am not sure about the meaning of spi message transfer cs_change attribute.
> 
> I assume that non-zero cs_change indicate that chipselect should be
> toggled between spi_transfers.
> 
> What about cs_change in last spi_transfer of spi_message?
> Should zero cs_change provide hinting that chipselect should be left
> active, because spi_message to follow will be for the same spi device?

>From <linux/spi/spi.h>:

 * (i) If the transfer isn't the last one in the message, this flag is
 * used to make the chipselect briefly go inactive in the middle of the
 * message.  Toggling chipselect in this way may be needed to terminate
 * a chip command, letting a single spi_message perform all of group of
 * chip transactions together.

So you don't need to "assume" that first point.  For the second:

 * (ii) When the transfer is the last one in the message, the chip may
 * stay selected until the next transfer.  On multi-device SPI busses
 * with nothing blocking messages going to other devices, this is just
 * a performance hint; starting a message to another device deselects
 * this one. 

Yes, hinting.  However, in the case where there's some way to
establish exclusive access to that bus, it can do more:

 		But in other cases, this can be used to ensure correctness.
 * Some devices need protocol transactions to be built from a series of
 * spi_message submissions, where the content of one message is determined
 * by the results of previous messages and where the whole transaction
 * ends when the chipselect goes intactive.

(Where "other cases" means the converse of "multi-device SPI busses"
with "nothing blocking messages" ... either single-device busses, or
ones with such blocking.)


> If that is so, the handling in spi_bitbang.c would be incorrect, because
> chipselect would be deactivated when cs_change==0.

It's correct as-is:

    if (!(status == 0 && cs_change)) {
        ... set chipselect to INACTIVE
    }

That is, it always goes inactive unless the message as a whole
succeeded (status == 0) *and* cs_change == 0.


> Or is the meaning of cs_change in the last spi_transfer of spi_message
> different than in previous spi_transfers in single spi_message?

I don't understand your "or" here.  It's explicit that it means
something different there ... end-of-message chipselect semantics
are *always* different from semantics internal to the message.  All
that flag does is -- consistently!! -- toggle the default behavior.


> Like cs_change==0 in last spi_transfer would indicate to deactivate
> chipselect and cs_change!=0 in last spi_transfer would provide hinting
> that next spi_message will be for the same spi device and chipselect
> should be left active?
>
> If that is so, it's quite confusing (and not documented), as the meaning
> of cs_change in the last spi_transfer would be opposite than in other
> spi_transfers in single spi_message.

I'll disagree about lack of documentation.  It's quite clear there
are two cases -- (i) not-the-last, and (ii) the-last.  And that the
normal behavior, cs_change==0, is (i) stay selected, (ii) deselect.
But cs_change==1 toggles that to (i) deselect, (ii) stay selected.

Confusing?  Maybe; but if you remember that what it changes is the
default chipselect *behavior* not its value, then it should be easy
enough to keep straight.  Having more bits to affect a single behavior
would IMO be a lot more confusing than just one bit toggling it.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
