From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx_spi introduce chip
 select gpio to simplify the common cases
Date: Thu, 11 Sep 2008 09:32:45 -0400
Message-ID: <48C91DFD.5020308@whoi.edu>
References: <f17812d70809040221y477ec4x5c05460650266be8@mail.gmail.com>
	<200809081704.43404.david-b@pacbell.net>
	<48C64EBE.6090003@cam.ac.uk>
	<200809102308.31675.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200809102308.31675.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
> On Tuesday 09 September 2008, Jonathan Cameron wrote:
>>>  - It's probably worth removing support for the SSFRM
>>>    mechanism and requiring gpio_cs or (at least as a
>>>    transitional scheme) the cs_control() thing.
>> I disagree strongly with this.
>>
>> By all means issue a warning that cs_change will be
>> effectively 1 in all cases. However, with many real setups
>> this is absolutely fine. Leave getting this right to a
>> combination of the board config writers and some good
>> documentation!
> 
> My logic is as follows:
> 
>   (a) it's superfluous given that the pin used for
>       SSFRM can be managed as a GPIO;
>   (b) it's less capable than managing it as a GPIO,
>       examples being lack of SPI_CS_HIGH support
>       and broken cs_change;
>   (c) given (b) and what you noted, it's error prone;
>   (d) given (a-c) it's confusing
> 
> In short, removing this mechanism would improve quality
> and maintainability.  Needing *more* documentation for
> core functionality is a red flag.
> 
> Notice I'm not saying it can't (or doesn't) work, within
> its constraints (b).  I'm just saying that if it's removed,
> the driver will be better and won't lose *ANY* functionality.

I'm puzzled.  What is there about the pxa2xx_spi.c that would be
simplified by doing anything with respect to SSPFRM?  As I said in a
previous email: there is no "support" for SSPFRM in the driver, other
than quietly doing nothing if no CS action has been specified.  Maybe
you are thinking simplification elsewhere, like in board init code.

I agree that SSPFRM can be controlled as a GPIO line via the gpio_cs or
cs_control methods, but I don't see any "cost" associated with leaving
things as they are.  If use of gpio_cs were enforced, an existing
application that uses the SSPFRM function of the PXA2xx chip would have
to be carefully checked for proper use of cs_change (cs_change would
have been previously ineffective).  Like I said recently, I have a
narrow view of all this, so likely I am missing something obvious. :-)

On a related aspect:

By "broken" cs_change, are you referring to the lack of support for
SPI_CS_HIGH?  That could easily be handled the same way that Eric is
proposing for cs_assert/cs_deassert: by passing SPI_CS_HIGH, either
directly or indirectly, to cs_control (or, to avoid breaking existing
cs_control routines, to a new routine that users would be encouraged to
use).

I see little difference between the proposed gpio_cs and the existing
cs_control mechanisms, except that gpio_cs constrains the user to using
a gpio pin, while the cs_control callback allows the user to implement
any scheme for chip select.  While I know of no one doing this, it is
quite conceivable that a board could use an external expansion chip to
provide the physical pins used for chip select; in that case, cs_control
allows whatever code is required to to be executed to effect a CS
change, while the gpio_cs scheme does not.

Certainly, the gpio_cs mechanism reduces the burden of GPIO setup to
passing a single integer (the pin number, I assume), and this will be
sufficient for most boards, but it seems unnecessarily restrictive, if
it is the only mechanism.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
