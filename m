From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] spi/gpio: start with CS non-active
Date: Mon, 9 Jul 2012 22:18:59 +0200
Message-ID: <CACRpkdZsxgQgTACiFcwZBz31Zu07r1rqjT8UrmVZdBGs2W2ONA@mail.gmail.com>
References: <1328822505-7039-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20120705074540.GF5398@pengutronix.de>
	<20120709120806.GB28306@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	Uwe Kleine-K?nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120709120806.GB28306-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 9, 2012 at 2:08 PM, Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> wrote:
> On Thu, Jul 05, 2012 at 09:45:40AM +0200, Uwe Kleine-K?nig wrote:
>> On Thu, Feb 09, 2012 at 10:21:45PM +0100, Uwe Kleine-K?nig wrote:
>> > The chip select line was configured as output with the initial value
>> > being active explicitly. It was later deasserted during
>> > spi_bitbang_setup() without any clock activity in between. So it makes
>> > no sense to activate the device at all and the chip select line can
>> > better start non-active.
>> >
>> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> > ---
>> > Hello,
>> >
>> > I'm not sure if an active chip select line without any clock activity can
>> > confuse a device. If so, this patch might qualify as fix. But with my
>> > limited knowledge about spi it's also possible that I just miss why the
>> > active chip select is important. For the devices I have it doesn't seem
>> > to make a difference.
>> ping
>
> You probably want to resend this with Linus W in the CCs.

It all makes sense to me so:
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Now the SPI maintainer needs to pick it up though, if your proposal
to pick it up goes through this patch is all yours now.

Yours,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
