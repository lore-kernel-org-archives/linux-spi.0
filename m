From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: add xtfpga SPI controller driver
Date: Wed, 12 Mar 2014 13:24:27 +0000
Message-ID: <20140312132427.GR28112@sirena.org.uk>
References: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
 <1394541891-26469-2-git-send-email-jcmvbkbc@gmail.com>
 <20140311194959.GB28112@sirena.org.uk>
 <CAMo8BfLTn+pneF6_7XkP66+LzpZgcefnAo_FkwxpvtYdt9yduA@mail.gmail.com>
 <20140312003401.GE28112@sirena.org.uk>
 <CAMo8Bf+dePYf0jW6zaH-4Qiy5oF-bBzHjkfzL1u6pyTS1OE46w@mail.gmail.com>
 <20140312011116.GJ28112@sirena.org.uk>
 <CAMo8BfKFp1kz8S_4JbSh5=f+hMygJL1670fkFfzdArgDqtW72A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vW5M6DBezn0Nx6aF"
Cc: "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>,
	Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMo8BfKFp1kz8S_4JbSh5=f+hMygJL1670fkFfzdArgDqtW72A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--vW5M6DBezn0Nx6aF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 05:48:16AM +0400, Max Filippov wrote:
> On Wed, Mar 12, 2014 at 5:11 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > So I just looked again - the SPI code isn't in mainline, there must
> > be some out of tree patches here that can't have been tested since the
> > driver was converted to regmap (or the byte swapping you're doing in the
> > controller is buggy for 16 bits per word).

> I'm successfully running this driver with the patches in your ASoC tree
> branch topic/tlv320aic23.

Ah, I missed that during review - the driver shouldn't be forcing 16
bits per word, any swapping that's needed should be being done in the
regmap API.  Though based on the discussion of the SPI driver it seems
like this may be compensating for an unwanted byte swap there.

--vW5M6DBezn0Nx6aF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIGAIAAoJELSic+t+oim99GIP/11mpaJ2nb6NDiMPuuMr3imb
mDmfRFPkQC0gaYL2DZ8icCBdcGJLTdBcTnUH9WxLvMz+x925DzcInZYdsqvOSVBy
vYkEkT6muBaQElia7FoWv/sEyoK/CRL6y+a6xevV+vCufPfLYJInKBwQE7tslZJM
2Vcw8dCuhV/39mdLmBub9Vc+6Iv8yTcLkOvvIK+cnI7Mb+VpyBA7pc9i0eeVo0vq
GX8eBNOceKF+WUDjk8WGu6oyXzGX+FWfuMPEDpbtpLdR3MEo9xgo3C+5zYCLLXJi
mpuKhAfBJ25vYRh+/Rt92uLquF0eMvgXF5qPZMLqLxUgrhf/Pj8L5iL3G+qUN1or
ck3YMqtkYf0u47UV27apLpuT8g/1Oni2EzRb2mMfVe1iKJj9cb22u7TnscmkTTjf
o+TbyzK2KLUvdMjEG0AqDVN7GH7kMBXRYrQXO8VFNJ+vdoEmB6MtnfIAU5P99GVM
y7HWz3WqE8jipJqZNV9fizf7lO5UKOhKJ/3dGErw9O31jRIyQRlaNZLs6TWShrwx
FLUML0Epc48Yx/R+IsxbgHavDLLLhD5djWmyvLlh9TudP9J4VsdkijkklZEHogfl
JUOu7gY2UmrFjfA6nYYOUXVgzYQPXAsEL4cH/wN3vt9T43kopRcfZ2GAyUlcHypg
+RCkxSxuN2h2wa9taptW
=RQdX
-----END PGP SIGNATURE-----

--vW5M6DBezn0Nx6aF--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
