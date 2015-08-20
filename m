From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 18/18] spi: (RFC, don't apply) report OF style modalias
 when probing using DT
Date: Thu, 20 Aug 2015 16:25:17 -0700
Message-ID: <20150820232517.GZ12027@sirena.org.uk>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-19-git-send-email-javier@osg.samsung.com>
 <20150820183634.GN12027@sirena.org.uk>
 <20150820210822.GH74600@google.com>
 <55D64A65.7030905@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bWJzwVwZrZVVyQvz"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55D64A65.7030905-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bWJzwVwZrZVVyQvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2015 at 11:45:09PM +0200, Javier Martinez Canillas wrote:
> On 08/20/2015 11:08 PM, Brian Norris wrote:

> >> This is tagged as something that can't be applied but you've not
> >> explained why it can't be applied or what comments might be useful :(

> As Brian pointed out it was in the cover letter so I thought it would
> just be duplicated information. But you are right, I should had added
> a brief note as well just to make the patch self contained.

Right, a big part of what I was looking for was something about why this
is an incompatible change in the changelog so that once it gets applied
someone with out of tree code which gets broken can see what happens.
Plus...

> > I believe that's mostly addressed in the cover letter [1].

> >   Patch #18 changes the logic of spi_uevent() to report an OF modalias
> >   if the device was registered using OF. But this patch is included in
> >   the series only as an RFC for illustration purposes since changing
> >   that without first applying all the other patches in this series, will
> >   break module autoloading for the drivers of devices registered using
> >   OF but that lacks an of_match_table. I'll repost patch #18 once all
> >   the patches in this series have landed.

> > IOW, it's labeled as such mostly for safety, since it has quite a few
> > distributed dependencies.

Are there really only 17 drivers that are missing an explict of_table?
That seems like a low number.

--bWJzwVwZrZVVyQvz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1mHcAAoJECTWi3JdVIfQg5UH/Rgdm8+2rxNgQoHrvZFcbwBp
1eF9yTRzXzf3/Zp8nguzVSiHyfnaWk+0aTwYNQbr8aWYGhyWk/9p/H6dfIfcaw0a
8JOWdjUiLVrNMDY+if1ydl3ggmQ+w5N5txMS8xTR7l2gED6m+HTNZ9/Zhscbphfo
Nd0TFABSUfZ724stVadNQ2DzjhHYh6BqAIbQZh7Ki+6DRNmTsTUElVAdSwY7frIA
6kZICzzpcUqf6ZBc4+PJstAvqF6VZbKvThK6Bp+nMyW2/9C8r/vJ+lGXTqdNYCyQ
gE6nuukjBAHqcwpWNhfPDlklGFgBO57Sl3MtURRf904C4DrZ8nd3N6SrH8EVmSQ=
=Nm9E
-----END PGP SIGNATURE-----

--bWJzwVwZrZVVyQvz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
