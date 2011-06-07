From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: reorganize drivers
Date: Tue, 7 Jun 2011 12:48:54 +0800
Message-ID: <20110607124854.0e96813c@feng-i7>
References: <20110606071829.10334.90865.stgit@ponder>
	<BANLkTinqVf+uK+5T_X-EkXw-YE67DJL1Pg@mail.gmail.com>
	<BANLkTinmfufSkSnmiKWWEgpaR-usbiV5tA@mail.gmail.com>
	<4DED0510.1030600@gmail.com> <20110607102829.01392e7e@feng-i7>
	<BANLkTim927Ld28JmVfALscThef02XQJDWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BANLkTim927Ld28JmVfALscThef02XQJDWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

On Tue, 7 Jun 2011 12:09:52 +0800
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> On Mon, Jun 6, 2011 at 8:28 PM, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > On Tue, 7 Jun 2011 00:49:20 +0800
> > Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> >> On 06/06/2011 09:38 AM, Grant Likely wrote:
> >> > On Mon, Jun 6, 2011 at 10:31 AM, Mike
> >> > Frysinger<vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =A0wrote:
> >> >> On Mon, Jun 6, 2011 at 03:18, Grant Likely wrote:
> >> >>> Sort the SPI makefile and enforce the naming convention spi_*.c
> >> >>> for spi drivers.
> >> >>
> >> >> spi_topcliff_pch.c uses KBUILD_MODNAME with a few funcs, but
> >> >> perhaps those are only for /proc/ status tracking ? =A0worth
> >> >> double checking ...
> >> >
> >> > I just talked with Dirk Brandewie, who has a major rewrite to the
> >> > topcliff spi driver. =A0I'll let him comment on whether or not
> >> > changing KBUILD_MODNAME will cause any problems.
> >> >
> >>
> >> My changes are to the designware driver :-) I will get my patches
> >> re-based onto the spi-next branch and see if there any issues.
> >
> > If there is major rewrite to the dw_spi driver, please submit to
> > this list, as it is used by many devices out there and needs a
> > broad review
> =

> Hmmm.  Dirk, that could change things a bit.  From our conversation
> today my understanding was that there weren't few if any users outside
> of your circle.  If that isn't the case, then I'm going to be more
> cautious about merging the rewrite.  Who are the people I should make
> sure there is feedback from when the patch gets posted?

I don't know all the devices and users, but here is what I know: I've tested
Max3110 spi-uart (in-tree), Option GTM501L high-speed 3G modem (out of tree=
),
ektf1236 spi touch screen (out of tree). Alek Du (Cced) should have tested
current dw_spi driver with some spi bluetooth device and modem device. Also
the original author fordw_spi_mmio.c Jean-Hugues Deschense should have some
experience too.

Thanks,
Feng

> =

> g.

---------------------------------------------------------------------------=
---
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
