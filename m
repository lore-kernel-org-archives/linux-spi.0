From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 17:13:54 +0200
Message-ID: <CAMuHMdXev+8B6SE=PFVruSJb9yC09BT0bMLponHOM2Os6rLMZA@mail.gmail.com>
References: <20150426103257.GJ22845@sirena.org.uk>
	<CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
	<20150426110144.GK22845@sirena.org.uk>
	<553CCABA.3090504@redhat.com>
	<12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
	<CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
	<20150426125113.GF5627@lukather>
	<CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
	<20150426143359.GI5627@lukather>
	<553CF8F2.6070204@redhat.com>
	<20150427101016.GM22845@sirena.org.uk>
	<CAOMqctTivbDfvTO1dzVi+j=8JOvmGCdLOTnqb6U9R_TG8Hkypg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-sunxi <linux-sunxi@googlegroups.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi <linux-spi@vger.kernel.org>,
	linux-doc <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAOMqctTivbDfvTO1dzVi+j=8JOvmGCdLOTnqb6U9R_TG8Hkypg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 27, 2015 at 4:28 PM, Michal Suchanek <hramrach@gmail.com> wrote:
> When you have a serial port and just connect serial device to it with
> no special requirement you just specify the serial port in DT and talk
> to the device directly without any DT foo.
>
> When there is a BT module with reset lines and a kernel driver you
> write in DT that you have such and such BT module with such and such
> reset lines on the uart so the driver picks it up.
>
> Same for USB attached on-board WiFi - that some USB device needs
> special handling does not mean you have to specify your keyboard in DT
> to connect it to an USB port.
>
> What you are mandating here, basically, is equivalent of requiring a
> DT overlay to connect an USB keyboard or mouse because it is a device
> connected in hardware to the USB port and DT is supposed to describe
> the hardware.

Unlike the spi bus, the USB bus is a discoverable bus. So you can probe
for connected devices. No need to put them in DT (but you can, if the
firmware does the probing and updates the DTB. E.g. Open Firmware did
that for PCI (which was not hot-pluggable)).

Unlike the spi bus, you can (more or less) find out if a device is attached
to a uart, by listening to the bus, and waiting for a start bit.

I do agree that it would be nice to put the other end of the uart link in DT,
as you can't always know what you're talking to. Is it a modem? Is it a
printer? Is it a BT module? Is it Super Grover? Is it Mega Mindy?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
