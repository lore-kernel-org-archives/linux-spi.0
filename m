From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: add statistics gathering and reporting methods
Date: Mon, 4 May 2015 16:25:01 +0200
Message-ID: <9A0ADDBC-5D5A-428F-B434-9CCB97505DCB@martin.sperl.org>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org> <1430741564-2849-2-git-send-email-kernel@martin.sperl.org> <20150504134226.GY15510@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150504134226.GY15510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 04.05.2015, at 15:42, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> This is unsuitable for sysfs as it is, sysfs is strictly one value pe=
r
> file.  debugfs would be a more suitable place for a file like this, o=
r
> if they are going to go into sysfs they should go in as a directory o=
f
> files with one value per file like the network device statistics
> directory.  I'm ambivalent about which is the best place, both have
> their merits.
that makes it much more complicated to add things per spi_master
implementation (which was my original idea: have a framework that expos=
es
the distinct transfer modes of the spi-bcm2835 driver (polling, interru=
pt
and dma driven) and also to get some stats on how often we run into tho=
se
=E2=80=9Ccorner=E2=80=9D cases - that is also why I want to gather the =
histogram
statistics, as it may make it easier to understand the use cases of peo=
ple
who complain about =E2=80=9Cperformance=E2=80=9D in case they share tho=
se infos=E2=80=A6

In those cases a single file is the easiest to share, but that is the w=
ay
it is with sysfs...

>=20
>> transfer-len-log2-histogram: 0 33 3 9 1 2 0 0 0 0 0 0 0 30 0 0 0
> It would be more friendly to print this out as an actual histogram wi=
th
> pretty printing, that's definitely a debugfs thing though.
I could make it more readable or - if split - run it with the same form=
at
as /sys/devices/virtual/block/ram0/stat - just multiple columns...

> It's a bit unclear to me that we need to collect the stats on both a
> per device and a per master basis, if we've got device statistics we =
can
> add up the various devices to get the master values easily enough whe=
n
> we need them.  It does mean that removing devices would discard some =
of
> the statistics but it's not clear to me that this is actually going t=
o
> concern anyone.
>=20
well - I found that it sometimes may help identify what device is respo=
nsible
for an issue on a mixed device bus.

> Do we really need the locked version with a separate lock?  I know
> you're very concerned about performance for some of your applications
> and the fact that we're going to be spending a lot of time taking a
> separate spinlock (with interrupt disabling... ) seems like it's goin=
g
> to be adding overhead we could live without.
>=20
I did not have it at first but was concerned that someone would complai=
n
about missing locking. That is why I have minimized the spinlock in the
loop.

That is easy to remove again...

> I can't help but feel that this would be a bit more legible without t=
he
> macro for adding to a field - just a function that takes the transfer
> and a stats buffer to add to.
just a bit more writing when counting twice=E2=80=A6

OK, so I will rework the patch looking into the above and will now put
everything into one single patch...--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
