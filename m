From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 0/4 REPOST] OF infrastructure for
	SPI devices
Date: Mon, 28 Jul 2008 10:39:56 -0600
Message-ID: <20080728163956.GC21039@secretlab.ca>
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<200807271449.28472.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200807271449.28472.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jul 27, 2008 at 02:49:28PM -0700, David Brownell wrote:
> On Friday 25 July 2008, Grant Likely wrote:
> > I don't know what to do with these patches. =A0I'd really like to see t=
hem
> > in .27, and now that akpm has cleared his queue, the prerequisite patch
> > has been merged so they are ready to go in. =A0However, even though the=
re
> > has been favourable reception on the SPI and linuxppc lists for these
> > changes I don't have any acks from anybody yet.
> > =

> > David, can you please reply on if you are okay with these patches
> > getting merged? =A0If so, do you want me to merge them via my tree, or
> > do you want to pick them up?
> =

> OK ... to recap, #1 and #3 are OF-specific, I'll be agnostic.
> If other OF folk think it's OK, great.
> =

> Some cleanup was needed for #2, but it was basically ok ...
> I'd like to see the final version, and if it goes via an
> OF push that's OK by me.  (Though I'd like to see that change
> make it into 2.6.27 regardless, so let me know.)

Thanks for the review.  1-3 is already merged into my git tree and Ben
has pulled them.  I hope that's okay.  Here's a link to the commit:

http://git.kernel.org/?p=3Dlinux/kernel/git/benh/powerpc.git;a=3Dcommitdiff=
;h=3Ddc87c98e8f635a718f1abb2c3e15fc77c0001651

Let me know if you see anything else that needs to be changed and I'll
submit a fixup patch.

> And #4 isn't quite cooked yet.

Okay, I'll hack on this more and post v4.

Thanks again,
g.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
