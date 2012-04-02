From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
Date: Mon, 2 Apr 2012 18:19:16 +0100
Message-ID: <20120402171916.GG15197@opensource.wolfsonmicro.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
 <CAH+eYFC+q4xFuSdRBkO9nb0XZWU4pQ_yCyinMy2X3ds9WQd1kw@mail.gmail.com>
 <CACRpkda2zh=zR+A9bwhRXYHtQdFeUpiqG4d5g1i82mPCs1mXaQ@mail.gmail.com>
 <20120402101427.GA3172@opensource.wolfsonmicro.com>
 <20120402104357.GB24211@n2100.arm.linux.org.uk>
 <20120402113413.GA7560@opensource.wolfsonmicro.com>
 <20120402165742.GD24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Rabin Vincent <rabin@rab.in>,
	Grant Likely <grant.likely@secretlab.ca>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120402165742.GD24211@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 02, 2012 at 05:57:42PM +0100, Russell King - ARM Linux wrote:

> ARM PRIMECELL BUS SUPPORT
> M:      Russell King <linux@arm.linux.org.uk>
> S:      Maintained
> F:      drivers/amba/
> F:      include/linux/amba/bus.h

> not provide enough clues?  Should I delete all my entries in that file
> because the only people who look in there are spammers when the file is
> published on the web?

I did look in there and also in the git history which shows the same
information, hence my CCing you.  Linus introduced some doubt into my
mind that this might be something that went through arm-soc now rather
than via your tree even if you are still maintaining it as no specific
git tree or anything is mentioned there.

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPed+OAAoJEBus8iNuMP3dhNQP/07p8rgMV6qnSUbqMzqSoIR/
qNwzI/pBMofele2Wrd1HFl89ybQ56N6JulRUiz6Lw5egHVECEiOq4atPiBr28FX+
V4fvu8Gw6jrHwwPd4QsQWgYMiJlaV0055tVr/wYYtL4Byr+3o9J9+Il/BAbT/Dg1
6RyUjs4jVUJTnYqGMMqrnOHkSzr11jZAG7J6E0TcK93HlBiUQVfo7/Mp//eDGxeh
6GtLA+dSM83aRBMZJq9SwmGBQJqg5+f0n2qg3W4DhmKDPGEkjdCupGBMBcqIrnb+
M3a3Lg0grmFNoXWyhy3c7geb8LcCrbdJOZw48STxaEFgQ/LEXcEGqF7OWZxrbz1N
DWnBc+x47H02zsFuDJ6PpIK5dkonnlpEIcpGFTVsZjHNgukD6o5Qt0ipzPqaS6vA
OfmvLM42HoQmg7bav0vq4rgo+p7yOZsNUxZcFdPSFt3rLN4SfHhOhZ+nv1nAgkeW
Wi4Z3q6lI75TwGI0Na0gn9ScdrBotHO4c9faWs7RzOmbPkJmQvFSDDD2UyOoCuSn
PFlHZTC55XfdBr1UjItx07EYrk2zYzfaqIy6hVFpdx+imDUCk9D2la3b50QNGofp
aL0PEvHz502EvQNhuuDObS0R2U/DwnleknUBOVKSw6QS2+7vZisGBjis1U+NUQt4
IHQRLx2vUfj6B9Tu8GJl
=Fq4l
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--
