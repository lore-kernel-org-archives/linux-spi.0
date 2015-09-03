From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 8/9] spi: rockchip: modify DMA max burst to 1
Date: Thu, 3 Sep 2015 18:45:02 +0100
Message-ID: <20150903174502.GI5313@sirena.org.uk>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
 <1441101524-1700-1-git-send-email-shawn.lin@rock-chips.com>
 <20150903125429.GA12027@sirena.org.uk>
 <55E84E17.2090409@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mQQrPwpUFXnyQ/Ik"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Olof Johansson <olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55E84E17.2090409-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mQQrPwpUFXnyQ/Ik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 03, 2015 at 09:41:43PM +0800, Shawn Lin wrote:
> On 2015/9/3 20:54, Mark Brown wrote:

> >If this is a quirk of the DMA controller why is it being fixed with a
> >property specific to the SPI controller?  Can't the DMA controller just
> >override the burst size?

> Cool...that's a good question. Actually DMA controller can't do that since
> block peripheral controller(e.g sd/emmc, they always access data by
> block-512Bytes.) can't meet the case. So It's hard for dma controller know
> who is the caller, and what should be done.

You could take a guess based on request size, but that's going to be a
bit error prone I imagine.

> The only thing dma controller can do is avoid to execute DMAFLUSHP on its
> own. But how about peripheral controller trigger non-multiple access? So
> that's what I mentioned on covery letter that we should do "broken things"
> for both dma controller and some peripherals.

The other thing it could do is provide the information out via some
internal Linux API which the drivers could query instead of directly
having a DT property in each client driver.  That way at least the DT
only needs the quirk in one place even if the clients need to handle it
individually.

--mQQrPwpUFXnyQ/Ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6IcdAAoJECTWi3JdVIfQpHMH/3uUXqmELNJ+DjZAtIuTAML4
F3Ma1D3F1hxiZzEmlGNB9mI/VBZP4EhQ+NzHrc8Wn/pqIvuBumGqdrYj0MdnKhYn
FJ3olHfbAZtJ3a1vBtriGvPhRAbWUEqAYUuCoue4ZUfJ6vF81KttN6yjzO929209
iuUkQiqGZnLySLL1yqHbZb61ruABOSmOrgJR3qFU/72dJB7xDY61JIrzZxwGEsaB
fMrU4I4KsJPG3dl02upMA8G0X1LWnGe5AcKVdOxCGFj6swP1WyTtQyLLLqx1Ks31
8J6MlWZLHg7/b13dgfh+jsg+j2wYIODjmTlu8UhyZru0EBVTAbffjX8CPCR2/Xk=
=w/6n
-----END PGP SIGNATURE-----

--mQQrPwpUFXnyQ/Ik--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
