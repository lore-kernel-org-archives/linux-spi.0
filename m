From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9] spi: rspi: Add missing clk_disable() calls in error
 and cleanup paths
Date: Mon, 13 Jan 2014 12:23:06 +0000
Message-ID: <20140113122306.GS29039@sirena.org.uk>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
 <1389525222-3482-2-git-send-email-geert@linux-m68k.org>
 <20140113115947.GL29039@sirena.org.uk>
 <CAMuHMdVjkWD0nP-9f579kUOqG4EVsy9Yp+vwNsM_=LxNU=Bdzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="APsrsY0yTFDXy1q8"
Cc: Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVjkWD0nP-9f579kUOqG4EVsy9Yp+vwNsM_=LxNU=Bdzg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--APsrsY0yTFDXy1q8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2014 at 01:17:18PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 13, 2014 at 12:59 PM, Mark Brown <broonie@kernel.org> wrote:

> > This doesn't seem to apply to current code, please check and resend.
> > The fact that there's multiple patch serieses in flight from you for
> > this driver plus development work (again mostly from you) in git is
> > probably not helping here...

> This depends on the series:

> [PATCH V2 0/8] spi: rspi: Add support for RZ/A1H

Please say if you're doing things like that, or ideally just send one
patch series since everything needs to be applied as one series - in
this case since the patch is a bug fix it ought to be going in before
anything else anyway.

--APsrsY0yTFDXy1q8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS09qnAAoJELSic+t+oim9V08P/iaKRz78a1WsjiKoIjLWFP18
RdAoBLyZvJtFVLdiMaJKSibsWA8T66kw/0or+K4WTL77NRUPGx0FUuiHkwDQhl4c
3oiFkyRMvtszBz9uZC3hoC7cpEOjiFV3ULCd4Jq9vwXL4xwqEMvyEOAJak9s0B9V
/6dTHui+3sxjujDdTnoQfbQqOeFcy/khOr0YtBrsACwLzJI8/QFpKD5UzSFBUeDq
WZq30Mf7hCum4U/RONmmNW/3OLG9BJeJx4QjrjMMzsfSs404HIPgrgLqSKbISv/X
BSmh8oXr2jL38s3eLkoqfsyEEUFQ9aIuTbX8q+2wJxsYf3SOhMn4YsAovp1vSvvA
oeEF6At3nOVBJcrMv19DXM1PVrBMk9+W4gLnBYb/7WsnWf5TywgW6kqMT7WYDCeE
MYYZHYZmPzR5XkYmmmNhFs9rrbEaDJQ00BDcZhRcQPq/sazBaoq8jOFoqckD52jd
vp6btdy8ow8XkXI9cslme662iC2mZoKsweolVD004U+C8gu/eBQ2GRhregl9QqYU
DqX3v6Ee6y/4bwSu3fdwUb02hvr9BBzxibct75ViSLSD5yr94PW3/33e+BVlnqDC
hR2vhexl+TI6ZrIKmPzAW7vAlLMuClJOvyJ+FZ0rAnbuXmA3n8n7JF15EIT5Y1Gj
/9kjwCWT2gnevxjgdAYc
=3xT+
-----END PGP SIGNATURE-----

--APsrsY0yTFDXy1q8--
