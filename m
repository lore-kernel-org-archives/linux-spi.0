From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Accelerometer,
	Gyros and ADC's etc within the kernel.
Date: Wed, 21 May 2008 17:52:15 -0700
Message-ID: <200805211752.15670.david-b@pacbell.net>
References: <4832A211.4040206@gmail.com>
	<20080520132817.03fb74ea@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080520132817.03fb74ea-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Tuesday 20 May 2008, Jean Delvare wrote:
> This all sounds quite different from our hwmon drivers. Our hwmon
> drivers read all the sensor values at once and cache the readings for a
> couple seconds, so you can't get an instant reading at any time, and
> they also don't support interrupts in general.

That's something of an issue when the hardware monitor
triggers alarms though, right?  I couldn't figure out
how to get a TMP75 alert out to any userspace code that
would care, to pick one example, even after teaching
the i2c core how to handle SMBus alerts.  ;)

I suppose this just emphasizes the point made by Hans
that we kind of need (industrial) "control" components
(or "data acquisition"?) not just "monitoring" ones.

Such alarms are of course different from the "data
ready" signals of an accelerometer.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
