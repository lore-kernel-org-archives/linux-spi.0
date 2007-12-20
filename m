From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 7/12] neo1973: JBT6K74 LCM control
	interface driver
Date: Thu, 20 Dec 2007 14:31:58 -0800
Message-ID: <200712201431.58932.david-b@pacbell.net>
References: <20071218110800.GN29882@prithivi.gnumonks.org>
	<200712191316.45435.david-b@pacbell.net>
	<20071220150659.GP29882@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071220150659.GP29882-jI4mzJ+yNOMOwssVsN95jSCwEArCW2h5@public.gmane.org>
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


> > Since this is a LCD controller, it should be living in the
> > drivers/video directory somewhere.   
> 
> Ok, no problem.
> 
> > Maybe in "backlight" and depending on LCD_CLASS_DEVICE like the
> > LTV350QV code.  (Which is not dissimilar to this LCM driver, although
> > that Samsung panel is much simpler.)
> 
> Well, the jbt6k74 driver does many things. But backlight switching is
> not part of it :) the backlight is completely independent and machine
> dependent.

The "backlight" directory is a bit misnamed, since it also holds
the LCD_CLASS_DEVICE stuff which is just "lowlevel LCD controls".
You'll observe the LTV driver controls power and gamma just like
this JBT driver does...

Of course there aren't yet many "lowlevel LCD controls" drivers,
and this driver might suggest revisiting that class.  There's one
LCD controller I know of with integral PWM contrast control, which
might help motivate relocating that class code.  How about a new
"lcm" directory?  :)


> > > +	default:
> > > +		return -1;
> > 
> > Why return "-EPERM" rather than "0"?  Are you trying to
> > prevent use of this driver on systems that support hibernation?
> > 
> 
> nope. I just didn't know what other cases there were, and since none of
> them are implemented, I thought it's better to refuse them than to claim
> we support something that was never tested.
> 
> I'm now following the suggestion of pm.h, i.e. treat all cases like
> SUSPEND.  Do you agree this sounds like the right thing to do?

Yes.  If it's not, then most Linux device drivers are
broken, and at least this one would be compatible!


> > > +static int jbt_resume(struct spi_device *spi)
> > > +{
> > > +	struct jbt_info *jbt = dev_get_drvdata(&spi->dev);
> > > +
> > > +	jbt6k74_enter_state(jbt, jbt->last_state);
> > > +	jbt6k74_display_onoff(jbt, 1);
> > 
> > I suspect that if the last state isn't DEEP_STANDBY this
> > should do nothing.  
> 
> Erm, you mean if the last state _is_ DEEP_STANDBY or SLEEP, it should do
> nothing?  Thansk anyway for pointing it out, there definitely was a bug.

I just meant that in a series of resume calls (matching the series of
suspend calls that will happen with hibernation), it's probably best
to do nothing if the device isn't in a suspended state.  And if the
system suspended while this device was in any kind of runtime suspend,
it should normally resume into that same runtime suspend state.


> > Remember that during hibernation, this can be called multiple times.
> 
> And how would this be a problem? Sorry, I don't get it :/

Waking up a power-aware system normally shouldn't force every device
into its highest power state.  I don't know how much runtime PM is
done on the systems you're working with, but I was assuming you do at
least some of it as a way to minimize battery drain.



> *************************
> 
> This driver adds support for the SPI-based control interface of the LCM (LCD
> Panel) found on the FIC GTA01 hardware.  
> 
> The specific panel in this hardware is a TPO TD028TTEC1, but the driver should
> be able to drive any other diplay based on the JBT6K74-AS controller ASIC.
> 
> Signed-off-by: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>

Looks much better IMO.  I still think that since this exposes
"low level controls" it should depend on LCD_CLASS_DEVICE, since
that's allegedly what that infrastructure is there for.  But I
expect that feedback would be resolved by folk maintaining that
part of the driver stack.

Also:


> +/* frontend function */
> +int jbt6k74_enter_state(struct jbt_info *jbt, enum jbt_state new_state)
> +{
> +	int rc = -EINVAL;
> +
> +	...
> +			/* first transition into sleep */
> +			rc = standby_to_sleep(jbt);
> +			/* then transition into normal */
> +			rc |= sleep_to_normal(jbt);
> +			break;
> +	...
> +	return rc;
> +}

This routine still has that error handling bug on most paths.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
