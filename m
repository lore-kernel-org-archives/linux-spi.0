From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/5] OMAP: McSPI: Implement McSPI in HWMOD way
Date: Fri, 13 Aug 2010 16:44:30 -0600
Message-ID: <AANLkTikS0tX3GA+1LXnqbZYuuWteOTq7dH13i-icKYD2@mail.gmail.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com,
	paul@pwsan.com, b-cousson@ti.com, tony@atomide.com,
	dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net, rnayak@ti.com,
	p-basak2@ti.com, govindraj.raja@ti.com
To: Charulatha V <charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1281708323-18989-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 13, 2010 at 8:05 AM, Charulatha V <charu@ti.com> wrote:
> This patch series implements McSPI Module in HWMOD FW way
> and use the runtime PM layer.

Hi Charulatha,

I'll go through and review the patches, but I'm unfamiliar with HWMOD.
 Is there a description of HWMOD that you can point me at?

Thanks,
g.

>
> This patch series is created on "origin/pm-wip/hwmods-omap4" with
> McSPI slave mode patches (url given below) on top of it.
> https://patchwork.kernel.org/patch/79677/
> Updated McSPI slave mode patches will be posted shortly by Govindraj.
> McSPI slave mode patches were already discussed on open source mailin=
g
> list and they are almost towards the end of final rebased version.
> Hence hwmod patches are created on top of McSPI slave mode patch
> series to avoid major rework later on.
>
> Benoit Cousson (1):
> =A0OMAP4 HWMOD: Add mcspi hwmods.
>
> Charulatha V (3):
> =A0OMAP2420: McSPI: Add mcspi hwmod
> =A0OMAP2430 : McSPI: Add mcspi hwmod data
> =A0OMAP3 HWMOD: Add mcspi hwmods.
>
> Govindraj.R (1):
> =A0OMAP McSPI: Adapt McSPI driver to use omap hwmod
>
> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 | =A0 =A04 +
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0233 =
+++++++++---------------
> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0138 ++++++++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0196 ++++++++++++++=
++++++
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0252 ++++++++++++++=
+++++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0244 ++++++++++++++=
+++++++++++
> =A0arch/arm/plat-omap/include/plat/mcspi.h =A0 =A0| =A0 27 +++
> =A0drivers/spi/omap2_mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
273 +++++++++-------------------
> =A08 files changed, 1034 insertions(+), 333 deletions(-)
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
