From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Date: Mon, 10 Dec 2018 11:17:20 +0000
Message-ID: <VI1PR04MB5726164D7E52B013FF2F135B99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181210115717.01ad2e60@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
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
In-Reply-To: <20181210115717.01ad2e60@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, December 10, 2018 4:27 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; broonie@kernel.org;
> marek.vasut@gmail.com; vigneshr@ti.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Writ=
e
> commands
>=20
> On Mon, 3 Dec 2018 08:39:18 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > - Add opcodes for octal I/O commands
> >   * Read  : 1-1-8 and 1-8-8 protocol
> >   * Write : 1-1-8 and 1-8-8 protocol
> >   * opcodes for 4-byte address mode command
> >
> > - Entry of macros in _convert_3to4_xxx function
> >
> > - Add flag specifying flash support octal read commands.
> >
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>=20
> Looks like the SoB and Author lines do not match
>=20
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> vs Yogesh Gaur
> <yogeshnarayan.gaur@nxp.com>
>=20
> Can you find a way to make them match?
I am sending the patches with my smtp server of OutlookOffice and in that m=
y user name is "Yogesh Narayan Gaur" and in gitconfig of my Linux machine I=
 set user name as "Yogesh Gaur".
Is it mandatory to have same Author name in SoB and Author lines, if yes I =
would change the settings in gitconfig file.

>=20
> Thanks,
>=20
> Boris
