From: Ranjit Abhimanyu Waghmode <ranjit.waghmode@xilinx.com>
Subject: RE: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
Date: Mon, 27 Jul 2015 13:55:56 +0000
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3C0148C95C@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150716085739.GT11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA81D12@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150724105209.GI11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "marex@denx.de" <marex@denx.de>, Harini Katakam <harinik@xilinx.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
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
 "ben@decadent.org.uk" <ben@decadent.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150724105209.GI11162@sirena.org.uk>
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

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, July 24, 2015 4:22 PM
> To: Ranjit Abhimanyu Waghmode
> Cc: Michal Simek; Soren Brinkmann; zajec5@gmail.com; marex@denx.de;
> shijie.huang@intel.com; juhosg@openwrt.org; ben@decadent.org.uk; linux-
> mtd@lists.infradead.org; linux-spi@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Harini Katakam;
> Punnaiah Choudary Kalluri; ran27jit@gmail.com; dwmw2@infradead.org;
> computersforpeace@gmail.com
> Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
> Zynq MPSoC GQSPI controller
> 
> On Fri, Jul 24, 2015 at 10:42:35AM +0000, Ranjit Abhimanyu Waghmode wrote:
> 
> As I think you've been asked before please fix your mail client to word wrap
> within paragraphs so your mails are more legible.
> 

Sorry about this, I did some changes but it's kind of broken. Will fix this.

> > To support the dual parallel mode in this controller, following minor
> > things can be added to the driver.
> 
> > 1) Controller needs to know in which mode it is working, then it's
> > obvious to set the appropriate flag for the same
> > 2) There are more than one chip selects, so need to set the same
> >
> > So kindly suggest your view on the above request.
> 
> I'm not entirely sure what you're asking here from the point of view of SPI, sorry
> - what exactly are you requesting?  If you want to add support for new SPI bus
> modes please go ahead and do that, you need to clearly document what any
> new modes you're adding are so that other people can understand them.

Ok, my description was too short to get it completely.

For adding dual parallel mode support to current driver:
Are following points enough? Or do you want to suggest something better on top of it?

Driver:
1) Controller needs to know in which mode it is working.
2) As there are more than one chip selects, may need to add code for handling that as well.

MTD:
1) Adding TWO_FLASH support
2) Adding DATA_STRIPE support
3) For reading array size needs to be doubled.
4) Need to access even addresses. Basically address/2.

Please suggest your view on above points.

Regards,
Ranjit
