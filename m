From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Mon, 27 Jun 2016 21:40:38 +0200
Message-ID: <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
References: <cover.1467053363.git.hramrach@gmail.com> <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
 <20160627190949.GB5111@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160627190949.GB5111-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 27 June 2016 at 21:09, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Mon, Jun 27, 2016 at 09:02:32PM +0200, Michal Suchanek wrote:
>> The spi bus has no autodetection whatsoever. The 'detection' of the
>> device that's suposed to be on the other side completely relies on user
>> supplied information coming from devicetree on many platforms. It is
>> completely reasonable then to allow the user to supply the information
>> at runtime by doing echo 'somedevice' >
>> /sys/bus/spi/drivers/somedriver/bind
>> This fails if somedriver does not have in its id table compatible of
>> somedevice so just skip this check for manual driver binding.
>
> That's what the new_id file is for, right?
>

No. It's for buses that have some inherent identification. It's not for

1) generate random compatible and stick it in device tree
2) reboot with new devicetree or load overlay
3) write the random compatible you just generated to new_id file so
you can bind drivers to your device

You could have saved yourself a lot of hassle just ignoring the ID completely.

Do you have to go through that to connect a different modem to your
serial port? Or even a new i2c device to i2c bus?

also AFAIK new_id is not automagic and not all buses have it.

So it would have to be implemented on SPI. How? On PCI new_id is a PCI
id. What is it on SPI? ACPI PnP id? DT compatible? How do you tell?
And why when the bus does not even have IDs?

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
