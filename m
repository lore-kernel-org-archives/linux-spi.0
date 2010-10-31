From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/bfin_spi: only request
 GPIO on first load
Date: Sun, 31 Oct 2010 00:07:23 -0400
Message-ID: <AANLkTikXyGQ9nQOtNT-ztveKNG71EdKox1tNeFix_=K0@mail.gmail.com>
References: <1287727308-26653-1-git-send-email-vapier@gentoo.org>
	<20101022063004.GA3311@angua.secretlab.ca>
	<AANLkTi=-yDBTJPhSgP7XjaKpqp7T+=inf5F1DCMZT4CZ@mail.gmail.com>
	<20101022072545.GA8205@angua.secretlab.ca>
	<AANLkTinFwZrtzPARy65oTnFgn2gxpniPXvONfWzjzF8z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <AANLkTinFwZrtzPARy65oTnFgn2gxpniPXvONfWzjzF8z-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 22, 2010 at 3:33 AM, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Oct 22, 2010 at 03:25, Grant Likely wrote:
>> On Fri, Oct 22, 2010 at 02:41:12AM -0400, Mike Frysinger wrote:
>>> On Fri, Oct 22, 2010 at 02:30, Grant Likely wrote:
>>> > On Fri, Oct 22, 2010 at 02:01:47AM -0400, Mike Frysinger wrote:
>>> >> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>> >>
>>> >> The gpiolib code does not allow people to do gpio_request() on a GPIO
>>> >> once it has already been requested. =A0So make sure we only request =
the
>>> >> pin on the first setup of a SPI device. =A0Otherwise, if you attempt=
s to
>>> >> reconfigure a SPI device on the fly (like change bit sizes), the set=
up
>>> >> function incorrectly fails.
>>> >
>>> > Doesn't that mean that the gpio pin be requested at device probe time
>>> > instead of in a function that can be repeatedly called?
>>>
>>> not sure what you mean. =A0this is a pin specific to a spi slave device.
>>> =A0there is no "spi probe" function for spi slave devices, only the "spi
>>> setup" function.
>>
>> The spi master device is responsible for managing its own cs lines,
>> and it should know what they are at bfin_spi_probe time. =A0Looking at
>> commit d3cc71f7 which reworked the cs_gpio bits, I see that the
>> blackfin driver places the gpio information with the slave instance.
>>
>> One could be argue that the spi_slave can be considered the owner of
>> spi ss lines, but that runs counter to current conventions, and
>> counter to how I want to implement common infrastructure for handling
>> gpio slave select lines.
>>
>> I see that this patch is a bug fix, and the driver already implements
>> bad behaviour, so I have little choice but to pick it up. =A0However, it
>> is only a band-aid solution and in the long term it should be
>> refactored to store the gpio slave-select lines with the spi_master
>> device (probably after some common gpio-slave-select infrastructure is
>> put in place).
>
> i disagree. =A0if any GPIO at all may be used as a CS, how could the SPI
> master driver have any idea at all what GPIO a slave might choose to
> use ? =A0or who is to say that the GPIO in question is available when
> the SPI bus master registers itself if the GPIO sits on a GPIO
> expander board (e.g. i2c) and not the SOC ?
>
> this is information that only the SPI client knows about and that the
> slave device is binding to. =A0putting slave information into the master
> resources makes no sense to me.

The arguement can be made in either direction.  From one perspective,
the GPIO is a property of the SPI controller because that is what is
responsible for fiddling with the bit (evidenced by the fact that the
GPIO number is being stored in controller data).  From another
perspective it could be seen as a property of the spi_device.
However, at some point a convention needs to be chosen, and the SPI
layer has tended towards SS lines being a property of the SPI
controller; regardless of whether or not it happens to be a GPIO line.

It isn't a critical issue now, but it will become more important when
the GPIO SS line handling is generalized so that the individual
drivers can be simplified.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
