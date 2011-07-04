From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] SPI: SAMSUNG: Bug fix for SPI with different FIFO
 level
Date: Mon, 4 Jul 2011 00:55:01 -0600
Message-ID: <20110704065501.GP15152@ponder.secretlab.ca>
References: <1309437536-9315-1-git-send-email-padma.v@samsung.com>
 <1309437536-9315-2-git-send-email-padma.v@samsung.com>
 <BANLkTi=L7QeN75ebWFXdp_V5Pw1zEc-ZtA@mail.gmail.com>
 <BANLkTimeWUbD2Ej16KKmuzwSCFz8HOhyKQ@mail.gmail.com>
 <BANLkTi=9c5asfr=Jg6xwjQZW_a369UO64Q@mail.gmail.com>
 <BANLkTinFnFwBGi693JTD_iDykA2VkV+HOw@mail.gmail.com>
 <BANLkTik0LERxBHmJc5ZnRotnD4CSveR-UQ@mail.gmail.com>
 <BANLkTim9wdrqDgXVUjxzMv9cdWViLww=Bg@mail.gmail.com>
 <BANLkTim40x4X_--K0z7gdodDjor0MUam5Q@mail.gmail.com>
 <BANLkTinf6ec1yXeaFkZjHMnqZp7yymDq-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: padma venkat <padma.kvr@gmail.com>,
	Tony Nadackal <tonykn@gmail.com>,
	Padmavathi Venna <padma.v@samsung.com>, kgene.kim@samsung.com,
	sbkim73@samsung.com, spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, tony.kn@samsung.com,
	naushad@samsung.com
To: Jassi Brar <jassisinghbrar@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTinf6ec1yXeaFkZjHMnqZp7yymDq-w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 01, 2011 at 11:43:08AM +0530, Jassi Brar wrote:
> On Fri, Jul 1, 2011 at 11:29 AM, padma venkat <padma.kvr@gmail.com> w=
rote:
> > Hi Jassi,
> >
> > On Fri, Jul 1, 2011 at 11:22 AM, Jassi Brar <jassisinghbrar@gmail.c=
om> wrote:
> >> On Fri, Jul 1, 2011 at 11:16 AM, padma venkat <padma.kvr@gmail.com=
> wrote:
> >>> Hi Tony,
> >>>
> >>> On Thu, Jun 30, 2011 at 4:30 PM, Tony Nadackal <tonykn@gmail.com>=
 wrote:
> >>>> Hi Padma,
> >>>> With regards to your patch, even though one can check the tx don=
e status
> >>>> using the TX_DONE bit, the present macro itself would work perfe=
ctly fine if
> >>>> the 'fifo_lvl_mask' is set properly.
> >>>> For example in 6450 channel 1, the fifo_lvl_mask should be 0x1ff=
 (for 9bits,
> >>>> 15:23), while even in your patch, it is wrongly set as 0x7f(only=
 7bits).
> >>>>
> >>>> Thus, if this fifo_lvl_mask was defined correctly, the existing =
macro would
> >>>> itself have worked.
> >>> Thanks for your comment.
> >>> I considered changing to the fifo_lvl_mask to 1ff as you mentione=
d.
> >>> But I =A0think that the fifo_lvl_mask reflects the actual FIFO ca=
pacity
> >>> in the SPI driver.
> >>> For the failing channels the FIFO trigger level is 64 bytes and s=
o i
> >>> retained that value.
> >>> In the driver it polls till the FIFO capacity level otherwise it =
goes
> >>> for DMA.So if we keep
> >>> the FIFO level as 1ff when the actual capacity is 7f then it fail=
s.
> >>>
> >>> Jassi what do you think about this?
> >>>
> >>
> >> 'fifo_lvl_mask' is h/w specific and can't be set for convenience.
> >>
> >> I don't have access to post-s3c64xx datasheets.
> >> Please check and reply if TX_DONE bit is at same offset for all
> >> channels of an SoC, because
> >> I suspect it's otherwise.
> >>
> > Yes. The TX_DONE bit is at the same offset for all the channels of =
an SoC.
> > in S5P64X0,S5PV210 and S5PV310 it is at offset 25.
> >
>=20
> Then, Patches-1,2
>=20
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

Are these bug fixes that should be in v3.0, or do I queue them up for v=
3.1?

g.
