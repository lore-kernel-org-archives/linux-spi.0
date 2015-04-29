From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Wed, 29 Apr 2015 21:24:56 +0200
Message-ID: <CAOMqctQD8+bJevuOWRNx6LFfD_QXLGeNLqmVUhfsSdPrxyv6bQ@mail.gmail.com>
References: <20150427173036.GA10950@lukather> <20150427180728.GW22845@sirena.org.uk>
 <cd282abf-898a-4f01-90a6-8bf2db160b8e@googlegroups.com> <CAOMqctRTFgnVEKDAx4roMcGOeGV35Dyz7oOsOa4jC-MKr9_xXg@mail.gmail.com>
 <20150428141630.GR22845@sirena.org.uk> <CAOMqctTNSgycy7K=ZMK9aaZGyybDT61e0Y6Fwf1jtoMbSVoNQQ@mail.gmail.com>
 <20150428171738.GY22845@sirena.org.uk> <CAOMqctSEAd-WeBRLabvDugN04XaqY6Y1UyO9UPLaTW9ce7t_rQ@mail.gmail.com>
 <20150429174059.GQ22845@sirena.org.uk> <CAOMqctQmpYmD0J9=o6FVjJhXBc8b+oGd7cNh5aH_fmgE3vk5+A@mail.gmail.com>
 <20150429180659.GT22845@sirena.org.uk> <CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w@mail.gmail.com>
 <CAMuHMdXtL=-JWiXNbpwBEc+oMAVpBq1ShqZhFVKZRO_x9Xq4tA@mail.gmail.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBMPAQSVAKGQENL5VQDI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAMuHMdXtL=-JWiXNbpwBEc+oMAVpBq1ShqZhFVKZRO_x9Xq4tA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 29 April 2015 at 20:56, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Wed, Apr 29, 2015 at 8:37 PM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> I am using a version of Maxime's patch myself right now. It does not
>> seem it's going to be include in the kernel any time soon, however.
>>
>> FWIW I added the ability to open any CS, even those claimed by kernel
>> drivers. This addresses any potential race of spidev binding before
>> the actual driver but has the potential to introduce some subtle bugs
>> when you open and reconfigure a CS used by a kernel driver or send
>> some commands that upset the device.
>
> Uh, that sounds dangerous.
>
> Perhaps you can add some safety net, before user space can access
> them, cfr. /sys/class/gpio/export?
>

That's what accessing random devices from userspace is. I can issue
the identify commead to my SPI flash allright since it is idle.

I am not sure of its protocol details but I am quite sure that some
displays have data transfers that allow pauses so if I sent a command
during a screen update it would likely get inserted into the
framebuffer bitstream. And changing CS polarity or something like that
will certainly have interesting results.

Still not binding spidev to busy CS is just one test that can be
compiled in as an option. If things stay this simple I don't see much
problem with that.

Thanks

Michal
