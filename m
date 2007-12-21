From: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: Re:
	display/lcm/backlight/framebuffer	interaction (was [PATCH
	7/12] neo1973: JBT6K74 LCM control	interface driver)
Date: Fri, 21 Dec 2007 10:39:34 +0100
Message-ID: <20071221093934.GO6625@prithivi.gnumonks.org>
References: <20071218110800.GN29882@prithivi.gnumonks.org>
	<200712191316.45435.david-b@pacbell.net>
	<20071220150659.GP29882@prithivi.gnumonks.org>
	<200712201431.58932.david-b@pacbell.net>
	<1198195271.4651.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1198195271.4651.52.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

Hi RP, David, thanks for your continuos comments,

On Fri, Dec 21, 2007 at 12:01:11AM +0000, Richard Purdie wrote:
> On Thu, 2007-12-20 at 14:31 -0800, David Brownell wrote:
> > The "backlight" directory is a bit misnamed, since it also holds
> > the LCD_CLASS_DEVICE stuff which is just "lowlevel LCD controls".
> > You'll observe the LTV driver controls power and gamma just like
> > this JBT driver does...
> > 
> > Of course there aren't yet many "lowlevel LCD controls" drivers,
> > and this driver might suggest revisiting that class.  There's one
> > LCD controller I know of with integral PWM contrast control, which
> > might help motivate relocating that class code.  How about a new
> > "lcm" directory?  :)
> 
> Backlights and lcd controllers mainly reside in drivers/video/backlight
> although there are a number of backlight drivers spread about the tree.

well, there alsi is drivers/video/display now, which is where I have put
my driver now.  However, I'm not using the DISPLAY_CLASS, since it seems
to deal mainly with contrast settings.

> I'm not sure the LCD class would be very helpful to this driver. As you
> say, this really suggests shortcomings of the LCD class but with only
> one LCD driver in mainline changing that class to work better for LCDs
> is possible.
> 
> The main question is whether the functionality here is suitably generic
> to turn into a class? Personally I'm not sure it is but I'm open to
> opinions (and patches).

I think the power states and configuration parameters of different TFT
panels (in embedded devices) are fairly device-specific.  Even the power
states of different panels can differ a lot.  So I don't know how much
common abstrction is possible to implement.

One thing that we still need for the Neo1973 is some kind of interaction
betwee the display driver and the framebuffer driver.  The issue is that
if we change the framebuffer resolution from VGA to QVGA, the display
driver needs to alter the timing configuration of the display ASIC.

I was thinking of something abstact like a notifier_chain for resolution
changes.  This way the display driver (and other potential users) can
get informed about resolution changes. 

And then, after all, we have the issue of backlight, display and
framebuffer all together.  If you want to blank the screen, you would
want to switch off the backlight, but also put the display into a
lower-power mode.  Right now we're not doing any of this in the kenrel,
but I believe we definitely should.  Any suggestions on that?

Cheers,
-- 
- Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>          	        http://openmoko.org/
============================================================================
Software for the world's first truly open Free Software mobile phone

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
