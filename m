From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v5 1/8] mtd: spi-nor: copy the SPI NOR commands to a new header file
Date: Wed, 5 Mar 2014 14:36:43 +0100
Message-ID: <201403051436.43830.marex@denx.de>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com> <5316B9F2.8050301@freescale.com> <20980858CB6D3A4BAE95CA194937D5E73EAAFCDB@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huang Shijie <b32955@freescale.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"angus.clark@st.com" <angus.clark@st.com>,
	"shawn.guo@linaro.org" <shawn.guo@linaro.org>,
	"b44548@freescale.com" <b44548@freescale.com>,
	"broonie@linaro.org" <broonie@linaro.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"b18965@freescale.com" <b18965@freescale.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Poddar, Sourav" <sourav.poddar@ti.com>,
	"computersforpeace@gmail.com" <computersforpeace@gmail.com>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: "Gupta, Pekon" <pekon@ti.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAAFCDB@DBDE04.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, March 05, 2014 at 08:24:21 AM, Gupta, Pekon wrote:
> Hi Marek, Shijie,
>=20
> >From: Huang Shijie [mailto:b32955@freescale.com]
> >
> >=E4=BA=8E 2014=E5=B9=B403=E6=9C=8805=E6=97=A5 11:43, Marek Vasut =E5=
=86=99=E9=81=93:
> >> Why didn't you keep it like that? Was there some reason for that ?
> >
> >http://marc.info/?l=3Dlinux-arm-kernel&m=3D138545182232220&w=3D4
> >
> >Pekon suggestted  do not touch the m25p80.c.
> >So i just copy these commands to a new header.
> >Anyway, it's really not an important issue for me. :)
>=20
> My opinion was that we should not touch m25p80.c because:
> (1)  As m25p80 is already working for various vendors. So unless mult=
iple
>    platforms start using SPI NOR framework, m25p80.c should remain
> untouched. (2) we should not clutter header file with vendor specific
> op-codes as used in m25p80. I was of the opinion that instead of
> hard-coding the vendor specific info as MACROs, such information shou=
ld be
> taken from DT or platform-data.
>=20
> However, this was my thought during initial versions of SPI NOR patch=
es.
> But now if you think that SPI NOR is stable enough that same header i=
nfo
> can be reused without conflicts, then no problems.
>=20
> (Apologies to Huang Shijie for re-work :-) ).

Ah, thanks for explaining, understood. Given that the m25p80.c is rewor=
ked later=20
in the series anyway, I'm mostly OK with this patch ... even though I'd=
 prefer=20
to see no duplication throughout the series ;-)

Best regards,
Marek Vasut
