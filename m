From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 4 May 2015 10:36:34 +0200
Message-ID: <CAOMqctTexs9A5tY188xOBabnKAM51YSrkXqnn9vF83aOL1v1UQ@mail.gmail.com>
References: <20150428141630.GR22845@sirena.org.uk> <CAOMqctTNSgycy7K=ZMK9aaZGyybDT61e0Y6Fwf1jtoMbSVoNQQ@mail.gmail.com>
 <20150428171738.GY22845@sirena.org.uk> <CAOMqctSEAd-WeBRLabvDugN04XaqY6Y1UyO9UPLaTW9ce7t_rQ@mail.gmail.com>
 <20150429174059.GQ22845@sirena.org.uk> <CAOMqctQmpYmD0J9=o6FVjJhXBc8b+oGd7cNh5aH_fmgE3vk5+A@mail.gmail.com>
 <20150429180659.GT22845@sirena.org.uk> <CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w@mail.gmail.com>
 <20150430195829.GG22845@sirena.org.uk> <A92B1688-9A12-4462-BA02-AEEE197C0FF4@martin.sperl.org>
 <20150503095917.GQ22845@sirena.org.uk> <A1FB2CDB-6735-46B2-BB74-80F1B2033E23@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A1FB2CDB-6735-46B2-BB74-80F1B2033E23-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

On 3 May 2015 at 23:00, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
>
>> On 03.05.2015, at 11:59, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> Hrm, yes - that should work.  I'd ask Greg, that's not something the=
 bus
>> implements.
>
> It is still slightly more =E2=80=9Ccomplicated=E2=80=9D from a distri=
bution perspective,
> but if that is what makes it a =E2=80=9Cclean=E2=80=9D solution, then=
 that is the way to
> go forward.
>
> I will investigate the fine details, but I fear we may need some
> =E2=80=9Ccompatibility=E2=80=9D magic similar to =E2=80=9Cnew_id=E2=80=
=9D in USB to make it work,
> because it seems as if you can ONLY force a driver to bind if it
> _is_ compatible...
>
> See also here: https://lwn.net/Articles/143397/
>
> But from what I can tell this functionality (mentioned in this articl=
e
> by Greg) has not been moved into driver-core and bus, so we would nee=
d
> to run our own version of it.

Maybe you could make the spidev driver magically bind to any CS to
which no other driver is bound? This would also probably solve the
problem with the device going away when the driver is unbound if that
still happens.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
