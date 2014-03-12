From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: add xtfpga SPI controller driver
Date: Wed, 12 Mar 2014 01:08:58 +0000
Message-ID: <20140312010858.GI28112@sirena.org.uk>
References: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
 <1394541891-26469-2-git-send-email-jcmvbkbc@gmail.com>
 <20140311194959.GB28112@sirena.org.uk>
 <CAMo8BfLTn+pneF6_7XkP66+LzpZgcefnAo_FkwxpvtYdt9yduA@mail.gmail.com>
 <20140312003401.GE28112@sirena.org.uk>
 <CAMo8Bf+dePYf0jW6zaH-4Qiy5oF-bBzHjkfzL1u6pyTS1OE46w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdMKa9VhLDybADtF"
Cc: "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>,
	Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMo8Bf+dePYf0jW6zaH-4Qiy5oF-bBzHjkfzL1u6pyTS1OE46w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SdMKa9VhLDybADtF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 04:59:47AM +0400, Max Filippov wrote:
> On Wed, Mar 12, 2014 at 4:34 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > This driver is not actually compatible with the tlv320aic23 driver since
> > it needs 8 bit words, you need to at least support that.  You don't need

> That's strange, because the codec datasheet says the following (section
> 3.1.1):

> A control word consists of 16 bits, starting with the MSB. The data bits are
> latched on the rising edge of SCLK. A rising edge on CS after the 16th rising
> clock edge latches the data word into the AIC (see Figure 3-1).

> And tlv320aic23 has the following regmap:

> const struct regmap_config tlv320aic23_regmap = {
>         .reg_bits = 7,
>         .val_bits = 9,

Yes, and regmap will format that itself for transmission in 8 bit words
so you don't want the SPI controller to also do byte swapping.

> and its SPI interface accordingly does the following in .probe:

>         spi->bits_per_word = 16
>         spi->mode = SPI_MODE_0;
>         ret = spi_setup(spi);

That's buggy, drivers should never configure anything more than 8 bits
per word with regmap.

> > hardware in the controller to support a GPIO chip select, the whole
> > point is that the controller chip select isn't wired up and a GPIO is
> > used instead.

> Actually it's not GPIO. The controller asserts CS line once we set the
> start bit while the busy bit is cleared and deasserts it after 16 SCK
> pulses.

You're missing the point.  The controller chip select line can do what
it likes, it's not connected to the target device if a GPIO is being
used.

> > So fix that, but really it's trying to tell you that the hardware is far
> > too limited to work with many things.

> Ok. It's not designed to work with many things. Should I just move this
> driver to the rest of the platform code under arch/xtensa/platform/xtfpga?

No, not if you intend to use generic drivers with it.

--SdMKa9VhLDybADtF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTH7OnAAoJELSic+t+oim92r8P/3b63wg2LMOHJR7YnkbmzBpX
0n9FHSPKw81wL7dIbyFdzf0+i6NdK1Y0DveHWB0b3Eh/i+B4nQeWrigeQoJtUfiR
V/zbI+Yckwbc2cTecaZ/Fx+4QWnM854Y5ymxvOOQGvTGOeFrZr+pWqsPQZefkxmX
pgqO2zMZUKIADr3eoh2zewS0QtRbKJIaCtwXkUhe1n4gGaJ+PM0BgytcfeseqZOt
2cXi9phvlf+G5eqwYRZrn6/mQcsjcLSZ0nWJApygAYm2l5YDuHyaSb/Mg5wv//9C
pmAQYEpXdNKkjU5C9JwIhG8pwpdGkMi00dWTtys0yg2YVc7S631JWmTfSvUAkXxP
/xSQduxtTfBppq0kNie2YNeKQDDBO90La4Noc8Fk4qciNUH58cqJ6qfymgwfrvEs
oP3+qu/1XxkMic0r28YFamN0m4r2o49ZNbXcAbpG/C5VgxUSbbQJIKbmpr/LNt6j
t7BYRUPSzTQrLYWZ0zMJdoerpRdGj0lVgbcCj0uDIfG0/+TiVxLJntglX5lQoP+L
OGBn+IXJ3AbwMNbg+8b9cRxprdLbu486e08+fOQWpQrh/wfRhuZBll1QoomSensp
5lFXAPHjQ08JDpN4uRaDWLc/D3byoeMI/JbDHGEn/8CECXlRVXT0r6JG66ui+o4J
ePR9+gTaxPIxBSdIK4CM
=X3Sv
-----END PGP SIGNATURE-----

--SdMKa9VhLDybADtF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
