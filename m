From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 01/12] spi/mxs: Always set LOCK_CS
Date: Wed, 10 Jul 2013 10:49:44 -0300
Message-ID: <CAOMZO5AEU3D3o-8fKLQJvsRSwBMNn0jfwZFC6R93TKaUpxffSw@mail.gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
	<201304030118.42976.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201304030118.42976.marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Apr 2, 2013 at 8:18 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> Dear Trent Piepho,
>
>> There are two bits which control the CS line in the CTRL0 register:
>> LOCK_CS and IGNORE_CRC.  The latter would be better named DEASSERT_CS
>> in SPI mode.
>>
>> LOCK_CS keeps CS asserted though the entire transfer.  This should
>> always be set.  The DMA code will always set it, explicitly on the
>> first segment of the first transfer, and then implicitly on all the
>> rest by never clearing the bit from the value read from the ctrl0
>> register.
>>
>> The only reason to not set LOCK_CS would be to attempt an altered
>> protocol where CS pulses between each word.  Though don't get your
>> hopes up if you want to do this, as the hardware doesn't appear to do
>> this in any sane manner.
>
> Can you please elaborate on this part above? The description is very vague.
>
> Fabio, can you review this too please?

Sure, it would be nice if Trent could resend this series and copy the
SPI maintainer, Mark Brown.

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
