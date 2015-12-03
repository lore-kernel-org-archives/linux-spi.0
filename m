From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: add initial set of spi_transfer transformation methods
Date: Thu, 3 Dec 2015 16:33:52 +0100
Message-ID: <9DF774BE-EA2B-40E8-9CBF-E0A06AB5A751@martin.sperl.org>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org> <1448888695-2260-3-git-send-email-kernel@martin.sperl.org> <20151201212929.GV1929@sirena.org.uk> <35C5C134-8291-4856-8916-7EDDFB07A0A9@martin.sperl.org> <20151203003618.GQ1929@sirena.org.uk> <91B0D66C-97E5-4683-8896-091C4BD7FCAF@martin.sperl.org> <20151203143417.GE5727@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151203143417.GE5727-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 03.12.2015, at 15:34, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> On Thu, Dec 03, 2015 at 07:22:10AM +0100, Martin Sperl wrote:
>>> On 03.12.2015, at 01:36, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
>>>> Rx/tx_dma is handled because it is there and it's address needs al=
so to be
>>>> accurately Shifted by that offset. I know that it is a depreciated=
 interface,
>>>> but as it is still there it needs to be supported...
>=20
>>> It's really quite broken already for most users.
>=20
>> If it is broken, then why not remove those members?
>=20
> There are still a couple of users and someone needs to go through and
> fix them.  I don't know which if any systems they run on, it's possib=
le
> that they manage to work as a result of the DMA mappings not getting =
in
> the way the systems they're being used on (if they're being used at a=
ll)
> or the controller drivers they're used with being equally aged.

So if we make use of this =E2=80=9Coptimization=E2=80=9D globally we wi=
ll need to support it,
otherwise we break it.

That was one of the reasons why I am advocating (for now) that we
make it an option that has to get enabled in the individual drivers.

But we could minimize the coding by providing a =E2=80=9Cdefault=E2=80=9D=
 implementation
that could get assigned to spi_master.prepare_message.

So an spi_master would only need to assign that, which makes it clear t=
hat
this has been tested with this specific HW (which is my biggest concern=
).

We could also create a separate spi_master.transform_message method, wh=
ich
the drivers assign to the default or custom implementation and which
(eventually) may get assigned a default if NULL and dma_alignment
as well as (the future) max_transfer_size is set.

The advantage of this would be that we could (at a later stage) move th=
e
invocation translation method to a different location - say: queuing it
in a different worker thread for translation when there are more than o=
ne
spi_message in the queue (if it is submitted from idle we would execute=
 in
place at somewhere in __spi_pump_messages).

Just exploring some options...

Would it make any sense to separate it out as described, so that we can=
 do
something like this later?

>> One last thing:
>> Where do you prefer to run those transfer transformations?
>> In the master-loop (before/after prepare message)?
>> During spi_verify (or after it)?
>=20
> Remember that we can't do any allocations in _verify() as it can run =
in
> atomic context so while we want to check if we can take the message t=
hen
> we are most likely going to be unable to implement transformations.
I came to realize that in the meantime as well - it was just an idea
how we could defer such things to a second CPU...--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
