From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Tue, 28 Apr 2015 16:11:17 +0200
Message-ID: <CAOMqctTjbj0AoWcVJxc8PRX4LpOiDjhA5aXVEZQ1UQTnMC0Wxw@mail.gmail.com>
References: <bb069283a5c2ccfbc05177f1ed41cabb1485796e.1430034797.git.hramrach@gmail.com>
 <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather> <20150427101601.GN22845@sirena.org.uk>
 <20150427173036.GA10950@lukather> <20150427180728.GW22845@sirena.org.uk>
 <cd282abf-898a-4f01-90a6-8bf2db160b8e@googlegroups.com> <CAOMqctRTFgnVEKDAx4roMcGOeGV35Dyz7oOsOa4jC-MKr9_xXg@mail.gmail.com>
 <28a25eda-bba0-4a2e-9890-b3d3bef7ac7e@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <28a25eda-bba0-4a2e-9890-b3d3bef7ac7e-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 28 April 2015 at 16:03, Eric D. <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> I give Maxime's patch a try and got 4 spidev devices :
> /dev/spidev32766.[0-3]
>
> root@bpi:~# ls -lh /dev/spidev*
> crw------- 1 root root 153, 0 Apr 28 15:52 /dev/spidev32766.0
> crw------- 1 root root 153, 1 Apr 28 15:52 /dev/spidev32766.1
> crw------- 1 root root 153, 2 Apr 28 15:52 /dev/spidev32766.2
> crw------- 1 root root 153, 3 Apr 28 15:52 /dev/spidev32766.3
>
> Shouldn't they be numbered from like spidev0.[0-3].
> Is this an udev problem ? any clues ?

I don't know where the  32766 comes from but it's normal.

It seems to be the same number every time for the same port.

If you really wanted you could probably rename the device nodes with udev.

Or with only one spi bus enabled /dev/spidev*.0 should work too.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
