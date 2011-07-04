From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 2/2] SPI: SAMSUNG: Bug fix for SPI with different FIFO level
Date: Mon, 04 Jul 2011 18:54:48 +0900
Message-ID: <005501cc3a30$6c916190$45b424b0$%kim@samsung.com>
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
 <20110704065501.GP15152@ponder.secretlab.ca>
 <CACxGe6urrZ9=1OgcaYF6EtvJokAyFTbFCnHPWsCY+sETVze8-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 'padma venkat' <padma.kvr@gmail.com>,
	'Tony Nadackal' <tonykn@gmail.com>,
	'Padmavathi Venna' <padma.v@samsung.com>, sbkim73@samsung.com,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, tony.kn@samsung.com,
	naushad@samsung.com
To: 'Grant Likely' <grant.likely@secretlab.ca>,
	'Jassi Brar' <jassisinghbrar@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CACxGe6urrZ9=1OgcaYF6EtvJokAyFTbFCnHPWsCY+sETVze8-w@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Grant Likely wrote:
>=20
> On Mon, Jul 4, 2011 at 12:55 AM, Grant Likely <grant.likely@secretlab=
=2Eca>
wrote:
> > On Fri, Jul 01, 2011 at 11:43:08AM +0530, Jassi Brar wrote:
> >> On Fri, Jul 1, 2011 at 11:29 AM, padma venkat <padma.kvr@gmail.com=
>
wrote:
> >> > Hi Jassi,
> >> >
> >> > On Fri, Jul 1, 2011 at 11:22 AM, Jassi Brar
<jassisinghbrar@gmail.com> wrote:
> >> >> On Fri, Jul 1, 2011 at 11:16 AM, padma venkat <padma.kvr@gmail.=
com>
> wrote:
> >> >>> Hi Tony,
> >> >>>
> >> >>> On Thu, Jun 30, 2011 at 4:30 PM, Tony Nadackal <tonykn@gmail.c=
om>
> wrote:
> >> >>>> Hi Padma,
> >> >>>> With regards to your patch, even though one can check the tx =
done
> status
> >> >>>> using the TX_DONE bit, the present macro itself would work
perfectly
> fine if
> >> >>>> the 'fifo_lvl_mask' is set properly.
> >> >>>> For example in 6450 channel 1, the fifo_lvl_mask should be 0x=
1ff
(for
> 9bits,
> >> >>>> 15:23), while even in your patch, it is wrongly set as 0x7f(o=
nly
7bits).
> >> >>>>
> >> >>>> Thus, if this fifo_lvl_mask was defined correctly, the existi=
ng
macro
> would
> >> >>>> itself have worked.
> >> >>> Thanks for your comment.
> >> >>> I considered changing to the fifo_lvl_mask to 1ff as you menti=
oned.
> >> >>> But I =A0think that the fifo_lvl_mask reflects the actual FIFO
capacity
> >> >>> in the SPI driver.
> >> >>> For the failing channels the FIFO trigger level is 64 bytes an=
d so
i
> >> >>> retained that value.
> >> >>> In the driver it polls till the FIFO capacity level otherwise =
it
goes
> >> >>> for DMA.So if we keep
> >> >>> the FIFO level as 1ff when the actual capacity is 7f then it f=
ails.
> >> >>>
> >> >>> Jassi what do you think about this?
> >> >>>
> >> >>
> >> >> 'fifo_lvl_mask' is h/w specific and can't be set for convenienc=
e.
> >> >>
> >> >> I don't have access to post-s3c64xx datasheets.
> >> >> Please check and reply if TX_DONE bit is at same offset for all
> >> >> channels of an SoC, because
> >> >> I suspect it's otherwise.
> >> >>
> >> > Yes. The TX_DONE bit is at the same offset for all the channels =
of an
SoC.
> >> > in S5P64X0,S5PV210 and S5PV310 it is at offset 25.
> >> >
> >>
> >> Then, Patches-1,2
> >>
> >> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> >
> > Are these bug fixes that should be in v3.0, or do I queue them up f=
or
v3.1?
>=20
> Regardless, this one touches a lot of arch/arm files, so I'd rather
> see both patches go through the samsung tree:
>=20
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>=20

Thanks Grant, Jassi and all,

I will apply these 1 and 2 in my -fix tree for 3.0 with your acks.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
