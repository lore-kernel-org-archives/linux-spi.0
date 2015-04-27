From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 16:28:36 +0200
Message-ID: <CAOMqctTivbDfvTO1dzVi+j=8JOvmGCdLOTnqb6U9R_TG8Hkypg@mail.gmail.com>
References: <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather> <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150426143359.GI5627@lukather> <553CF8F2.6070204@redhat.com> <20150427101016.GM22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-sunxi <linux-sunxi@googlegroups.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi <linux-spi@vger.kernel.org>,
	linux-doc <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20150427101016.GM22845@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 27 April 2015 at 12:10, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Apr 26, 2015 at 04:40:50PM +0200, Hans de Goede wrote:
>
>> Hi,
>
> Please always provide context in your replies so people know what you're
> talking about.
>
>> I've a feeling everyone in this thread is ignoring the
>> raspberry pi use-case. Where the board is specifically
>> designed for educational purposes and used with lots of
>> peripherals which are usually programmed from userspace
>> using e.g. python bindings for i2c-dev or spidev, for
>> such a setup we really want spidev to be loaded on the
>> spibus by default and we really do not have a proper
>> compatible for a child device.
>
> No, that's a different problem - the context you describe just happens
> to be your use case but it's in no way universal, there are plenty of
> expansion boards out there that have devices that use real drivers
> connected to them normally (and some of those could even be used in the
> educational contexts you describe).  I think the underlying need here is
> either for a better way of registering things or better tooling around
> device tree overlays to address the usability issues.

No.

When you have a serial port and just connect serial device to it with
no special requirement you just specify the serial port in DT and talk
to the device directly without any DT foo.

When there is a BT module with reset lines and a kernel driver you
write in DT that you have such and such BT module with such and such
reset lines on the uart so the driver picks it up.

Same for USB attached on-board WiFi - that some USB device needs
special handling does not mean you have to specify your keyboard in DT
to connect it to an USB port.

What you are mandating here, basically, is equivalent of requiring a
DT overlay to connect an USB keyboard or mouse because it is a device
connected in hardware to the USB port and DT is supposed to describe
the hardware.

Thanks

Michal
