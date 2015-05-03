From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Sun, 3 May 2015 11:01:05 +0200
Message-ID: <A92B1688-9A12-4462-BA02-AEEE197C0FF4@martin.sperl.org>
References: <cd282abf-898a-4f01-90a6-8bf2db160b8e@googlegroups.com> <CAOMqctRTFgnVEKDAx4roMcGOeGV35Dyz7oOsOa4jC-MKr9_xXg@mail.gmail.com> <20150428141630.GR22845@sirena.org.uk> <CAOMqctTNSgycy7K=ZMK9aaZGyybDT61e0Y6Fwf1jtoMbSVoNQQ@mail.gmail.com> <20150428171738.GY22845@sirena.org.uk> <CAOMqctSEAd-WeBRLabvDugN04XaqY6Y1UyO9UPLaTW9ce7t_rQ@mail.gmail.com> <20150429174059.GQ22845@sirena.org.uk> <CAOMqctQmpYmD0J9=o6FVjJhXBc8b+oGd7cNh5aH_fmgE3vk5+A@mail.gmail.com> <20150429180659.GT22845@sirena.org.uk> <CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w@mail.gmail.com> <20150430195829.GG22845@sirena.org.uk>
Reply-To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 "Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
 Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
 linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBDYPB344UMGBBU6HS6VAKGQEDDV6PYI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150430195829.GG22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org


> On 30.04.2015, at 21:58, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> A big reason for that is that it's not in my inbox for me to review,
> these messages I flagged as unhelpful aren't going to help with that if
> only because I don't want to create the impression that such behaviour
> achieves results.
>=20

What about implementing it like this:
echo -n =E2=80=9Cspi32761.4=E2=80=9D > /sys/bus/spi/drivers/spidev/bind

Would this be an acceptable solution?

This is actually mentioned in Documentation/spi/spidev as a
possible option for the future - quote:

> (Sysfs also supports userspace driven binding/unbinding of drivers to
> devices.  That mechanism might be supported here in the future.)

Not sure why it does not work right now (but it works for =E2=80=9Creal=E2=
=80=9D
device-drivers), but I guess it has to do with compatibility checks.

Martin


--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
