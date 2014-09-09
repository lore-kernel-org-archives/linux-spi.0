From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: davinci: add support for adding delay between
 word's transmission
Date: Tue, 9 Sep 2014 18:20:57 +0100
Message-ID: <20140909172057.GH2601@sirena.org.uk>
References: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
 <20140909165555.GD2601@sirena.org.uk>
 <540F3447.3020609@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sxKBPtypMsgSHGIi"
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>,
	santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <540F3447.3020609-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sxKBPtypMsgSHGIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 01:09:27PM -0400, Murali Karicheri wrote:
> On 09/09/2014 12:55 PM, Mark Brown wrote:
> >On Tue, Sep 09, 2014 at 07:07:31PM +0300, Grygorii Strashko wrote:

> >>- ti,spi-c2t-delay: Chip-select-active-to-transmit-start delay
> >>	(SPIDELAY.C2TDELAY)

> >>- ti,spi-t2c-delay: Transmit-end-to-chip-select-inactive delay
> >>	(SPIDELAY.T2CDELAY)

> >Now I look at these they look very much like the standard delay feature
> >that the SPI subsystem has already - are they?

> As Grygorii explained in previous postings (reproduced below), these delays
> are handled by the SPI hardware on Keystone and affect the delay between
> successive word tranmssion and has nothing to do with the delay you are
> talking about. Isn't the standard delay you mention here is between
> successive packets send down to the lower level driver (in this case
> spi-davinci.c) ?

He talked about such delays between words (and there were some other
delays listed which seemed to meet that description) but the above don't
appear to refer to them, the above refer to delays around chip select
which most definitely are covered with the standard delays.

If these delays are not related to chip select then the documentation
needs to be fixed to not refer to chip select.

--sxKBPtypMsgSHGIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDzbzAAoJECTWi3JdVIfQ9/kH/2gAH+/5KaTZvXZPdthTkNWq
r8wtU1eDR6VsNK4gcmUTCmNNOMtqZ7ilAm4hFWu7TT42P2BeyOQKtRc2sK9PM0Zl
CTdrQ/S/YOfwXoob0Fo+x3dDvbIltcwZjEfClfy7Vg/u+m3dRBPMP9DQlLZ+WM3A
fGtMD6n9nTvBSXVi5gW+rZEqM5eAIo/neDRgor677cZq6u1N0IC152eD8C9/5IoV
SfqE9gDaLQktgiBbRDG0Rgwk18zg5dRmr/XOyaHnGj1ewAqyL0p4UJWL3fUxm9yR
zlJNtyAClaTEuCqcYyy0DnLeccoQfCcD4F2+grNdBHRBKXxvX5LnIETYAjM+ZMo=
=AT0W
-----END PGP SIGNATURE-----

--sxKBPtypMsgSHGIi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
