From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] gpio: mcp23s08: convert driver to DT
Date: Wed, 6 Feb 2013 10:37:41 +0100
Message-ID: <CACRpkdawOE4WfUcCGpVSR9n5ZR9j1gFnMQ-EAOWOixcpM7uDUg@mail.gmail.com>
References: <1359647903-15801-1-git-send-email-larsi@wh2.tu-dresden.de>
	<CACRpkda_HjzWNMD1H_a_fsWtbRWuTDsutS8kndb9jY31qf7Yyg@mail.gmail.com>
	<20130205142909.4F5B83E1265@localhost>
	<201302061031.04264.poeschel@lemonage.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201302061031.04264.poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 6, 2013 at 10:31 AM, Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org> wrote:

> The thing that confused me was, that the platform_data for the chip has a
> mandatory "base" member, that sets the linux global gpio number at which the
> chip should appear.

Yes this is common. I think you should look at other drivers
under drivers/gpio using device tree, and how they work around
this.

As stated, as a last resort you can use AUXDATA to anyway assign
a piece of platform data per instance.

In the Nomadik driver, we use the block instance ID and multiply
by a factor of the numbers of GPIOs on each instance.
And luckily the base is zero. Not elegant maybe, but the
global GPIO numberspace is not elegant by nature.

Yours,
Linus Walleij
