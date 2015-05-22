From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] MTD: spi-nor: check for short writes in
 spi_nor_write.
Date: Fri, 22 May 2015 00:17:27 -0700
Message-ID: <20150522071727.GD23718@brian-ubuntu>
References: <cover.1430403750.git.hramrach@gmail.com>
 <50c40ef17ab6566f35ef5a4426bf23567f896db7.1430403750.git.hramrach@gmail.com>
 <20150520233835.GX11598@ld-irv-0074>
 <CAOMqctTYqDWL51twOuGi+oXONXQ4B2-2BkdJNSpzZAXshZUN6g@mail.gmail.com>
 <20150521102802.GS21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Bean Huo =?utf-8?B?6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, "grmoore-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org" <grmoore-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150521102802.GS21577-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 21, 2015 at 11:28:02AM +0100, Mark Brown wrote:
> On Thu, May 21, 2015 at 10:39:13AM +0200, Michal Suchanek wrote:
> > On 21 May 2015 at 01:38, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> Why is this thread about SPI error handling CCed to quite so many
> people?

I can't really speak for the original patch author, who created the CC
list. I added you for comment on the SPI API (thanks BTW).

This is part of a series that included an ill-conceived DT binding for
recording a "max transfer length" property in the flash node. That's one
step that easily blows up the CC list for the series, as there are 5 DT
maintainers and a mailing list. Others are contributors to the m25p80 /
spi-nor drivers. (All in all, you can probably trace this back to
scripts/get_maintainer.pl.)

> > >> Check the amount of data actually written by the driver.
> 
> > > I'm not sure if we should just reactively use the retlen, or if we
> > > should be communicating such a limitation via the SPI API. Thoughts?
> 
> > Is there any driver that would break if the SPI master truncated
> > writes when the message is too long rather than returning an error an
> > refusing the transfer?
> 
> Any such driver is buggy, the actual length transferred has always been
> a part of the SPI API.

OK, so m25p80.c currently checks the retlen
(spi_message::actual_length), but it doesn't actually handle it well if
the SPI master can't write a full page-size chunk in one go. It looks
like we'd leave holes in the programmed data right now.

So that qualifies as buggy, and that's part of what Michal is trying to
fix, I think. Admittedly, as he's using an out-of-tree driver, I'm not
sure I know exactly what failure modes he is hitting yet.

> We should probably expose limitations so clients
> can query in advance (we don't at the minute) but it'd be a while before
> clients could rely on that information being useful and it's still
> possible things can be truncated by error.

That might help in the long run. In this case, I think we might be able
to get by (for a properly-functioning SPI driver with a limited transfer
size) with the current API, and handling the 'return length < message
length' case better.

BTW, one extra note for Michal regarding your SPI controller/driver
transfer length limitation: you would do well to try as much as possible
to allow full NOR pages to be programmed in one SPINOR_OP_PP sequence. I
know of some SPI NOR that, though they are byte addressable, actually
have opaque internal ECC which is encoded on page boundaries, so you
get better flash lifetime if you program on page boundaries, rather than
on whatever smaller chunk size your SPI driver supports. So that might
require a little more work on your SPI driver.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
