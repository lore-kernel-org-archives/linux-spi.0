From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
Date: Fri, 10 Jul 2015 10:28:59 +0200
Message-ID: <559F824B.70409@topic.nl>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <harinik@xilinx.com>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<punnaia@xilinx.com>, <ran27jit@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>
To: Ranjit Waghmode <ranjit.waghmode@xilinx.com>, <broonie@kernel.org>,
	<michal.simek@xilinx.com>, <soren.brinkmann@xilinx.com>,
	<dwmw2@infradead.org>, <computersforpeace@gmail.com>,
	<zajec5@gmail.com>, <marex@denx.de>, <shijie.huang@intel.com>,
	<juhosg@openwrt.org>, <ben@decadent.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

=EF=BB=BFOn 09-07-15 14:44, Ranjit Waghmode wrote:
> This series of patches is to add dual parallel and stacked mode suppo=
rt for
> Zynq Ultrascale+ MPSoC GQSPI controller driver.
>
> These are all very high level changes and expected to make an idea cl=
ear.
> Comments and suggestions are welcomed.
>
=2E..
>
> What is stacked mode?
> ---------------------
> ZynqMP GQSPI controller supports stacked mode with following function=
alities:
> 1) The Generic Quad-SPI controller also supports two SPI flash memori=
es
>     in a shared bus arrangement to reduce IO pin count.
> 2) Separate chip select lines
> 3) Shared I/O lines
> 4) This mode is targeted for increasing the flash memory and no perfo=
rmance
>     improvement when compared with single.

One could also model the stacked mode as having two distinct flash chip=
s with=20
separate chip selects and shared lines.
Merging them into a single storage device can be done on block layer or=
 higher=20
level. This allows the flash chips to be used in any configuration usin=
g=20
existing support for concatenating multiple devices.
I think this would be a more generic way of doing this. It also allows =
much=20
more flexibility, for example the devices could be used in a mirror set=
up, or=20
in combination with additional devices on other controllers.


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
