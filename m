From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] of: spi: Export single device registration method and
 accessors (v2)
Date: Wed, 29 Oct 2014 12:22:04 +0000
Message-ID: <20141029122204.GG18557@sirena.org.uk>
References: <1414572037-11306-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20141029101420.GT18557@sirena.org.uk>
 <6A3753C0-251A-4645-AD96-CB1D6521175F@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tlm0M+DeSTNuB35b"
Cc: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jan Lubbe <jluebbe-H4yykcOXDpCzQB+pC5nmwQ@public.gmane.org>, Michael Stickel <ms-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Tull <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Michael Bohan <mbohan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>,
	Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joel Becker <jlbec-aKy9MeLSZ9dg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29Tb/PtFMR13I2A@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6A3753C0-251A-4645-AD96-CB1D6521175F-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tlm0M+DeSTNuB35b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2014 at 01:48:06PM +0200, Pantelis Antoniou wrote:
> > On Oct 29, 2014, at 12:14 , Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > This feels like there is an abstraction problem somewhere, whatever code
> > is supposed to use this is going to need to be taught about each
> > individual bus which is going to be tedious, I would expect that we'd
> > have something like the bus being able to provide a callback which will
> > get invoked whenever a new node appears on the parent node for the bus.

> There=E2=80=99s a whole patchset that does exactly this.=20
> Look at "OF: spi: Add OF notifier handler=E2=80=9D and you=E2=80=99ll whe=
re this is used.

I deleted that unread I'm afraid; one of the reasons that you should use
subject lines matching the styles for the subsystems is that it's one of
the things people use to filter out things that actually need attention,
if things are busy things that at first glance don't look terribly
relevant (like changes to the OF core in this case) are likely to get
looked at less urgently or just skipped.

A quick glance suggests that this is adding code inside the SPI core so
it's still not explaining why anything is being exported, can you
clarify please?

> > SubmittingPatches says.  Please also try to keep your CC list sane,
> > CCing random people just means that you're increasing the volume of mail
> > they have to process.  I'm surprised kernel.org accepts so many CCs.

> > I have to say I don't recall ever seeing v1...

> All of them are in the CC list for a reason.=20

This is a single, standalone SPI patch - you didn't send it as part of a
series (which is the only reason I read it).

--tlm0M+DeSTNuB35b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUNvrAAoJECTWi3JdVIfQ4A4H/1YvLCCSelky+9svlKbsYNYF
Bxw4veuiONfqqbnjsBNE+hwI5rNaKiJv4d3GgYUYa69i9SlDEU7JXYVE69ZYF3WO
zjFnJCcs4KeYiyzrjcyl5fgU+OACakDtQkOY6Ncn0HZqQPgfT67EU2Ov1fEMv4/f
1ofH7j5QTxaIECybBxF/7vhDWteK00wc0ThYSmtg9XMkGkYC0nOmJaodPktSbneu
OU9/0sFWahryla2pGT3wquGp+WsMWIfi7jZ6UA2v88cgEfuih9lHFY5GKa60KmOz
s7bqj/gNNHqeqGUr51Hdzc87fHGgqrltKeaTcsVZ3uapsAGNk9BQNYWTcRgtLuc=
=3pJ6
-----END PGP SIGNATURE-----

--tlm0M+DeSTNuB35b--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
