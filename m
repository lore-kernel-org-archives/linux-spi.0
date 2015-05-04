From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 4 May 2015 12:42:03 +0200
Message-ID: <CAOMqctQq=CLsXf-RCrtJq5H9skdO1y4mV9iM2pOk69+voMiS0g@mail.gmail.com>
References: <20150428171738.GY22845@sirena.org.uk> <CAOMqctSEAd-WeBRLabvDugN04XaqY6Y1UyO9UPLaTW9ce7t_rQ@mail.gmail.com>
 <20150429174059.GQ22845@sirena.org.uk> <CAOMqctQmpYmD0J9=o6FVjJhXBc8b+oGd7cNh5aH_fmgE3vk5+A@mail.gmail.com>
 <20150429180659.GT22845@sirena.org.uk> <CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w@mail.gmail.com>
 <20150430195829.GG22845@sirena.org.uk> <A92B1688-9A12-4462-BA02-AEEE197C0FF4@martin.sperl.org>
 <20150503095917.GQ22845@sirena.org.uk> <A1FB2CDB-6735-46B2-BB74-80F1B2033E23@martin.sperl.org>
 <20150504101207.GR22845@sirena.org.uk>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, "Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBJE2TWVAKGQEUM4YLBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150504101207.GR22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 4 May 2015 at 12:12, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sun, May 03, 2015 at 11:00:40PM +0200, Martin Sperl wrote:
>
>> I will investigate the fine details, but I fear we may need some
>> =E2=80=9Ccompatibility=E2=80=9D magic similar to =E2=80=9Cnew_id=E2=80=
=9D in USB to make it work,
>> because it seems as if you can ONLY force a driver to bind if it
>> _is_ compatible...
>
> I'm confused.  What would the point of the functionality be if not to
> override the existing data, otherwise we'd already have bound the
> driver?

Presumably you can swap different versions of a driver this way.

Many devices have two drivers in Linux (old and new) which are
obviously both compatible.

Loading driver which is not compatible is something which you probably
do not want to be done easily as much as sending random junk to SPI
devices controlled by a kernel driver.

I am, of course, enjoying the ability to send some ID command to a
flash memory which is technically controlled by a kernel driver when I
physically replace the chip in the socket or the chip was not seated
well to start with and I want to check that it's working without
rebooting the board.

Thanks

Michal

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
