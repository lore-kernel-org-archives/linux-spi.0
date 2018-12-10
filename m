From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Date: Mon, 10 Dec 2018 11:36:09 +0100
Message-ID: <20181210113609.59355f12@bbrezillon>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
        <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181210111909.35384eee@bbrezillon>
        <f51ab7b2-bc23-1a8f-5970-18c2d200eb6a@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f51ab7b2-bc23-1a8f-5970-18c2d200eb6a@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 10 Dec 2018 10:31:57 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> >> Yes, I need to validate op->addr.nbytes else LUT would going to be programmed for 0 addrlen.
> >> I have checked this on the target.  
> > 
> > Also agree there. Some operations have 0 address bytes. We could also
> > test addr.buswidth, but I'm fine with the addr.nbytes test too.  
> 
> The "if (op->addr.nbytes)" is needed of course, but I think the default 
> case in the switch statement (and for other reasons the whole switch 
> statement) is not needed and rather a check for op->addr.nbytes > 4 
> should be added to nxp_fspi_supports_op(). I wrongly assumed this check 
> already exists in nxp_fspi_supports_op().

Ok, then this check on the max number of address bytes should indeed be
moved to the supports_op() implementation.
