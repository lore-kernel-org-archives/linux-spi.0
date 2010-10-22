From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] spi/bfin_spi: only request
	GPIO on first load
Date: Fri, 22 Oct 2010 01:25:45 -0600
Message-ID: <20101022072545.GA8205@angua.secretlab.ca>
References: <1287727308-26653-1-git-send-email-vapier@gentoo.org>
	<20101022063004.GA3311@angua.secretlab.ca>
	<AANLkTi=-yDBTJPhSgP7XjaKpqp7T+=inf5F1DCMZT4CZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=-yDBTJPhSgP7XjaKpqp7T+=inf5F1DCMZT4CZ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 22, 2010 at 02:41:12AM -0400, Mike Frysinger wrote:
> On Fri, Oct 22, 2010 at 02:30, Grant Likely wrote:
> > On Fri, Oct 22, 2010 at 02:01:47AM -0400, Mike Frysinger wrote:
> >> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> >>
> >> The gpiolib code does not allow people to do gpio_request() on a GPIO
> >> once it has already been requested. =A0So make sure we only request the
> >> pin on the first setup of a SPI device. =A0Otherwise, if you attempts =
to
> >> reconfigure a SPI device on the fly (like change bit sizes), the setup
> >> function incorrectly fails.
> >
> > Doesn't that mean that the gpio pin be requested at device probe time
> > instead of in a function that can be repeatedly called?
> =

> not sure what you mean.  this is a pin specific to a spi slave device.
>  there is no "spi probe" function for spi slave devices, only the "spi
> setup" function.

The spi master device is responsible for managing its own cs lines,
and it should know what they are at bfin_spi_probe time.  Looking at
commit d3cc71f7 which reworked the cs_gpio bits, I see that the
blackfin driver places the gpio information with the slave instance.

One could be argue that the spi_slave can be considered the owner of
spi ss lines, but that runs counter to current conventions, and
counter to how I want to implement common infrastructure for handling
gpio slave select lines.

I see that this patch is a bug fix, and the driver already implements
bad behaviour, so I have little choice but to pick it up.  However, it
is only a band-aid solution and in the long term it should be
refactored to store the gpio slave-select lines with the spi_master
device (probably after some common gpio-slave-select infrastructure is
put in place).

g.

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
