From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v2 06/15] spi: imx: fix ERR009165
Date: Fri, 26 Apr 2019 11:37:22 +0200
Message-ID: <1556271442.2584.29.camel@pengutronix.de>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556265512-9130-7-git-send-email-yibin.gong@nxp.com>
         <1556269635.2584.23.camel@pengutronix.de>
         <1556270196.9298.16.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: Robin Gong <yibin.gong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556270196.9298.16.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am Freitag, den 26.04.2019, 09:22 +0000 schrieb Robin Gong:
> On 2019-04-26 at 11:07 +0200, Lucas Stach wrote:
> > 
> > Am Freitag, den 26.04.2019, 08:05 +0000 schrieb Robin Gong:
> > >  static void mx51_setup_wml(struct spi_imx_data *spi_imx)
> > >  {
> > > +     u32 tx_wml = 0;
> > > +
> > 
> > With a wml of 0 you might set the maxburst of the TX dma channel to
> > fifosize to minimize the performance impact of this workaround.
> > 
> > Regards,
> > Lucas
> 
> Unfortunately, this is a MUST part of errata which cause performance
> drop.

I'm not talking about changing the WML, but when the WML must be 0 you
can safely increase the DMA burst size without overflowing the FIFO,
which might recover some of of the performance loss.

Regards,
Lucas
