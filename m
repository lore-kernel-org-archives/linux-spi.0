From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: Accelerometer,
	Gyros and ADC's etc within	the kernel.
Date: Tue, 27 May 2008 20:44:15 +0400
Message-ID: <20080527164415.GA27584@polina.dev.rtsoft.ru>
References: <4832A211.4040206@gmail.com>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
To: Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4832A211.4040206-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Hi Jonathan,

On Tue, May 20, 2008 at 11:04:01AM +0100, Jonathan Cameron wrote:
> This email is basically a request for opinions on how and where such sensors
> should be integrated into the kernel.
> 
> To set the scene...
> 
> Increasing numbers of embedded devices are being supplied attached MEMS
> devices (www.xbow.com imote2 etc). Along with more traditional sensors such
> as ADC's not being used for hardware monitoring, these do not really 
> seem to
> fit with in an particular subsystem of the kernel.  A previous 
> discussion on
> lkml in 2006 considered the accelerometers to be found within some laptop
> hard drives, but I haven't been able to track down any more general 
> discussions
> of such non hardware monitoring sensors.
> 
> The obvious possibilities are:
> 
> * To place the various drivers within the spi / i2c etc subsystems as 
> relevant.
> 
> * To place within the hwmon subsystem as this is probably closest.
> (there is already at least one straight ADC driver in hwmon)
> 
> * To create a new subsystem, or perhaps merely sysfs class to contain these
>   elements.
> 
> Typical requirements within an application include simply polling for 
> current
> readings, and using device triggered interrupts to grab data 
> continuously to a
> ring buffer, for collection by suitable userspace code.  Obviously it 
> would be
> desirable to standardize sysfs controls for various calibration 
> parameters as
> much as possible across the various devices.

Also, I'd mention that most ADC devices could report in "bunched" mode,
i.e.

1. Request ADC readings from pins X, Y, Z1, Z2.
2. Wait for single IRQ
3. Read all the results

At handhelds.org, we've wrote quite good (I think) ADC subsystem,
that keeps in mind ADC capabilities. It implements two interfaces:
in-kernel (e.g. for touchscreen drivers), and userspace interface via
sysfs. I was planning to implement drivers/input/ interface too.

I always don't find time to clean it up and submit, though.

Here is ADC subsystem itself:
http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/adc.c
http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/include/linux/adc.h
^ It is in drivers/misc/, but I think better placement would be
  drivers/adc.

Some drivers for this subsystem:
http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/ads7846_adc_ssp.c
^ ADC driver for ADS7846 chips (HP iPaq hx4700 and some HTC phones, the
  driver is using SSP subsystem, switching it to the SPI is still in my enless
  TODO list).

http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/samcop_adc.c
^ SAMCOP (HP iPaq H5xxx) ADC driver.

http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/tsc2200_adc_ssp.c
^ TSC2200 ADC driver (used AFAIK in some HTC phones, or ASUS handhelds).

http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/ad7877.c
^ AD7877 ADC driver (HTC phones too, IIRC).

Now, The Generic ADC Touchscreen Driver (tested to work quite good with all
above ADC drivers on appropriate hardware):
http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/input/touchscreen/ts-adc.c

And finally, ADC Battery driver ("backup" batteries in the iPaq devices
usually report their voltage via ADC chip, the same used by the
touchscreen).
http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/power/adc_battery.c

p.s.
I have more recent (for current Linus' tree) code for ADC subsystem, but
it still needs some love to be submittable.

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
