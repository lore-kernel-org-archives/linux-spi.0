From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 1/3] dt-bindings: spi: Add DT bindings for Synquacer
Date: Wed, 17 Jan 2018 11:18:18 +0000
Message-ID: <20180117111817.GA9775@sirena.org.uk>
References: <1516021530-19236-1-git-send-email-jassisinghbrar@gmail.com>
 <1516021559-19327-1-git-send-email-jassisinghbrar@gmail.com>
 <CAL_JsqKM2OhdhFZfd_fhBkYiFE9Fdr38Xn7TKorwJo_-+f9xUg@mail.gmail.com>
 <CABb+yY3HEX6qMWxmirMnbwe3P5NwmUHGcuYypo-UzbUyUOi5UQ@mail.gmail.com>
 <CAL_JsqK16GXU0WQ2Ft2-_dHOH_y08inMjF8vHE4mhK0Zo9=JMg@mail.gmail.com>
 <CABb+yY1f=NwB_UmGAogTj2AgA5stk5zic39HJgTSJcv1rdcQVw@mail.gmail.com>
 <1516132926.25398.98.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Cc: "jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        "masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1516132926.25398.98.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 16, 2018 at 08:02:06PM +0000, Trent Piepho wrote:
> On Tue, 2018-01-16 at 08:59 +0530, Jassi Brar wrote:

> > Now the idea dawns that DT provide both clocks and the driver select
> > from the mux looking at speed requirements of the slave at runtime.

> add this feature at some point.  It might be simpler to just prefer
> HCLK if both are there.  The idea being that the DT should describe the
> hardware rather than tell the driver what to do.

Or only try one if the other fails to give something.

> Speed can be changed on a xfer by xfer basis on a single message to a
> single slave.  Trying to switch clocks during a message, if it requires
> resetting the whole block, sounds rather difficult.

In practice that's so vanishingly rare it's probably not worth worrying
about.

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpfMPYACgkQJNaLcl1U
h9DSUwf/SdBrUaeth5vl+Qfv4FvOgy5ve5YQ0ERiVasepBBLKNNNCai3h5+ixMZj
b5zOcXrZGq8mehJ3ii2zkBwuU713NTo2cbYT0ejgy9veN979X0bljs29SK0eAVoQ
RUYeHEKpmWPclK7mKApD/3Ah32jFSOG80RHvLlEmTge2S0nJ4NItJMlweW6T8hQd
J/m5IG1jHWldL+2d7fy8u542fqbMLkg8S/mRoO5Y5DX9YdLDbUOeAblozGaRr0/L
wmLz/ONNGTEi0ohfab1lzDeYSUQN74t4pySJFi2IXNBkxne9qv6rbHr8ZsKp0Zrc
B2ghj96ZUBVNtfMLQTr1KLLfkj0VNw==
=3Fe4
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
