From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Mon, 27 Jun 2016 15:12:59 -0700
Message-ID: <20160627221259.GA10054@kroah.com>
References: <cover.1467053363.git.hramrach@gmail.com>
 <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
 <20160627190949.GB5111@kroah.com>
 <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jun 27, 2016 at 09:40:38PM +0200, Michal Suchanek wrote:
> On 27 June 2016 at 21:09, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> > On Mon, Jun 27, 2016 at 09:02:32PM +0200, Michal Suchanek wrote:
> >> The spi bus has no autodetection whatsoever. The 'detection' of the
> >> device that's suposed to be on the other side completely relies on user
> >> supplied information coming from devicetree on many platforms. It is
> >> completely reasonable then to allow the user to supply the information
> >> at runtime by doing echo 'somedevice' >
> >> /sys/bus/spi/drivers/somedriver/bind
> >> This fails if somedriver does not have in its id table compatible of
> >> somedevice so just skip this check for manual driver binding.
> >
> > That's what the new_id file is for, right?
> >
> 
> No. It's for buses that have some inherent identification. It's not for
> 
> 1) generate random compatible and stick it in device tree
> 2) reboot with new devicetree or load overlay
> 3) write the random compatible you just generated to new_id file so
> you can bind drivers to your device
> 
> You could have saved yourself a lot of hassle just ignoring the ID completely.

Um, all devices have to have an "id" the driver core enforces this.

Now your bus can ignore them, or do whatever it wants, but really, you
can't just try to wave them away.

> Do you have to go through that to connect a different modem to your
> serial port?

As has been said numerous times, there is no serial port bus, but people
are working on it.

And no, you don't, and serial _devices_ work just fine with the driver
model.

> Or even a new i2c device to i2c bus?

If you have an unknown i2c device, yes you do.

> also AFAIK new_id is not automagic and not all buses have it.

That's up to the bus to enable that option.  Just like you are creating
a new option.

> So it would have to be implemented on SPI. How? On PCI new_id is a PCI
> id. What is it on SPI? ACPI PnP id? DT compatible? How do you tell?
> And why when the bus does not even have IDs?

Then fake the id out, like all other dumb busses that don't have an id.

Again, I'm not going to take this driver core change, sorry.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
