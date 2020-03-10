From: <Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v3 4/4] mtd: spi-nor: remove mtk-quadspi driver
Date: Tue, 10 Mar 2020 09:11:29 +0000
Message-ID: <4427171.IzkiAjLLdB@localhost.localdomain>
References: <20200306085052.28258-1-gch981213@gmail.com>
 <20200309121020.GD4101@sirena.org.uk>
 <2471214.x7VzW1FXlQ@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <vigneshr-l0cyMroinI0@public.gmane.org>, <richard-/L3Ra7n9ekc@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2471214.x7VzW1FXlQ-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Language: en-US
Content-ID: <854A8A8A2CF8664186B41C8FB21DB83F-Hry67jCOGbCcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, March 10, 2020 9:41:26 AM EET Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org wrote=
:
> Hi, Mark,
>=20
> On Monday, March 9, 2020 2:10:20 PM EET Mark Brown wrote:
> > > This driver is superseded by the new spi-mtk-nor driver.
> > >=20
> > > Signed-off-by: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >=20
> > Is this move OK from a MTD point of view - should I apply this when the
> > rest goes in?  The patch was in prior versions too and is obviously
> > straightforward.
>=20
> If you find the rest of the patches ok, this can go through the spi tree,
> feel free to add my
> Acked-by: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
>=20
> There will be a conflict with the following patch https://
> patchwork.ozlabs.org/patch/1247791/, but nothing that we can't handle.

You can also create an immutable tag that I can merge in my spi-nor/next=20
branch, so that Linus doesn't have to deal with the conflict.

ta
