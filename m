From: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH 7/12] neo1973: JBT6K74 LCM
	control	interface driver
Date: Fri, 21 Dec 2007 00:01:11 +0000
Message-ID: <1198195271.4651.52.camel@localhost.localdomain>
References: <20071218110800.GN29882@prithivi.gnumonks.org>
	<200712191316.45435.david-b@pacbell.net>
	<20071220150659.GP29882@prithivi.gnumonks.org>
	<200712201431.58932.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200712201431.58932.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Thu, 2007-12-20 at 14:31 -0800, David Brownell wrote:
> The "backlight" directory is a bit misnamed, since it also holds
> the LCD_CLASS_DEVICE stuff which is just "lowlevel LCD controls".
> You'll observe the LTV driver controls power and gamma just like
> this JBT driver does...
> 
> Of course there aren't yet many "lowlevel LCD controls" drivers,
> and this driver might suggest revisiting that class.  There's one
> LCD controller I know of with integral PWM contrast control, which
> might help motivate relocating that class code.  How about a new
> "lcm" directory?  :)

Backlights and lcd controllers mainly reside in drivers/video/backlight
although there are a number of backlight drivers spread about the tree.
I'm effectively the maintainer of the lcd class alongside backlights
since I've tried to keep the two roughly in sync style wise. 

> Looks much better IMO.  I still think that since this exposes
> "low level controls" it should depend on LCD_CLASS_DEVICE, since
> that's allegedly what that infrastructure is there for.  But I
> expect that feedback would be resolved by folk maintaining that
> part of the driver stack.

I'm not sure the LCD class would be very helpful to this driver. As you
say, this really suggests shortcomings of the LCD class but with only
one LCD driver in mainline changing that class to work better for LCDs
is possible.

The main question is whether the functionality here is suitably generic
to turn into a class? Personally I'm not sure it is but I'm open to
opinions (and patches).

Cheers,

Richard






-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
