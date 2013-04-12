From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] SPI: spidev: Add DT compatible string for spidev driver.
Date: Fri, 12 Apr 2013 15:30:57 +0200
Message-ID: <51680C91.6030005@free-electrons.com>
References: <20130412125621.9645.78102.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Fuzzey <mfuzzey-mB3Nsq4MPf1BDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130412125621.9645.78102.stgit@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Martin,

Le 12/04/2013 14:56, Martin Fuzzey a =E9crit :
> The spidev driver is useful to allow userspace access
> to SPI devices that have no kernel SPI driver.
> =

> However DT requires a compatible tree to allow the driver
> to be probed.
> =

> To avoid having to modify the driver for every extra device
> add a generic "linux,spidev" compatible string that may be
> used in the DT to match such devices.

I submitted a similar patch quite some time ago [1], and at the time,
this patch was found inadequate, and we decided to add the compatible of
the particular device that we drive through spidev.

The rationale behind that is that the device tree is a hardware
description, so it's only interested about which device there is on the
SPI bus, and not the driver that will eventually handle it. That allows
both to have a meaningful devicetree, but also to easily handle the case
where a driver for that particular device is finally implemented, since
we won't have to change the device tree in itself to reflect this.

So I suggest you only add to the "real" compatible string instead of a
generic one.

Maxime

[1] http://comments.gmane.org/gmane.linux.kernel.spi.devel/11734

-- =

Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

---------------------------------------------------------------------------=
---
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
