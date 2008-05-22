From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: Accelerometer,
 Gyros and ADC's etc within the kernel.
Date: Thu, 22 May 2008 10:35:01 +0100
Message-ID: <48353E45.2080903@cam.ac.uk>
References: <4832A211.4040206@gmail.com>	<20080520132817.03fb74ea@hyperion.delvare>
	<200805211752.15670.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>,
	Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200805211752.15670.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Hi David,
> On Tuesday 20 May 2008, Jean Delvare wrote:
>> This all sounds quite different from our hwmon drivers. Our hwmon
>> drivers read all the sensor values at once and cache the readings for a
>> couple seconds, so you can't get an instant reading at any time, and
>> they also don't support interrupts in general.
> 
> That's something of an issue when the hardware monitor
> triggers alarms though, right?  I couldn't figure out
> how to get a TMP75 alert out to any userspace code that
> would care, to pick one example, even after teaching
> the i2c core how to handle SMBus alerts.  ;)
> 
> I suppose this just emphasizes the point made by Hans
> that we kind of need (industrial) "control" components
> (or "data acquisition"?) not just "monitoring" ones.
I get the feeling even the name is going to evolve for some time to come, 
getting broader as and when we add more classes of device.
> Such alarms are of course different from the "data
> ready" signals of an accelerometer.
Whilst this is true, most accelerometers also have "alarm" triggers, for example
the ST LIS3L02DQ will raise a pin on configurable conditions such as thresholds
and even a double click detector (though I've never tried them!).  I suppose we
will ideally support this functionality as well.
--
Jonathan Cameron

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
