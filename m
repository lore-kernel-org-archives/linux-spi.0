From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bug in in spi-bcm53xx (rcu_sched) exposed by 0461a41 ("spi: Pump
 transfers inside calling context for spi_sync()")
Date: Wed, 10 Feb 2016 16:30:03 +0100
Message-ID: <CACna6rzHFx8VQs39gRGMKoF=P_t_MwGKQhUQb0O6x4OQeYrX5g@mail.gmail.com>
References: <CACna6rxQPv_Ut9NwN+BMbwSW+5-tJMoKXC3QWDfSP7zsCqfj7Q@mail.gmail.com>
	<20160210124828.GX13270@sirena.org.uk>
	<CACna6rzL-++_k68-VFQ4A9+gKHBJwhB5PJgU7wDwLQwi0vCCQQ@mail.gmail.com>
	<20160210131552.GY13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160210131552.GY13270-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10 February 2016 at 14:15, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Feb 10, 2016 at 02:04:21PM +0100, Rafa=C5=82 Mi=C5=82ecki wro=
te:
>> On 10 February 2016 at 13:48, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> > It's most likely just hammering the CPU for a very long time witho=
ut
>> > scheduling due to doing a long PIO transfers.  That change just re=
moves
>> > some needless context switching.
>
>> The fact is it happens only after flashing firmware, when flash is
>> formatted for the first time. After flashing some changes from ramfs
>> are likely flushed to the falsh. I guess it matches your theory of
>> long time CPU hammering.
>
> I bet you can trigger it with a heavy read load too (especially lots =
of
> reads going on in parallel).  You'll have always been able to trigger
> it, it's just that this has made it easier.
>
>> Any idea how to handle this?
>
> Don't busy wait in the driver, ideally implement DMA support.  Add so=
me
> sleeps if you really need to.  A PIO driver really isn't fit for purp=
ose
> with large transfers like you get on flash.

The only place with busy waiting seems to be bcm53xxspi_wait. I tried
adding cpu_relax() before udelay(5) as well as cpu_relax() at the
beginning of this function. I didn't chage anything. Should I raher
use some timer & sleeping/waking mechanism?

I'm afraid there isn't a real DMA available. It seems Broadcom uses
something called "Boot SPI". Enabling this mode maps flash content
into a memory, but it may be a bit complex to implement. It would
require flash driver to have better control over SPI controller and
I'm not aware of any existing API for that.

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
