From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: add xtfpga SPI controller driver
Date: Wed, 12 Mar 2014 01:53:42 +0000
Message-ID: <20140312015342.GL28112@sirena.org.uk>
References: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
 <1394541891-26469-2-git-send-email-jcmvbkbc@gmail.com>
 <20140311194959.GB28112@sirena.org.uk>
 <CAMo8BfLTn+pneF6_7XkP66+LzpZgcefnAo_FkwxpvtYdt9yduA@mail.gmail.com>
 <20140312003401.GE28112@sirena.org.uk>
 <CAMo8Bf+dePYf0jW6zaH-4Qiy5oF-bBzHjkfzL1u6pyTS1OE46w@mail.gmail.com>
 <20140312010858.GI28112@sirena.org.uk>
 <CAMo8BfL6dwgZitRBZQEU6HCRVMRoYhPkiJWW5QTpS-cu-njR5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xfe3G8JgwIlIkDdn"
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
In-Reply-To: <CAMo8BfL6dwgZitRBZQEU6HCRVMRoYhPkiJWW5QTpS-cu-njR5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Xfe3G8JgwIlIkDdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 05:43:49AM +0400, Max Filippov wrote:
> On Wed, Mar 12, 2014 at 5:08 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > That's buggy, drivers should never configure anything more than 8 bits
> > per word with regmap.

> Ok, so the driver should allow for 8 bit transfers and regmap will arrange
> transfers as 8-bit pairs, making CS to be asserted for 16 bits, right?

> Hmmm... I see the only way to support that with that hardware: advertise
> 8 bit support, buffer bytes up to 16 bits, send 16 bit words on CS deassertion
> request, log violations verbosely. Other ideas?

That's about it.  Like I keep saying for any sort of generic use you
really want to support 8 bits per word.

> > You're missing the point.  The controller chip select line can do what
> > it likes, it's not connected to the target device if a GPIO is being
> > used.

> In my case SPI controller is wired directly to the codec with three
> wires: SDIN, SCLK and CS. There are no registers that can control
> either of these wires independently of others.

Right, but other users are likely to exist and the framework has support
for this so it's not much work to support.

--Xfe3G8JgwIlIkDdn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTH74iAAoJELSic+t+oim99ZgP/2XblUxQAnMnwczoMFjcMCDV
8/k3lRBjIe/dYU8weCOAkgbEOCpp4s2jkogSIbaw44I6f16W8odIZc/gIcuatrfm
plWllTSF/BFPhQ5BCNLIfmTFNRndsHPDM21Df6hXU4P5P8ub0kqKyoeQ7xLO7bY4
eE1DOSZgwWNUNKO1oN2Gp4wNhLMurGP+CBTrttFdxLW44S64K0U1ZrC41yUiqPHK
Eme8YCw+9hKeb+8IY19JadSSIgPIdsOvvoAP3PIgosq25hytGQJ/PSf3XE7sCiA7
qcY9VwmiwhET/w+OSPGltRByXrFadJLFXieni5h6Z2AAucljv8lGRj2AcAHb1lD/
gK0+Ttn11V79+n1uzHl53H4s/g3kg2RFcQpVdROrokEFBlzClNSHdUBpusMeezGi
5HGfKEJRyHPEeH437mlvRveAwtCLsjHa7I8KFQ1lLYHEGtkK+XbQl9AQVAUrlxvv
ve4JlpFOHTcUSv1fyaB8X3m236zooOXRNlHnfS8yzRr8g8YH38RUw4jTM8BZ3kvn
KWD8dtp7bhmEVx48HprfmjaYh37NzJiIgRocgTAKDIwXRiPa0k2IbEzwa7g2KfDt
13GluGMhHeizDktISxISJGHs0sSt64boeUOaYOZGKrG1Q6A4VPkPmEkxmR5xzDIQ
dyBWFiujLYmWEuirYw2n
=TgE+
-----END PGP SIGNATURE-----

--Xfe3G8JgwIlIkDdn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
