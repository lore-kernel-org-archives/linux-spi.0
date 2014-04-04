From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] devicetree: Add devicetree bindings documentation
 for Cadence SPI
Date: Fri, 4 Apr 2014 13:46:37 +0100
Message-ID: <20140404124637.GT14763@sirena.org.uk>
References: <1396523431-14519-1-git-send-email-harinik@xilinx.com>
 <1396523431-14519-2-git-send-email-harinik@xilinx.com>
 <20140403213446.GB14763@sirena.org.uk>
 <CAFcVEC+mpHh_d2j6_sdhWS3d2KyXrDYUq6L6jO2Q=SS68Hda2g@mail.gmail.com>
 <20140404100919.GO14763@sirena.org.uk>
 <CAFcVECLDyfFSZFk9fzFKsr6pM=f1nwzGAhjX17z=NsbvWpiDew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EOP8HhwRQvhZjZeP"
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFcVECLDyfFSZFk9fzFKsr6pM=f1nwzGAhjX17z=NsbvWpiDew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EOP8HhwRQvhZjZeP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2014 at 05:44:23PM +0530, Harini Katakam wrote:
> On Fri, Apr 4, 2014 at 3:39 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Fri, Apr 04, 2014 at 08:30:38AM +0530, Harini Katakam wrote:

> >> This IP can drive 4 slaves.
> >> The CS line to be driven is selected in spi device structure and
> >> that is driven by the software.

> > So why specify this in the binding at all?  If the device always has the
> > same number of chip selects it's redundant.

> I'm sorry, I should have explained that better.
> The IP can support upto 4 chip selects.
> The num-cs value here is the number of chip selects actually used on the board.

Why does that need to be configured?  Surely the presence of slaves is
enough information.

--EOP8HhwRQvhZjZeP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPqmpAAoJELSic+t+oim9R04QAI7uxIX6rvg8RPCBrtsMu9V4
14kUK42WQppfs05BN0DMCqNRPY/w7Et9k1grbaon7BjdZ0NVTyIuovxpYiPuHDWF
mzElgFWr5FExev8vLpiwac5W5GGc2z2ffmJd1tI4LyYvGMpqxP8xa1Qbj/wcq2pm
/5l63fR2k1UEPvtdzlvuG+Hf8fv7Jnkjbvt69M91dEJtiVixzuwxi9888KN+pSIY
D9UMSd7e/6nmSC3117p50mD6bb6YU/UDqGzS9BelOfZy/wiAswX5fQn3/83TC68u
cmAf7C/mUTuq60zhVyhFdb0PYEQ5COumye2SaKhfHymU+457xDF5ctNIZJjWPWHW
oRkQ3kOSn/mIyycBLfZAFs9bHqd++0exgWzod2ri3Hh1bJ39I9kzazXac9CO0Cwm
J6L1F6fML7+Vbr+s8XOjqtRfn3g/9TEXycQpEvE8d1SJKPHs5rG1uSFJTUl8E8S7
i4rl/QDJqAqJ0yx4OilSoAKisFQ0nrQ2T/9OJu4c2aWvCeOchdsP9ix7/VO959Le
3Jzs+YuGEzgM+ZzHRM9LKseftTAqK/wMo2tjS3FgsMKahlb9koxnnD9EBhxyRzVG
J8EDcN55uxsXOpaXK+vh5vk3Hhw87I/IIyWSjDRaoB6MRkKttO+FVxeHwV4wnEYh
YnC44F3xxQKtjbR97a97
=8/gz
-----END PGP SIGNATURE-----

--EOP8HhwRQvhZjZeP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
