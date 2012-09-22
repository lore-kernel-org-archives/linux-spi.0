From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH resend] spi core: Provide means to instantiate devices
	through sysfs
Date: Sat, 22 Sep 2012 12:11:33 -0400
Message-ID: <20120922161133.GU4495@opensource.wolfsonmicro.com>
References: <1347925880-13076-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1347925880-13076-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 17, 2012 at 04:51:20PM -0700, Guenter Roeck wrote:
> The I2C core provides a means to instantiate devices from userspace
> using sysfs attributes. Provide the same mechanism for SPI devices.

So, unlike I2C this is only going to work for a subset of controllers -
anything that relies on GPIOs for chip select will need more data to add
the chip selects for example.  This means I'm having a hard time getting
enthused about the idea, it seems like it might be a support burden.

------------------------------------------------------------------------------
How fast is your code?
3 out of 4 devs don\\\'t know how their code performs in production.
Find out how slow your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219672;13503038;z?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
