From: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Subject: RE: SPI: DUAL/QUAD support
Date: Fri, 5 Jul 2013 06:45:01 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9E4C2E@DBDE04.ent.ti.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
	<20130704130017.GA25997@sig21.net>
	<OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
	<20130704154927.GE27646@sirena.org.uk>
	<OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>
	<CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mtd <linux-mtd-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Johannes Stezenbach <js-FF7aIK3TAVNeoWH0uzbU5w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Thomas.Betker-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org"
	<Thomas.Betker-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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


> Just as Johannes said. In my patch m25p80's changes is incomplete.
> Because my inicial aim is to add the transfer width member to tell controller
> the mode flash in. And I will attach new patch about m25p80 later.
> Also you are right. There are really series of flashes do not support dual/quad
> transfer. So I don't know whether there are any standard for serial-flash just
> like the CFI for parallel-flash. Personally, to make a general standard and
> a general code for serial-flash is necessary. So that we do not need to add
> special function in m25p80.c.
> 
[Pekon]: Does below generic framework for spianand, suit your driver?
http://lists.infradead.org/pipermail/linux-mtd/2013-July/047434.html

you should be able to extend the generic spinand API for all
serial modes (SPI, Dual-SPI, Quad-SPI).
As QSPI and Dual-SPI devices should implicitly support SPI (MISO/MOSI)
So, you can do device probing using default SPI mode. And then based on
DT inputs and device support upgrade to QSPI / Dual-SPI mode.
And going forward extend it for direct memory-mapped device for XIP.


with regards, pekon

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
