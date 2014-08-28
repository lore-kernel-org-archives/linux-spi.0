From: Stijn Devriendt <highguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Linux 3.16: all my drivers on SPI bus report WARNING: at drivers/base/dd.c:286
Date: Thu, 28 Aug 2014 22:28:19 +0200
Message-ID: <CAOY=C6HxdLOPb6y=VCB_0VrSt_Vyc95nuMN_3ZDFSqoV=mAfEw@mail.gmail.com>
References: <53F31707.4040300@c-s.fr>
	<53FF5097.7090000@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	LinuxPPC-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: leroy christophe <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53FF5097.7090000-GgN8y9CXRhA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Aug 28, 2014 at 5:53 PM, leroy christophe
<christophe.leroy-GgN8y9CXRhA@public.gmane.org> wrote:
>
> I've been able to identify the origin of the issue. It happens since the below commit.
> Do you know what should be done to fix that ?
>
> Christophe
>
>

Actually, more things are wrong with what the driver is doing.
If inside spi_add_device() the call to device_add() fails, then that
code bails out without any call to spi_cleanup() and the same
memory will leak (Is this intended?).

Basically, fsl_spi_setup allocates memory using devm_kzalloc, while
device_add expects that any memory allocated via this way is only
done in the device's probe function.

The simple fix would be to do a normal allocation (revert the patch) and
add a free to the cleanup() function. Unfortunately that doesn't fix the
memleak I mentioned above.

So, some outside-the-box thinking brings me to conclude that another way
to fix this problem is to allocate the devm_kzalloc not on the device's
resource
list but on the controller's resources (it's controller state after all...).

Regards,
Stijn
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
