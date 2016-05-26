From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 00/12] J-core J2 cpu and SoC peripherals support
Date: Thu, 26 May 2016 01:42:19 +0100
Message-ID: <20160526004219.GA16172@sirena.org.uk>
References: <cover.1464148904.git.dalias@libc.org>
 <20160525095444.GR8206@sirena.org.uk>
 <20160525222441.GS21636@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>,
	Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160525222441.GS21636-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2016 at 06:24:41PM -0400, Rich Felker wrote:
> On Wed, May 25, 2016 at 10:54:44AM +0100, Mark Brown wrote:
> > On Wed, May 25, 2016 at 05:43:02AM +0000, Rich Felker wrote:

> > > As arch/sh co-maintainer my intent is to include as much as possible
> > > in my pull request for the linux-sh tree. If there are parts outside
> > > of arch/sh that can be included in this, please let me know. I'm not

> > Do *not* include the SPI driver, you shouldn't be including any drivers
> > unless it's been explicitly discussed with the subsystem maintainers.

> See the "please let me know". I thought this was plenty clear that I
> was asking for permission for including things outside of arch/sh, and
> that short of getting an ack, the default permission is no. You also
> snipped the part of my message that mentioned the specific subsystems
> I was asking about (which were non-SPI because you already made quite
> a point about not taking the SPI driver):

Given that you started off with "my intent is to include as much as
possible" and the general apparent lack of clarity about the process
it's really not sufficiently obvious to me based on your message that
this is clear to you.  The presentation of your message especially in
the context of the prior discussion suggests that it is expected for
things to go in at this point which haven't even been in -next yet and
that this is all perfectly normal, it is really not clear enough to me
reading it that you are looking for acks but instead sounds like you
might possibly intend to try to send anything that doesn't get
explicitly nacked.

It would really have helped to have some explicit mention of the fact
that you understand that what you are asking for is unusual and some
discussion of why you think it should still go in.  The best and
clearest thing to do would have been to post the series you were
considering sending as one series and everything else separately.  This
is one of the reasons why it was recommended to you that you should
split things up, it helps make things clear - the normal thing would be
that a series like this would be what you were planning to send.
Failing that another thing that'd have helped would be an explicit
mention of the bits you knew weren't going to be included in any pull
request.

> > end of the merge window and a new version is being posted.  The
> > turnaround times you are demanding on review are unreasonable - people
> > get busy, have holidays and so on - and you really need to pay attention
> > to what people are telling you about the process or you're just going to
> > annoy people.

> If you can't review and ack the code on short notice, that's fine;
> just say so. There's no need to be overerly hostile about it. I've

Since you were still talking about sending pull requests for this code
during this mergen window after the previous thread I want to be as sure
as I can be that you do understand the process and remove any hint of
ambiguity.

Note that you should not expect that people are going to send you an
explicit message about when they intend to review things and usually a
week is considered the lowest bound for chasing on things that aren't
urgent.

> gotten arch/sh patches during the merge window before and I try to be
> polite with the contributor and ask if there's something seriously
> broken that would be improved by my making an effort to check it at
> the last minute, or it if can happily wait until next time.

You're not a new contributor posting some patches here, you are talking
about sending pull requests as the architecture maintainer.  That's
rather different. =20

If you were just sending patches that would be fine and not at all
disruptive, that is a perfectly normal part of the workflow, but that's
not what's happening here.  I'm actually one of the people who's more
gung ho about applying things - I do tend to apply patches right up to
the wire and will carry on reviewing and applying new code through the
merge window (I looked at your first version after all) but only fixes
will get queued up for Linus, anything else that sits on topic branches
until after the merge window.

> Being that the driver in question here is for a new platform that was
> not previously supported upstream and has zero chance of breaking
> anything else, and that its inclusion would be a big plus for users of

Even if people aren't going to run the code it's buildable on other
architectures (as it should be so we can compile test things, do static
analysis and so on) and breaking the build or even introducing new
warnings during the merge window isn't helpful.  People build and test
things like all*config as a matter of routine and if those get broken
then that takes people's time can mask other issues.

> the platform, I don't see any reason for you making such a big deal
> out of it unless enforcing policy for its own sake makes you feel
> good, but I have better things to do than argue about it.

Like I say it's the bit where you're talking about sending pull requests
that's really flagging up here.

Most people's changes are important for them and only affect some
specific subset of platforms or systems which often aren't widely used
outside a given company but we still expect their changes to be in -next
before the merge window.  It's a lot easier for everyone to just follow
that rule, we have time based releases and things like -next available
so it is really not the end of the world to wait for one release, doing
this is fairer, minimises the risk of disruption for everyone and it
saves effort with evaluating the different bits of special pleading or
trying to rush to get reviews done quickly.

> > If you want people to review DT bindings you're going to need to submit
> > them.

> I have, twice now, and I Cc'd the the linux-spi list too on v3 for the
> spi binding. Rob Herring acked it.

To repeat what was said last time the code and binding need to be
reviewed together - they will generally be merged together.  This means
that you need to copy subsystem maintainers on bindings for their
subsystem along with the code, as a rule you should send the binding to
at least everyone you send the code to.  Sending things to the lists
alone is not enough to ensure they will be seen with the code using
them.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRkZqAAoJECTWi3JdVIfQRj8H/3X7MR53SWjEkSSu3C6F2rPF
30VMtnnmhJMObet4osvihfQbZVcrgxU44+4LFx62LtVxNze9EvKpVpFFH6eBwInV
G9/x0Cy3WJsFvMBDzU46tUILzRJ3bKdjHJ2sracID+NUhDK/WCaDQHgEdx7pDBXT
RI9LEaNLrpQrzajYZK6h4YoX4Zz+A54zRdVHjFurLLJav6k4ZH8Kv+grOsb7hGTJ
iFRBx4mvOZvBEPdWROs6/67uo+pruoYNfJ0UE/fwamxZsshUDy0hXewggr7ZKOJi
tbaoPesjWOIoDm5i3WnMHsS6G5spSrnRLzQRpnWLkCAgIDOa3/PcT994dByiWnk=
=TvCJ
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
