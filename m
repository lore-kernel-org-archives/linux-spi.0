From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] SPI: SAMSUNG: Bug fix for SPI with different FIFO
 level
Date: Mon, 4 Jul 2011 09:06:07 -0600
Message-ID: <20110704150607.GA29977@ponder.secretlab.ca>
References: <BANLkTi=9c5asfr=Jg6xwjQZW_a369UO64Q@mail.gmail.com>
 <BANLkTinFnFwBGi693JTD_iDykA2VkV+HOw@mail.gmail.com>
 <BANLkTik0LERxBHmJc5ZnRotnD4CSveR-UQ@mail.gmail.com>
 <BANLkTim9wdrqDgXVUjxzMv9cdWViLww=Bg@mail.gmail.com>
 <BANLkTim40x4X_--K0z7gdodDjor0MUam5Q@mail.gmail.com>
 <BANLkTinf6ec1yXeaFkZjHMnqZp7yymDq-w@mail.gmail.com>
 <20110704065501.GP15152@ponder.secretlab.ca>
 <CACxGe6urrZ9=1OgcaYF6EtvJokAyFTbFCnHPWsCY+sETVze8-w@mail.gmail.com>
 <005501cc3a30$6c916190$45b424b0$%kim@samsung.com>
 <005601cc3a32$64bd5fd0$2e381f70$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 'Jassi Brar' <jassisinghbrar@gmail.com>,
	'padma venkat' <padma.kvr@gmail.com>,
	'Tony Nadackal' <tonykn@gmail.com>,
	'Padmavathi Venna' <padma.v@samsung.com>, sbkim73@samsung.com,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, tony.kn@samsung.com,
	naushad@samsung.com
To: Kukjin Kim <kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <005601cc3a32$64bd5fd0$2e381f70$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 04, 2011 at 07:08:55PM +0900, Kukjin Kim wrote:
> Kukjin Kim wrote:
> >=20
> > Grant Likely wrote:
> > >
> > > On Mon, Jul 4, 2011 at 12:55 AM, Grant Likely
> <grant.likely@secretlab.ca>
> > wrote:
> > > > On Fri, Jul 01, 2011 at 11:43:08AM +0530, Jassi Brar wrote:
> > > >> On Fri, Jul 1, 2011 at 11:29 AM, padma venkat <padma.kvr@gmail=
=2Ecom>
> > wrote:
> > > >> > Hi Jassi,
> > > >> >
> > > >> > On Fri, Jul 1, 2011 at 11:22 AM, Jassi Brar
> > <jassisinghbrar@gmail.com> wrote:
> > > >> >> On Fri, Jul 1, 2011 at 11:16 AM, padma venkat
> <padma.kvr@gmail.com>
> > > wrote:
> > > >> >>> Hi Tony,
> > > >> >>>
> > > >> >>> On Thu, Jun 30, 2011 at 4:30 PM, Tony Nadackal <tonykn@gma=
il.com>
> > > wrote:
> > > >> >>>> Hi Padma,
> > > >> >>>> With regards to your patch, even though one can check the=
 tx
> done
> > > status
> > > >> >>>> using the TX_DONE bit, the present macro itself would wor=
k
> > perfectly
> > > fine if
> > > >> >>>> the 'fifo_lvl_mask' is set properly.
> > > >> >>>> For example in 6450 channel 1, the fifo_lvl_mask should b=
e 0x1ff
> > (for
> > > 9bits,
> > > >> >>>> 15:23), while even in your patch, it is wrongly set as 0x=
7f(only
> > 7bits).
> > > >> >>>>
> > > >> >>>> Thus, if this fifo_lvl_mask was defined correctly, the ex=
isting
> > macro
> > > would
> > > >> >>>> itself have worked.
> > > >> >>> Thanks for your comment.
> > > >> >>> I considered changing to the fifo_lvl_mask to 1ff as you
> mentioned.
> > > >> >>> But I =A0think that the fifo_lvl_mask reflects the actual =
=46IFO
> > capacity
> > > >> >>> in the SPI driver.
> > > >> >>> For the failing channels the FIFO trigger level is 64 byte=
s and
> so
> > i
> > > >> >>> retained that value.
> > > >> >>> In the driver it polls till the FIFO capacity level otherw=
ise it
> > goes
> > > >> >>> for DMA.So if we keep
> > > >> >>> the FIFO level as 1ff when the actual capacity is 7f then =
it
> fails.
> > > >> >>>
> > > >> >>> Jassi what do you think about this?
> > > >> >>>
> > > >> >>
> > > >> >> 'fifo_lvl_mask' is h/w specific and can't be set for conven=
ience.
> > > >> >>
> > > >> >> I don't have access to post-s3c64xx datasheets.
> > > >> >> Please check and reply if TX_DONE bit is at same offset for=
 all
> > > >> >> channels of an SoC, because
> > > >> >> I suspect it's otherwise.
> > > >> >>
> > > >> > Yes. The TX_DONE bit is at the same offset for all the chann=
els of
> an
> > SoC.
> > > >> > in S5P64X0,S5PV210 and S5PV310 it is at offset 25.
> > > >> >
> > > >>
> > > >> Then, Patches-1,2
> > > >>
> > > >> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> > > >
> > > > Are these bug fixes that should be in v3.0, or do I queue them =
up for
> > v3.1?
> > >
> > > Regardless, this one touches a lot of arch/arm files, so I'd rath=
er
> > > see both patches go through the samsung tree:
> > >
> > > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > >
> >=20
> > Thanks Grant, Jassi and all,
> >=20
> > I will apply these 1 and 2 in my -fix tree for 3.0 with your acks.
> >=20
> Oops, this needs previous 'cleanup spi platform specific code' so can=
't
> apply -fix tree now.

There may also be conflicts with the heavy rework in the spi tree.
Kgene, when you pick up this series, can you put it into a separate
topic branch and merge that into your main tree?  That way if there
are difficult conflicts, then I can also merge that same topic branch
into spi/next to resolve them.

g.
