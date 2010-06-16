From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] drivers: spi-gpio: add support for
	controllers without MISO or MOSI pin
Date: Wed, 16 Jun 2010 13:52:21 -0600
Message-ID: <AANLkTimT_IHfv4dKXuvTpa8M4L_MDqIvjrDPBLgzKUWn@mail.gmail.com>
References: <1270118151-13286-1-git-send-email-m.szyprowski@samsung.com>
	<001701cb0180$60f0b320$22d21960$%szyprowski@samsung.com>
	<AANLkTilQ5yD16LAq4xEmXKAmrNqO8eWFh0BmHPd2cR0q@mail.gmail.com>
	<002b01cb0218$ddab68e0$99023aa0$%szyprowski@samsung.com>
	<AANLkTim-yZb55jAyOaQJ_pOnp-LcXh-wdzw4TKqAyfea@mail.gmail.com>
	<000301cb07a3$679c6ec0$36d54c40$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000301cb07a3$679c6ec0$36d54c40$%szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 9, 2010 at 1:14 AM, Marek Szyprowski
<m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hello,
>
> On Wednesday, June 02, 2010 11:00 AM Jassi Brar wrote:
>
>> On Wed, Jun 2, 2010 at 3:00 PM, Marek Szyprowski
>> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> > On Tuesday, June 01, 2010 5:00 PM Grant Likely wrote:
>> >> On Tue, Jun 1, 2010 at 5:48 AM, Marek Szyprowski
>> >> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> >> I'm not convinced this is the best approach. =A0I did look at it, but
>> >> decided not to merge it yet. =A0It adds code to the hottest path in t=
he
>> >> spi-gpio driver (not that this driver will ever be fast, but on
>> >> bit-banged gpio, every instruction counts).
>> >
>> > If this is really a problem I can remove the 'if (SPI_{MOSI,MISO}_GPIO=
 !=3D
>> > SPI_GPIO_NO_{MOSI,MISO})' checks. If we assume that the upper level of
>> the
>> > spi framework works correctly, these functions shouldn't be called if
>> > the pin is set to NO_GPIO (the master device has SPI_MASTER_NO_{TX,RX}
>> flags
>> > set).
>
> Ok. I've did a research and that SPI_{MOSI,MISO}_GPIO !=3D SPI_GPIO_NO_{M=
OSI,MISO}
> checks cannot be easily removed, because in each loop both getmiso() and
> setmosi() are called by the bitbang_txrx_be_* functions. I also understan=
d that
> this part of code is really hot and should be optimized as much as possib=
le.
>
>> As I pointed in the last thread, such peculiar platforms had better
>> assign some virtual gpio
>> for such non-existent miso/mosi, rather than imposing these extra
>> checks on most of the normal platforms.
>
> Creating a virtual gpio bank only for this case is also an overhead imho.
> GPIO SPI masters without RX line will be used by more than one machine, so
> some kind of a generic driver is imho needed.

It is overhead, but it is overhead in the right place.  It costs
nothing when it isn't called, and it is trivial to create a do-nothing
gpio number for simple gpio drivers.  Systems using gpiolib can even
share the same no-op gpio controller driver.

> Notice that the spi_s3c24xx_gpio.c driver already silently handles such
> NO_RX transfers and machines that use it depends on such behavior. I expe=
ct
> that this driver will be soon removed in favor of generic spi_gpio driver,
> once plat-s3c24xx will be finally converted to use generic gpio lib.
>
> What do you think about duplicating spi_gpio driver with my proposed chan=
ges
> as spi_gpio_adv? The original spi_gpio driver won't be modified at all, s=
o no
> performance lose will happen for machines that use it. For new machines t=
he
> developers will be able to select weather they need a high speed transfer=
s or
> a driver that supports some rarely used features.

I say no.  I don't think it warrants a duplicated driver, and the
dummy GPIO number is trivial to implement.  In gpiolib it would simply
mean setting aside one of the entries in the gpio_desc table; probably
at the top of the GPIO range so that existing users don't get broken.

>
> The other possibility would be to create a new version of the bitbang_txr=
x_be_*
> functions for NO_TX and NO_RX cases. Then the proper function can be assi=
gned
> in spi_gpio_probe(). However this would increase the size of spi_gpio dri=
ver
> significantly.

Not that significantly, and it would keep all the relevant code
together.  I'm more in favor of this approach.

g.

---------------------------------------------------------------------------=
---
ThinkGeek and WIRED's GeekDad team up for the Ultimate =

GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the =

lucky parental unit.  See the prize list and enter to win: =

http://p.sf.net/sfu/thinkgeek-promo
