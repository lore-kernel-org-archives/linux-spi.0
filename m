From: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: add spi controller master driver for Blackfin 6xx
	processor
Date: Fri, 19 Jul 2013 18:22:11 +0800
Message-ID: <CAHG8p1BSg4ye-kL7fqzzRWbE0Nbi9jKU621my3kJNfPfUSprpA@mail.gmail.com>
References: <1371583828-23788-1-git-send-email-scott.jiang.linux@gmail.com>
	<20130619183928.GE1403@sirena.org.uk>
	<CAHG8p1AK_sp42mT+Hf1ZYn3iJy4_BO148v1YwXzw=H8hAn564A@mail.gmail.com>
	<20130719100815.GE9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	"uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130719100815.GE9858-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

>> > Should really use module_platform_driver() on modern systems, the
>> > deferred probe infrastructure should remove the need for faffing around
>> > with init order.
>
>> When I convert to use module_platform_driver(), I found some driver depend on
>> SPI_MASTER start up before spi master probe driver. So how can I control this
>> init order?
>
> Could you be more explicit about the dependencies here?  Are these other
> drivers using -EPROBE_DEFER as they should?

No, it returns ENODEV if spi_busnum_to_master(0) fail. It's a fb
driver and /drivers/video
is before /drivers/spi in link order. So I should do more work on this
fb driver instead of
spi master driver to make probe deferral mechanism work, right?

Scott

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
