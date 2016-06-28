From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Tue, 28 Jun 2016 18:24:58 +0200
Message-ID: <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
References: <cover.1467053363.git.hramrach@gmail.com> <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
 <20160627190949.GB5111@kroah.com> <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
 <20160627221259.GA10054@kroah.com> <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
 <20160628155107.GP17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160628155107.GP17217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 28 June 2016 at 17:51, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jun 28, 2016 at 02:40:41PM +0200, Michal Suchanek wrote:
>
>> There is no hardware other than pin header. You are preparing a
>> factory image for a devboard with a pin header that can be used for
>> connecting SPI devices. Some devices have fine kernel drivers and for
>> these you prepare fine overlays. Some devices have fine userspace
>> drivers and you do NOT want kernel driver for them even if it is
>> available later on. What compatible do you put in the factory image so
>> that the user can just connect an external device and run a
>> corresponding application to use it?
>
> The answer is still the same here: if you've got a plug in module you
> need to load an overlay for that plug in module (see Pantelis' work for
> mechanisms to do that).  That overlay should describe the hardware in
> the standard DT fashion.  If the current way to support a given bit of
> hardware is with a userspace driver then you should add the compatible
> string for that hardware to spidev or join up the dots to allow that to
> be done at runtime and then do it at runtime.

No, no, no!

This is NOT about loading an overlay. This is about talking on the bus
without loading an overlay.

And this is NOT about adding a compatible for the device. Adding
compatibles for 10 different devices just to use an userspace driver
for them is ridiculous and nobody will do that. If that really turns
out necessary anyone will add the compatible for the fist device so
used and use it for any other device. Which gets us back to generating
random compatible. Which is even better than registering a compatible
that makes sense because then it cannot happen that somebody writes a
kernel driver for your device and you have to unbind it first.

>
> Repeating yourself over and over again is not going to help here, it's
> just going to make people more annoyed.  Please stop this.

Then please add something constructive to the debate rather than
repeating that users have to add compatible for devices used with
userspace driver. That's ridiculous from usability point of view and
so will never happen. At best workarounds for kernel obtuseness will
be used.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
