From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Sun, 26 Apr 2015 13:56:14 +0200
Message-ID: <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
References: <cover.1430034797.git.hramrach@gmail.com> <bb069283a5c2ccfbc05177f1ed41cabb1485796e.1430034797.git.hramrach@gmail.com> <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com> <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <553CCABA.3090504-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 26.04.2015, at 13:23, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> I think there is actual a use for just binding spidev as spidev,
> think e.g. the spi pins on the raspberry pi.
>=20
> How do you deal we suggest with such a situation ?

I actually asked the same question a few days ago on the spi list
(in thread: "spi: spidev: Warn loudly if instantiated from DT as =E2=80=
=9Cspidev=E2=80=9D)
and the summary was:

You can still do as before, but you have to accept that long=20
irritating warning.

Or you patch spidev.c to include your pattern of choice for compatiblit=
y

Or you implement the following proposal (which needs a volunteer):
> On 23.04.2015, at 09:42, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wr=
ote:
>=20
> So what you need is a way to handover from generic spidev to a device=
-specific
> driver, cfr. what graphics drivers do when the device has been bound =
to by
> vesafb or simplefb.
>=20
> Could this be implemented in a generic way in the spi or DT code?

=2E..
> On 23.04.2015, at 12:36, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Apr 23, 2015 at 09:45:16AM +0200, Geert Uytterhoeven wrote:
>=20
>> I guess this has been suggested before: the spi core could provide s=
pidev
>> access to all spi client devices which are not bound by a driver?
>=20
> I don't know if it's been suggested before, certainly nobody did the
> work to make it happen.  I don't think I have a massive objection in
> principal.


Martin



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
