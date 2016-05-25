From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 00/12] J-core J2 cpu and SoC peripherals support
Date: Wed, 25 May 2016 10:54:44 +0100
Message-ID: <20160525095444.GR8206@sirena.org.uk>
References: <cover.1464148904.git.dalias@libc.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4CyH/NlNBqvsUTYP"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>,
	Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1464148904.git.dalias-8zAoT0mYgF4@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--4CyH/NlNBqvsUTYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2016 at 05:43:02AM +0000, Rich Felker wrote:

> As arch/sh co-maintainer my intent is to include as much as possible
> in my pull request for the linux-sh tree. If there are parts outside
> of arch/sh that can be included in this, please let me know. I'm not

Do *not* include the SPI driver, you shouldn't be including any drivers
unless it's been explicitly discussed with the subsystem maintainers.

Quite aside from the fact that like Geert says drivers are expected to
go through the subsystem trees to repeat what I said last time it wasn't
posted until after the merge window and we're now a few days before the
end of the merge window and a new version is being posted.  The
turnaround times you are demanding on review are unreasonable - people
get busy, have holidays and so on - and you really need to pay attention
to what people are telling you about the process or you're just going to
annoy people.

> arch, or for the DT binding patches. Even if some drivers are delayed
> going upstream, I would really like to get DT bindings acked and
> ideally merged, because we want to go ahead with moving the DTB into
> J2 boot rom where it belongs, and that should only happen with stable

If you want people to review DT bindings you're going to need to submit
them.

--4CyH/NlNBqvsUTYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRXZjAAoJECTWi3JdVIfQzHAH/iyYklTNVi/562dQ1XS+R/Xv
77ugl6A3S/Gs+2Gs89eDdVoNdF/eVR1u3dD6/1+Cqq7rUqdlMLBHdhkdkUbnU/7H
0ebnMcOoNVdbeAx69JOubypNptpzxJZlTCzaoTnSs00CIquJzR3Vq7kXtpPnZF0d
eZ9IJki/N0CfnGa6N4jmQ8QMFUY4seIaa79AvaOak62lQ+dS7Ggwrsyf1ZHP6hOJ
ll2atmPkLJPFnwJMDDE9CTIkZEZ3jFle2w0l81FMMUdYxlr5RDVsQxxzbsL2hovN
Q7K7N4kDJydhGww2GKbnxvCg1UidNQ2noyOAqbH6X5wT3IcVJ2TV6MmXLG7vg+o=
=COyp
-----END PGP SIGNATURE-----

--4CyH/NlNBqvsUTYP--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
