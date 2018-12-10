From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v5 0/7] spi: add support for octal mode
Date: Mon, 10 Dec 2018 08:39:20 +0000
Message-ID: <VI1PR04MB572609DBC52F7496A656915E99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181203101937.7b01a0ad@bbrezillon>
        <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
        <20181205134618.56223758@bbrezillon>
        <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181206074554.0ec0aecb@bbrezillon>
        <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181206202956.GG3084@sirena.org.uk>
        <VI1PR04MB572641541BB83E587541BBD099A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181210092208.0971c3be@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210092208.0971c3be@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

Sorry for confusion.

My intention was just to point to the correct patch number only. Earlier yo=
u have asked Mark to pick the patch [1] but that patch number was not corre=
ct.

[1] https://lkml.org/lkml/2018/12/5/758

--
Regards
Yogesh Gaur

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, December 10, 2018 1:52 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Mark Brown <broonie@kernel.org>; Vignesh R <vigneshr@ti.com>; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; linux-spi@vger.kernel.org=
;
> devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
>=20
> Hi Yogesh,
>=20
> On Mon, 10 Dec 2018 04:13:28 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Mark,
> >
> > Patch has been resend [1], this patch is depends on the series of patch=
[2] and
> this series has been applied by Boris already.
>=20
> You're still not asking the right person. Every patches touching things i=
n
> drivers/mtd/ should be taken by me (or another MTD maintainer), and patch=
es
> touching things in drivers/spi/ should be taken by Mark. So, the patch yo=
u're
> pointing to should be applied by me. Plus, I told you I would apply it af=
ter 4.21-
> rc1 because I don't want to deal with the mtd -> spi dependency.
>=20
> Please be patient.
>=20
> Regards,
>=20
> Boris
