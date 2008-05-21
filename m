From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Accelerometer,
	Gyros and ADC's etc within the kernel.
Date: Wed, 21 May 2008 09:49:42 -0400
Message-ID: <20080521093520.ZZRA012@mailhub.coreip.homeip.net>
References: <4832A211.4040206@gmail.com>
	<20080520132817.03fb74ea@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080520132817.03fb74ea-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Tue, May 20, 2008 at 01:28:17PM +0200, Jean Delvare wrote:
> Hi Jonathan,
> 
> On Tue, 20 May 2008 11:04:01 +0100, Jonathan Cameron wrote:
> > This email is basically a request for opinions on how and where such sensors
> > should be integrated into the kernel.
> > 
> > To set the scene...
> > 
> > Increasing numbers of embedded devices are being supplied attached MEMS
> > devices (www.xbow.com imote2 etc). Along with more traditional sensors such
> > as ADC's not being used for hardware monitoring, these do not really 
> > seem to
> > fit with in an particular subsystem of the kernel.  A previous 
> > discussion on
> > lkml in 2006 considered the accelerometers to be found within some laptop
> > hard drives, but I haven't been able to track down any more general 
> > discussions
> > of such non hardware monitoring sensors.
> > 
> > The obvious possibilities are:
> > 
> > * To place the various drivers within the spi / i2c etc subsystems as 
> > relevant.
> 
> Bad idea. Grouping drivers by connectivity is almost always the wrong
> thing to do, as it means that different persons will maintain them and
> they have all chances to diverge. You really want to group drivers by
> functionality. On top of that, I am busy enough maintaining the i2c
> core and bus drivers without having more i2c device drivers added to my
> plate. These days I am trying to _empty_ drivers/i2c/chips, if anything.
> 
> > * To place within the hwmon subsystem as this is probably closest.
> > (there is already at least one straight ADC driver in hwmon)
> 
> Probably not the wisest choice, if nothing else, because the hwmon
> maintainer is already overloaded. And I don't think that these devices
> have much in common with the traditional hardware monitoring components
> anyway.
> 
> I'm not sure what "straight ADC driver" you are referring to, but
> anything which measures a voltage and exports the reading to user-space
> is, well, a voltage sensor, and thus fix within hwmon. If the same chip
> is used for a higher-level, dedicated function then we would probably
> have a separate driver for it, outside of hwmon.
> 
> > * To create a new subsystem, or perhaps merely sysfs class to contain these
> >   elements.
> 
> Would be OK. Or:
> 
> * Place these within the input subsystem. You might want to discuss
> this with the input subsystem maintainer Dmitry Torokhov (Cc'd). The
> Wii remote is essentially a joystick, and joysticks belong to the input
> subsystem.
> 

I don't think that input subsystem woudl be the best choice. While we
do support the event-driven mechanism for delivering information to
userspace input is mostly oriented for human interface devices, not
general data acquisition. If anything input_dev is too fat. Another
thing is that input layer anonymizes input devices, makes them
capability-oriented. I.e. we dont really care what model of joystick
we have, we want something that reports ABS_X, ABS_Y, BTN_FIRE and
userpsace can use it whether it a simple analog joystick or something
fancy and USB connected. For your purposes you probably do want to know
what the device is and what exactly being sampled/measured.

I'd go with a lean and mean new subsytem.

-- 
Dmitry

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
