From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Date: Thu, 6 Dec 2018 07:45:54 +0100
Message-ID: <20181206074554.0ec0aecb@bbrezillon>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181203101937.7b01a0ad@bbrezillon>
        <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
        <20181205134618.56223758@bbrezillon>
        <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Vignesh R <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 6 Dec 2018 04:20:26 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Wednesday, December 5, 2018 6:16 PM
> > To: Vignesh R <vigneshr@ti.com>; broonie@kernel.org
> > Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> > mtd@lists.infradead.org; marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> > computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
> > 
> > On Wed, 5 Dec 2018 17:25:12 +0530
> > Vignesh R <vigneshr@ti.com> wrote:
> >   
> > > >>   mtd: spi-nor: add opcodes for octal Read/Write commands
> > > >>   mtd: spi-nor: add octal read flag for flash mt35xu512aba  
> > >
> > > Could you consider merging these two patches alone for v4.21?
> > > These can be applied independent of other patches in the series and
> > > would allow supporting OSPI flash at SPI NOR level with Cadence QSPI driver.  
> > 
> > Yep, I'll queue them to spi-nor/next.
> >   
> > > >>   spi: nxp-fspi: add octal mode flag bit for octal support  
> > 
> > Mark, I think you can pick this one too.  
> 
> This patch is dependent on the series [1] which is yet to be applied by you, please apply.

By me? I can't apply SPI patches.
