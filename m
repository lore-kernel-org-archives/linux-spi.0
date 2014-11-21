From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] of: spi: Export single device registration method and
 accessors (v2)
Date: Fri, 21 Nov 2014 16:53:26 +0000
Message-ID: <CACxGe6uwjzYs73bOCpij-dFHfJBfjj7f6T-eRivs7EdQaShAbg@mail.gmail.com>
References: <1414572037-11306-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20141029101420.GT18557@sirena.org.uk> <6A3753C0-251A-4645-AD96-CB1D6521175F@antoniou-consulting.com>
 <20141029122204.GG18557@sirena.org.uk> <20141121153329.C4DDDC40D85@trevor.secretlab.ca>
 <CC185E77-95F6-4E4B-B431-59C9A9775453@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
	Joel Becker <jlbec-aKy9MeLSZ9dg9hUCZPvPmw@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	Linux I2C <linux-i2c@vg
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CC185E77-95F6-4E4B-B431-59C9A9775453-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Nov 21, 2014 at 3:44 PM, Pantelis Antoniou
<panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org> wrote:
> Hi Grant,
>
>> On Nov 21, 2014, at 17:33 , Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>=
 wrote:
>>
>> On Wed, 29 Oct 2014 12:22:04 +0000
>> , Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> wrote:
>>> On Wed, Oct 29, 2014 at 01:48:06PM +0200, Pantelis Antoniou wrote:
>>>>> On Oct 29, 2014, at 12:14 , Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote=
:
>>>
>>>>> This feels like there is an abstraction problem somewhere, whatev=
er code
>>>>> is supposed to use this is going to need to be taught about each
>>>>> individual bus which is going to be tedious, I would expect that =
we'd
>>>>> have something like the bus being able to provide a callback whic=
h will
>>>>> get invoked whenever a new node appears on the parent node for th=
e bus.
>>>
>>>> There=E2 EURO (tm)s a whole patchset that does exactly this.
>>>> Look at "OF: spi: Add OF notifier handler=E2 EURO  and you=E2 EURO=
 (tm)ll where this is used.
>>>
>>> I deleted that unread I'm afraid; one of the reasons that you shoul=
d use
>>> subject lines matching the styles for the subsystems is that it's o=
ne of
>>> the things people use to filter out things that actually need atten=
tion,
>>> if things are busy things that at first glance don't look terribly
>>> relevant (like changes to the OF core in this case) are likely to g=
et
>>> looked at less urgently or just skipped.
>>>
>>> A quick glance suggests that this is adding code inside the SPI cor=
e so
>>> it's still not explaining why anything is being exported, can you
>>> clarify please?
>>
>> I have the same question. This doesn't look like it should be export=
ing
>> symbols.
>>
>> Also, the way the patch is written causes a lot of code changes to g=
et
>> interleaved in the diff. It would be better to split into two patche=
s;
>> one that creates the new of_register_spi_device(), and a separate pa=
tch
>> to add the other new functions. It would be certainly easier to revi=
ew
>> that way.
>>
>
> The diff does make a mess of things; it's not that complex of a patch=
=2E
>
> Your wish shall be granted. I'll respin this over the weekend.

I've fixed it in my tree by moving the match functions into the second
patch. The diffs are much easier to read now. I'll post the new
versions to the list shortly, but if you can test that would be
fantastic.

g.

>
>>>
>>>>> SubmittingPatches says.  Please also try to keep your CC list san=
e,
>>>>> CCing random people just means that you're increasing the volume =
of mail
>>>>> they have to process.  I'm surprised kernel.org accepts so many C=
Cs.
>>>
>>>>> I have to say I don't recall ever seeing v1...
>>>
>>>> All of them are in the CC list for a reason.
>>>
>>> This is a single, standalone SPI patch - you didn't send it as part=
 of a
>>> series (which is the only reason I read it).
>>
>> Yes, this is part of the OF overlay series. It should have at least =
been
>> marked as [PATCH 7/8] and that it replaced the previous, buggy, patc=
h 7.
>>
>> g.
>>
>
> Regards
>
> -- Pantelis
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
