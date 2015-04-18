From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers
 shorter than 30us
Date: Sat, 18 Apr 2015 18:07:56 +0100
Message-ID: <20150418170756.GX26185@sirena.org.uk>
References: <20150410185132.GU6023@sirena.org.uk>
 <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org>
 <20150415185824.GU6023@sirena.org.uk>
 <262B0C8C-7728-458E-8748-06F79251BE0C@martin.sperl.org>
 <20150418104202.GA26185@sirena.org.uk>
 <54169601-55F7-464C-8A0E-ABF833C0F3BA@martin.sperl.org>
 <20150418115343.GI26185@sirena.org.uk>
 <EB2DE44C-29CA-422D-A89C-4173E02A2CEF@martin.sperl.org>
 <20150418122748.GO26185@sirena.org.uk>
 <2DB27253-8254-4098-ADE3-9AA22D52BE9D@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vo2ArcSjcOqS/fzO"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2DB27253-8254-4098-ADE3-9AA22D52BE9D-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Vo2ArcSjcOqS/fzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 18, 2015 at 03:31:13PM +0200, Martin Sperl wrote:

> > On 18.04.2015, at 14:27, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > That's probably fine, though the 40ms is a bit on the long side.  The
> > 30s timeout could use pulling in too, that's going to fail very badly if
> > anything does go wronng.

> Anything below 2 jiffies will give enough false positives during a kernel
> recompile - the original code has had 2 jiffies as the effective minimum,
> because the calculated delivery-time of max 30us is still orders of magnitudes
> smaller than a single jiffy, but a reschedule can happen, which would be the
> main reason why we have had triggered timeouts before.

Sure, but with the fallback to a much longer sleeping delay that'd be
covered transparently anyway - it doesn't matter if we don't always
manage to busy wait under load, what's more important is that we don't
fail the operation as a whole.

Actually if it's just scheduling that's a concern then one final check
after the time expires should do the trick shouldn't it?

> SO IMO anything shorter than 2-3 jifies would need to use a new framework to
> get access to high-resolution timers - and I do not know how to do that.

hrtimer_ is the high resolution timer stuff, though I don't think it's
really what you're looking for, it's more about async callbacks IIRC.

--Vo2ArcSjcOqS/fzO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMo9rAAoJECTWi3JdVIfQ354H/1hYNagQrJglw9FT8pGCZ2ya
8kbrT4SZCleLBl4JPg6YMURLJZMsowaFCy76ywlzNJ9o9PSe2TiGOEDqFEZymP+8
TK8mWTpWfgYOlkOs4N+YJ6aMk/skeEVXDBY6Qa9X/TjHuCIPLZNAxQGWRX0uUyGV
fQY/jdlRbxA2oIBtAXTfK28WO/jEZH5qqTYhXD3w/OUbNIKc1w7bBYzVDmFAt1Xb
T9uTyiQLiTjaijxbyGCg7uWz68w/tikNPEd1A10urv5pU0k1yLjoLSc1X5ls+GU5
WrdFYrMay+jmrJtViETHrWj/RGeub8S26w0VMGZ5dVu3iabW4AjAE+gXwU7ronA=
=0s+0
-----END PGP SIGNATURE-----

--Vo2ArcSjcOqS/fzO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
