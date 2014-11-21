From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH] of: spi: Export single device registration method and  accessors (v2)
Date: Fri, 21 Nov 2014 17:44:00 +0200
Message-ID: <CC185E77-95F6-4E4B-B431-59C9A9775453@antoniou-consulting.com>
References: <1414572037-11306-1-git-send-email-pantelis.antoniou@konsulko.com> <20141029101420.GT18557@sirena.org.uk> <6A3753C0-251A-4645-AD96-CB1D6521175F@antoniou-consulting.com> <20141029122204.GG18557@sirena.org.uk> <20141121153329.C4DDDC40D85@trevor.secretlab.ca>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>,
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
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141121153329.C4DDDC40D85-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

> On Nov 21, 2014, at 17:33 , Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> =
wrote:
>=20
> On Wed, 29 Oct 2014 12:22:04 +0000
> , Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> wrote:
>> On Wed, Oct 29, 2014 at 01:48:06PM +0200, Pantelis Antoniou wrote:
>>>> On Oct 29, 2014, at 12:14 , Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>=20
>>>> This feels like there is an abstraction problem somewhere, whateve=
r code
>>>> is supposed to use this is going to need to be taught about each
>>>> individual bus which is going to be tedious, I would expect that w=
e'd
>>>> have something like the bus being able to provide a callback which=
 will
>>>> get invoked whenever a new node appears on the parent node for the=
 bus.
>>=20
>>> There=C3=A2=C2=80=C2=99s a whole patchset that does exactly this.=20
>>> Look at "OF: spi: Add OF notifier handler=C3=A2=C2=80=C2=9D and you=
=C3=A2=C2=80=C2=99ll where this is used.
>>=20
>> I deleted that unread I'm afraid; one of the reasons that you should=
 use
>> subject lines matching the styles for the subsystems is that it's on=
e of
>> the things people use to filter out things that actually need attent=
ion,
>> if things are busy things that at first glance don't look terribly
>> relevant (like changes to the OF core in this case) are likely to ge=
t
>> looked at less urgently or just skipped.
>>=20
>> A quick glance suggests that this is adding code inside the SPI core=
 so
>> it's still not explaining why anything is being exported, can you
>> clarify please?
>=20
> I have the same question. This doesn't look like it should be exporti=
ng
> symbols.
>=20
> Also, the way the patch is written causes a lot of code changes to ge=
t
> interleaved in the diff. It would be better to split into two patches=
;
> one that creates the new of_register_spi_device(), and a separate pat=
ch
> to add the other new functions. It would be certainly easier to revie=
w
> that way.
>=20

The diff does make a mess of things; it=E2=80=99s not that complex of a=
 patch.

Your wish shall be granted. I=E2=80=99ll respin this over the weekend.

>>=20
>>>> SubmittingPatches says.  Please also try to keep your CC list sane=
,
>>>> CCing random people just means that you're increasing the volume o=
f mail
>>>> they have to process.  I'm surprised kernel.org accepts so many CC=
s.
>>=20
>>>> I have to say I don't recall ever seeing v1...
>>=20
>>> All of them are in the CC list for a reason.=20
>>=20
>> This is a single, standalone SPI patch - you didn't send it as part =
of a
>> series (which is the only reason I read it).
>=20
> Yes, this is part of the OF overlay series. It should have at least b=
een
> marked as [PATCH 7/8] and that it replaced the previous, buggy, patch=
 7.
>=20
> g.
>=20

Regards

=E2=80=94 Pantelis
