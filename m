From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] spi: rockchip: limit transfers to (64K - 1) bytes
Date: Thu, 14 Jul 2016 20:09:00 -0700
Message-ID: <20160715030859.GA3360@google.com>
References: <1468546259-136659-1-git-send-email-briannorris@chromium.org>
 <131afa39-4287-0fb8-61f4-146283dc7cf0@rock-chips.com>
 <20160715023152.GA145248@google.com>
 <b855036c-86b3-3515-86ae-24de820564ff@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Eddie Cai <eddie.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, hhb-TNX95d0MmH7DzftRWevZcw@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b855036c-86b3-3515-86ae-24de820564ff-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jul 15, 2016 at 10:42:55AM +0800, Shawn Lin wrote:
> =E5=9C=A8 2016/7/15 10:31, Brian Norris =E5=86=99=E9=81=93:
> >So maybe there's a driver bug in the PIO path that gives us an
> >off-by-one error. I poked around a bit and couldn't figure out anyth=
ing,
> >so I sent this. Technically, this patch is still valid (even if not
> >optimal) for the DMA case too...
>=20
> Huibing is using pio to test this case, and we still achieve it
> successfully?

Are you saying Huibing has tested PIO with 64KB transfers, or is that a
question? If the former, it'd be great if he can publish the difference=
s
between his kernel and upstream to produce this.

> That means there may be some minor diff for the pio
> path between your chromium repo and my local branch.

This is an upstream kernel mailing list. I'd expect we can agree to tes=
t
on an upstream kernel...

> >want to unnecessarily limit the DMA case, then a last resort hack co=
uld
> >be to say:
> >
>=20
> Could you get spi-rockchip.c of rockchip local kernel 4.4 from Caesar
> to see if you could transfer 64KB with the one we're using?

I just compared with some (possibly old) copy of your vendor-kernel
driver, and there are a few moderate differences. I didn't test it yet.
I'd think the onus is on you to publish your changes though, if you
think you've fixed things in your own private tree...but I'm willing to
test any changes you recommend.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
