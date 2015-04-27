From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 13:18:21 +0200
Message-ID: <CAOMqctREWR2m8juDn6xht66KBTYU9tNWT+D_qjm7KLHi91xqkA@mail.gmail.com>
References: <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather> <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150426143359.GI5627@lukather> <CAOMqctR5NiuZ2T3wYOpqu6Ez1yk7U9VoxDZHBT6uEqftRN_Z-g@mail.gmail.com>
 <20150426155404.GL5627@lukather> <CAOMqctT1sC5PWLLXr0By_-5GaJK0nKoGOxHiwpaFZtBFmWkDbQ@mail.gmail.com>
 <20150427100436.GP5627@lukather>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBJVW7CUQKGQE3EH6VQY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150427100436.GP5627@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 27 April 2015 at 12:04, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Sun, Apr 26, 2015 at 08:53:16PM +0200, Michal Suchanek wrote:
>> >> Also for driver prototyping you need a compatible which makes the
>> >> device accessible.
>> >>
>> >> If no spidev general compatible is available people will just use
>> >> compatible for some random device which happens to bind to spidev and
>> >> will send many letters of thanks to the DT maintainers when the device
>> >> used for this purpose suddenly grows a Linux driver.
>> >
>> > If people do dumb things, they should expect it to backfire.
>>
>> Yes, dumb things like not allowing people to say in the DT that the
>> board actually has pins on it connected to a SPI bus. Which is the
>> actual hardware which should be described in the DT.
>
> It's not connected to an SPI bus. It's connected to a device using an
> SPI bus. If you just had floating SPI lines, I'm pretty sure you
> wouldn't care about spidev at all.
>
>> Do you have to describe a modem or terminal emulator in DT to connect
>> it to your serial port? You just describe the port. So here you have a
>> SPI port and it should be described in the DT as faithfully as the
>> serial port.
>
> Except that in the serial port, you have a representation of a bus,
> while spidev represents a *device* connected on an SPI bus. So these
> are two different things, really.

No it's the same thing, really.

With serial you just have serial lines which you expose on a connector.

With SPI you have CS so you can technically have several connectors
for the same SPI bus selected by different CS.

So yes, making a spidev entry for the connector under SPI bus is the
equivalent of making an UART entry to specify that there is a
connector.

Thanks

Michal
