From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v5 0/7] spi: add support for octal mode
Date: Thu, 6 Dec 2018 06:49:08 +0000
Message-ID: <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
 <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206074554.0ec0aecb@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Vignesh R <vigneshr@ti.com>, "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181206074554.0ec0aecb@bbrezillon>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, December 6, 2018 12:16 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Vignesh R <vigneshr@ti.com>; broonie@kernel.org; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
> 
> On Thu, 6 Dec 2018 04:20:26 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > Hi Boris,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Wednesday, December 5, 2018 6:16 PM
> > > To: Vignesh R <vigneshr@ti.com>; broonie@kernel.org
> > > Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> > > mtd@lists.infradead.org; marek.vasut@gmail.com;
> > > linux-spi@vger.kernel.org; devicetree@vger.kernel.org;
> > > robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > > linux-arm-kernel@lists.infradead.org;
> > > computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
> > >
> > > On Wed, 5 Dec 2018 17:25:12 +0530
> > > Vignesh R <vigneshr@ti.com> wrote:
> > >
> > > > >>   mtd: spi-nor: add opcodes for octal Read/Write commands
> > > > >>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
> > > >
> > > > Could you consider merging these two patches alone for v4.21?
> > > > These can be applied independent of other patches in the series
> > > > and would allow supporting OSPI flash at SPI NOR level with Cadence QSPI
> driver.
> > >
> > > Yep, I'll queue them to spi-nor/next.
> > >
> > > > >>   spi: nxp-fspi: add octal mode flag bit for octal support
> > >
> > > Mark, I think you can pick this one too.
> >
> > This patch is dependent on the series [1] which is yet to be applied by you,
> please apply.
> 
> By me? I can't apply SPI patches.

Sorry for ignorance. Did patches needs to be applied by Mark Brown, should I resend the patch series again?
Also can you please review the series [1] and add your Reviewed-by tag.

--
Regards
Yogesh Gaur

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=76402

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
