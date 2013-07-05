From: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Subject: RE: SPI: DUAL/QUAD support
Date: Fri, 5 Jul 2013 08:04:31 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9E4C7D@DBDE04.ent.ti.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
	<20130704130017.GA25997@sig21.net>
	<OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
	<20130704154927.GE27646@sirena.org.uk>
	<OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>
	<CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E4C2E@DBDE04.ent.ti.com>
	<20130705073550.GA24258@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mtd <linux-mtd-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Thomas.Betker-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org" <Thomas.Betker-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Johannes Stezenbach <js-FF7aIK3TAVNeoWH0uzbU5w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130705073550.GA24258-FF7aIK3TAVNeoWH0uzbU5w@public.gmane.org>
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

> > [Pekon]: Does below generic framework for spianand, suit your driver?
> > http://lists.infradead.org/pipermail/linux-mtd/2013-July/047434.html
> >
> > you should be able to extend the generic spinand API for all
> > serial modes (SPI, Dual-SPI, Quad-SPI).
> > As QSPI and Dual-SPI devices should implicitly support SPI (MISO/MOSI)
> > So, you can do device probing using default SPI mode. And then based on
> > DT inputs and device support upgrade to QSPI / Dual-SPI mode.
> > And going forward extend it for direct memory-mapped device for XIP.
> 
> Not sure what you have in mind since NAND and NOR flash work very
> differently, and SPI vs. memory-mapped is also very different.
> 
[Pekon]:  Opps.. Sorry for NAND v/s NOR confusion,
But I found generic framework for SPINAND (not in mainline) helpful
for us, so I pointed that..
I'm not sure about your end use-case, but I our QSPI controller supports
direct memory-addressable cpu-side bus-interface which can be enabled
for XIP support. So pointed out that here as-well..


> But to add to the spinand review comments two things caught
> my eye on quick glance over the code:
> 
> > +#define mu_spi_nand_driver_version "Beagle-
> MTD_01.00_Linux2.6.33_20100507"
> 
> seems like an unused leftover?  if the version number is
> important then maybe better put it in commit message?
> 
> > +/bin/bash: 4: command not found
> 
> how did this get in there?
> 
[Pekon]: Thanks.. Sourav needs to clean this up lot more.

with regards, pekon


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
