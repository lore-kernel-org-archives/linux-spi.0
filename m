From: Ranjit Abhimanyu Waghmode <ranjit.waghmode@xilinx.com>
Subject: RE: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
Date: Wed, 15 Jul 2015 14:12:54 +0000
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "marex@denx.de" <marex@denx.de>, Harini Katakam <harinik@xilinx.com>,
 "ben@decadent.org.uk" <ben@decadent.org.uk>,
 "zajec5@gmail.com" <zajec5@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "juhosg@openwrt.org" <juhosg@openwrt.org>, Michal Simek <michals@xilinx.com>,
 Soren Brinkmann <sorenb@xilinx.com>,
 Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
 "shijie.huang@intel.com" <shijie.huang@intel.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "ran27jit@gmail.com" <ran27jit@gmail.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150714164005.GE11162@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

> > What is dual parallel mode?
> > ---------------------------
> > ZynqMP GQSPI controller supports Dual Parallel mode with following
> functionalities:
> > 1) Supporting two SPI flash memories operating in parallel. 8 I/O lines.
> > 2) Chip selects and clock are shared to both the flash devices
> > 3) This mode is targeted for faster read/write speed and also doubles the size
> > 4) Commands/data can be transmitted/received from both the devices(mirror),
> >    or only upper or only lower flash memory devices.
> > 5) Data arrangement:
> >    With stripe enabled,
> >    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
> >    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.
> 
> For the SPI code this just seems like SPI with an 8 bit data width.
> 
> > What is stacked mode?
> > ---------------------
> > ZynqMP GQSPI controller supports stacked mode with following
> functionalities:
> > 1) The Generic Quad-SPI controller also supports two SPI flash memories
> >    in a shared bus arrangement to reduce IO pin count.
> > 2) Separate chip select lines
> > 3) Shared I/O lines
> > 4) This mode is targeted for increasing the flash memory and no performance
> >    improvement when compared with single.
> 
> This is just a normal SPI controller from a SPI point of view.

How can we really represent the stacked mode in current configuration?

Thanks & Regards,
Ranjit
