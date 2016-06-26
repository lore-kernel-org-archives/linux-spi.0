From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Sun, 26 Jun 2016 14:39:20 +0200
Message-ID: <CAOMqctTf16DDs1j+pL47xBJt2BVdCdHPFUEwaZ6ak_vFtrKBOQ@mail.gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com> <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach@gmail.com>
 <20160626011500.GF28202@sirena.org.uk> <CAOMqctSA0G+fBKNgAizqWvEUfJLr9Fh0SsN0Pn-cQv=zeu7iFg@mail.gmail.com>
 <20160626112133.GJ28202@sirena.org.uk> <CAOMqctQernycZkc0Wia9EierT1PhfcYAPWc=89LgTC-DBgkg5A@mail.gmail.com>
 <20160626115815.GN28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>,
	Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>,
	Nikolay Aleksandrov <nikolay-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>,
	Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Adrien Schildknecht <adrien+dev-Yk6CzqVXkG6lnMjI0IkVqw@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160626115815.GN28202-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 26 June 2016 at 13:58, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sun, Jun 26, 2016 at 01:35:46PM +0200, Michal Suchanek wrote:
>> On 26 June 2016 at 13:21, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> > You can just add the entire slave node in the overlay, it's not clear
>> > that this buys us anything useful
>
>> You have to target the master node and specify the CS in the overlay
>> if you create the whole node. If you target the slave node you have
>> the CS specified in the board devicetree and the overlay can apply to
>> multiple boards without change.
>
> No, there's a lot more to having overlays to board-neutral connectors...

If you are fine with using only the SPI pins then this is all it takes.

If you want to know that i2c2 pins happen to be next to the SPI pins
on the connector and use them as GPIO pins for your SPI device reset
and irq lines then you will need a lot more infrastructure for that to
happen.

>
>> > and this needs to be joined up with the work going on to allow
>> > expansion connector overlays to be loaded in the first place.
>
>> The overlays work equally well before and after this patch. I don't
>> see any problem with them other than part of the infrastructure
>> missing in mainline kernel.
>
> ...you're missing all this stuff here - currently the active work on
> this is being done by Patelis.  It's not at all clear to me that
> referring to a slave rather than a master would be any easier in a board
> neutral overlay.

I cherry-picked one of his branches to try overlay loading. Anyhow,
most of the kernel support is already there. The missing part which
blocks any progress for a very long time already is importing DTC with
overlay support into the kernel and building the devicetree blobs with
overlay support.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
