From: "Du, Alek" <alek.du@intel.com>
Subject: RE: [PATCH v2] spi: reorganize drivers
Date: Tue, 7 Jun 2011 12:52:36 +0800
Message-ID: <1865303E0DED764181A9D882DEF65FB697F73BFC1C@shsmsx502.ccr.corp.intel.com>
References: <20110606071829.10334.90865.stgit@ponder>
	<BANLkTinqVf+uK+5T_X-EkXw-YE67DJL1Pg@mail.gmail.com>
	<BANLkTinmfufSkSnmiKWWEgpaR-usbiV5tA@mail.gmail.com>
	<4DED0510.1030600@gmail.com>	<20110607102829.01392e7e@feng-i7>
	<BANLkTim927Ld28JmVfALscThef02XQJDWw@mail.gmail.com>
 <20110607124854.0e96813c@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mike Frysinger <vapier.adi@gmail.com>,
	"alan@linux.intel.com" <alan@linux.intel.com>,
	"jean-hugues.deschenes@octasic.com"
	<jean-hugues.deschenes@octasic.com>
To: "Tang, Feng" <feng.tang@intel.com>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110607124854.0e96813c@feng-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

After the latest patches that Feng Tang sent out for SPI were merged, I=
 don't see any good reason to do big change. It just works perfectly.

Thanks,
Alek
-----Original Message-----
=46rom: Tang, Feng=20
Sent: Tuesday, June 07, 2011 12:49 PM
To: Grant Likely
Cc: Dirk Brandewie; spi-devel-general@lists.sourceforge.net; linux-kern=
el@vger.kernel.org; Mike Frysinger; Du, Alek; alan@linux.intel.com; jea=
n-hugues.deschenes@octasic.com
Subject: Re: [PATCH v2] spi: reorganize drivers

Hi Grant,

On Tue, 7 Jun 2011 12:09:52 +0800
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Mon, Jun 6, 2011 at 8:28 PM, Feng Tang <feng.tang@intel.com> wrote=
:
> > On Tue, 7 Jun 2011 00:49:20 +0800
> > Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
> >
> >> On 06/06/2011 09:38 AM, Grant Likely wrote:
> >> > On Mon, Jun 6, 2011 at 10:31 AM, Mike
> >> > Frysinger<vapier.adi@gmail.com> =A0wrote:
> >> >> On Mon, Jun 6, 2011 at 03:18, Grant Likely wrote:
> >> >>> Sort the SPI makefile and enforce the naming convention spi_*.=
c
> >> >>> for spi drivers.
> >> >>
> >> >> spi_topcliff_pch.c uses KBUILD_MODNAME with a few funcs, but
> >> >> perhaps those are only for /proc/ status tracking ? =A0worth
> >> >> double checking ...
> >> >
> >> > I just talked with Dirk Brandewie, who has a major rewrite to th=
e
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
>=20
> Hmmm.  Dirk, that could change things a bit.  From our conversation
> today my understanding was that there weren't few if any users outsid=
e
> of your circle.  If that isn't the case, then I'm going to be more
> cautious about merging the rewrite.  Who are the people I should make
> sure there is feedback from when the patch gets posted?

I don't know all the devices and users, but here is what I know: I've t=
ested
Max3110 spi-uart (in-tree), Option GTM501L high-speed 3G modem (out of =
tree),
ektf1236 spi touch screen (out of tree). Alek Du (Cced) should have tes=
ted
current dw_spi driver with some spi bluetooth device and modem device. =
Also
the original author fordw_spi_mmio.c Jean-Hugues Deschense should have =
some
experience too.

Thanks,
=46eng

>=20
> g.
