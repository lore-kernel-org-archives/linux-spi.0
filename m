From: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Subject: RE: support DUAL and QUAD[patch v1]
Date: Mon, 22 Jul 2013 09:56:24 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9EC9B1@DBDE04.ent.ti.com>
References: <CAHSAbzP0Nc1ahf_ra6yDuMvV998_+EGcUOGDv5ifKaagYf+NOg@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E84D2@DBDE04.ent.ti.com>
	<CAHSAbzMDOWo5oBqUHqMxybuDwUjFbczYwN+85gH+rxZ9z8u2Pw@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E851E@DBDE04.ent.ti.com>
	<593AEF6C47F46446852B067021A273D6D93B49E1@MUCSE039.lantiq.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E85D0@DBDE04.ent.ti.com>
	<CAHSAbzP5jqHwCm0qhu=DiNzpP0swqWHsQ0=MnF+EKaSN22E5hg@mail.gmail.com>
	<CA+7tXihoZZhpoyvxj58c+Zi-Zy631kK5s-kDoSxPKq=ej0qyvA@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E967D@DBDE04.ent.ti.com>
	<20130722093342.GJ9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org" <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130722093342.GJ9858-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> 
> > > Maybe it would make more sense to have a spi-rx-width and spi-tx-width
> > > than can be set to 1, 2, 4, etc. bits instead of a bunch of properties
> > > that are mutually exclusive?  Sooner or later someone is going to want
> > > 8 bits.
> 
> > Then it would not remain a serial interface (Serial Peripheral Interface),
> > rather it would be more of parallel memory like interface.
> > And you would not like to use SPI controller for it, instead you would use
> > On-chip General Purpose External Interface controllers (like GPMC)
> > because it gives you more options to tweak and configure.
> 
> It's still not beyoond the bounds of possibility, and of course some
> bright spark might decide to use 3 wires.  Unless it's expensive to do
> so in some way it seems better to keep the interface as generic as
> possible even if we've no expectation that some of the flexibility will
> be used.
> 
Ok.. Agreed,  I don't have any preference here between
"rx-width , tx-width" v/s "mode".
But please make sure that whichever implementation is chosen,
it should allow dynamic changing of channel-width.

Granularity should be based on following decisions:
(a) struct spi_message: if all transfers of same message follow same
 channel width. Example: All spi_messages from MTD layer would
use Qual-SPI only (both flash-commands and data).

(b) struct spi_transfer: if each transfer of same message need to be 
transferred at different width. 	Example: Command @ Single-SPI
 followed by Data @ Quad-SPI


with regards, pekon

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
