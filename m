From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sun4i: add DMA support
Date: Thu, 17 Mar 2016 11:58:39 +0000
Message-ID: <20160317115839.GG2566@sirena.org.uk>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
 <20160317072721.GJ30977@lukather>
 <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
 <20160317114308.GF2566@sirena.org.uk>
 <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dnvf+KcI+0MByPWJ"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Dnvf+KcI+0MByPWJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 17, 2016 at 12:54:08PM +0100, Michal Suchanek wrote:

> That's what the driver does. The discussion revolves around the fact
> that the driver does not attempt to work (even for very short
> transfers) when the DMA channels are not configured and just bails
> out. AFAICT the channels are always available when the system is
> properly configured and the dmaengine driver loaded.

The driver should tell the core about this constraint so the core can
split the transfers for it.

> Very few device drivers would work with 63byte transfers only and the
> code for manually driving the CS line in case the DMA engine fails to
> configure will necessarily go untested most of the time since most
> systems will have DMA configured properly.

A lot of devices will be perfectly happy with 63 byte transfers,
register accesses for example tend to be much smaller than that.  The
manual /CS might be an issue but for most SoCs that is easily addressed
by driving the pin as a GPIO if there's an issue.

--Dnvf+KcI+0MByPWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6pvuAAoJECTWi3JdVIfQTI0H/0qJ3bLq4du8sXxuXtJypJum
unmWRW1q+96LW2ETqPi6CWs/NQqdvr7Rv/v0PpgJqcCOjD5gLueVpeyexVIZCHS0
QQTtZ9qyHkvZ8JwvYMGataZFA/lQxtZw1cKAXrwdgsbFSjMZ/FOo7KPgB2vDDsfQ
GFYwZkZovVotsJ8ny6ek46HLy9YLY5ZdM9e/49bZDFD2BVgoBtEkIqinuGagS0G1
XGsm4mDofzht2urbB/dl6sm4s4D/P6cPZ7x+gpm99gMAkZxS0fudAjanRO1EnKJs
JPnTdrW0te5uSK6zjvQNwBw+rlA+2UMjzguQ6icTl7ts5b1HJEBOAYxbmaexSNU=
=Og60
-----END PGP SIGNATURE-----

--Dnvf+KcI+0MByPWJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
