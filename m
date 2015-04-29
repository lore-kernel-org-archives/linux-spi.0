From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Wed, 29 Apr 2015 20:56:26 +0200
Message-ID: <CAMuHMdXtL=-JWiXNbpwBEc+oMAVpBq1ShqZhFVKZRO_x9Xq4tA@mail.gmail.com>
References: <20150427173036.GA10950@lukather>
	<20150427180728.GW22845@sirena.org.uk>
	<cd282abf-898a-4f01-90a6-8bf2db160b8e@googlegroups.com>
	<CAOMqctRTFgnVEKDAx4roMcGOeGV35Dyz7oOsOa4jC-MKr9_xXg@mail.gmail.com>
	<20150428141630.GR22845@sirena.org.uk>
	<CAOMqctTNSgycy7K=ZMK9aaZGyybDT61e0Y6Fwf1jtoMbSVoNQQ@mail.gmail.com>
	<20150428171738.GY22845@sirena.org.uk>
	<CAOMqctSEAd-WeBRLabvDugN04XaqY6Y1UyO9UPLaTW9ce7t_rQ@mail.gmail.com>
	<20150429174059.GQ22845@sirena.org.uk>
	<CAOMqctQmpYmD0J9=o6FVjJhXBc8b+oGd7cNh5aH_fmgE3vk5+A@mail.gmail.com>
	<20150429180659.GT22845@sirena.org.uk>
	<CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w@mail.gmail.com>
Reply-To: geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBCQJP74GSUDRBW6SQSVAKGQETGUX43Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 29, 2015 at 8:37 PM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> I am using a version of Maxime's patch myself right now. It does not
> seem it's going to be include in the kernel any time soon, however.
>
> FWIW I added the ability to open any CS, even those claimed by kernel
> drivers. This addresses any potential race of spidev binding before
> the actual driver but has the potential to introduce some subtle bugs
> when you open and reconfigure a CS used by a kernel driver or send
> some commands that upset the device.

Uh, that sounds dangerous.

Perhaps you can add some safety net, before user space can access
them, cfr. /sys/class/gpio/export?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
