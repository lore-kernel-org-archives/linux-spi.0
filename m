From: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
Subject: Re:
	display/lcm/backlight/framebuffer	interaction (was [PATCH
	7/12] neo1973: JBT6K74 LCM control interface driver)
Date: Fri, 21 Dec 2007 10:50:13 +0000
Message-ID: <1198234213.4636.39.camel@localhost.localdomain>
References: <20071218110800.GN29882@prithivi.gnumonks.org>
	<200712191316.45435.david-b@pacbell.net>
	<20071220150659.GP29882@prithivi.gnumonks.org>
	<200712201431.58932.david-b@pacbell.net>
	<1198195271.4651.52.camel@localhost.localdomain>
	<20071221093934.GO6625@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071221093934.GO6625-jI4mzJ+yNOMOwssVsN95jSCwEArCW2h5@public.gmane.org>
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

On Fri, 2007-12-21 at 10:39 +0100, Harald Welte wrote:
> On Fri, Dec 21, 2007 at 12:01:11AM +0000, Richard Purdie wrote:
> > Backlights and lcd controllers mainly reside in drivers/video/backlight
> > although there are a number of backlight drivers spread about the tree.
> 
> well, there alsi is drivers/video/display now, which is where I have put
> my driver now.  However, I'm not using the DISPLAY_CLASS, since it seems
> to deal mainly with contrast settings.
> 
> > I'm not sure the LCD class would be very helpful to this driver. As you
> > say, this really suggests shortcomings of the LCD class but with only
> > one LCD driver in mainline changing that class to work better for LCDs
> > is possible.
> > 
> > The main question is whether the functionality here is suitably generic
> > to turn into a class? Personally I'm not sure it is but I'm open to
> > opinions (and patches).
> 
> I think the power states and configuration parameters of different TFT
> panels (in embedded devices) are fairly device-specific.  Even the power
> states of different panels can differ a lot.  So I don't know how much
> common abstrction is possible to implement.

Agreed, I'm not sure how much common ground there is either.

> One thing that we still need for the Neo1973 is some kind of interaction
> betwee the display driver and the framebuffer driver.  The issue is that
> if we change the framebuffer resolution from VGA to QVGA, the display
> driver needs to alter the timing configuration of the display ASIC.

I had this problem with the Zaurus and ended up with
arch/arm/mach-pxa/corgi_lcd.c. It has two different mechanisms for
connecting into w100fb and pxafb. I would like to see a common method
for doing this and would be happy to change the corgi code to some kind
of common framework. A problem, at least with w100fb was that the
ordering of the calls to the LCD and w100 were quite critical, one wrong
move and it doesn't work...

> I was thinking of something abstact like a notifier_chain for resolution
> changes.  This way the display driver (and other potential users) can
> get informed about resolution changes. 

In the w100 case we ended up with change(), suspend() and resume()
function pointers. A call notifier could do the same job though. For
pxafb its just a case of LCD on/off...

> And then, after all, we have the issue of backlight, display and
> framebuffer all together.  If you want to blank the screen, you would
> want to switch off the backlight, but also put the display into a
> lower-power mode.  Right now we're not doing any of this in the kenrel,
> but I believe we definitely should.  Any suggestions on that?

The backlight class does have a hook into the framebuffer blank call
notifier chain (see drivers/video/backlight.c:fb_notifier_callback())
and this works very effectively.

The LCD class does also power down when the display is blanked through a
similar mechanism. One tricky problem here is working out which blank
call belongs to which display. In the end I left this problem to the
driver though the "check_fb" function pointer. On a device with a single
display there is no problem...

Adding a resolution change notifier chain does sound good, the LCD class
could then at least become useful for turning the LCD on/off and
blanking + resolution change notification.

Cheers,

Richard





-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
