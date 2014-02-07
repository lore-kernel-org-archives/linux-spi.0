From: Josh Cartwright <joshc@codeaurora.org>
Subject: Re: [PATCH 2/2] spi: Add Qualcomm QUP SPI controller support
Date: Fri, 7 Feb 2014 10:51:27 -0600
Message-ID: <20140207165127.GV20228@joshc.qualcomm.com>
References: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
 <1391705868-20091-3-git-send-email-iivanov@mm-sol.com>
 <20140207073952.GA2610@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>,
	Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
	Gilad Avidov <gavidov@codeaurora.org>,
	Kiran Gunda <kgunda@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Andy Gross <agross@codeaurora.org>
To: Kumar Gala <galak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140207073952.GA2610@qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 07, 2014 at 01:39:52AM -0600, Andy Gross wrote:
> On Thu, Feb 06, 2014 at 06:57:48PM +0200, Ivan T. Ivanov wrote:
> > From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> > 
> > Qualcomm Universal Peripheral (QUP) core is an AHB slave that
> > provides a common data path (an output FIFO and an input FIFO)
> > for serial peripheral interface (SPI) mini-core. SPI in master mode
> > support up to 50MHz, up to four chip selects, and a programmable
> > data path from 4 bits to 32 bits; MODE0..3 protocols
> > 
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> > Cc: Alok Chauhan <alokc@codeaurora.org>
> > Cc: Gilad Avidov <gavidov@codeaurora.org>
> > Cc: Kiran Gunda <kgunda@codeaurora.org>
> > Cc: Sagar Dharia <sdharia@codeaurora.org>
> > ---
> >  drivers/spi/Kconfig   |   14 +
> >  drivers/spi/Makefile  |    1 +
> >  drivers/spi/spi-qup.c |  898 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 913 insertions(+)
> >  create mode 100644 drivers/spi/spi-qup.c
> > 
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index ba9310b..bf8ce6b 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -381,6 +381,20 @@ config SPI_RSPI
> >  	help
> >  	  SPI driver for Renesas RSPI blocks.
> >  
> > +config SPI_QUP
> > +	tristate "Qualcomm SPI Support with QUP interface"
> > +	depends on ARCH_MSM
> 
> I'd change to ARCH_MSM_DT.  This ensures the OF component is there.

I'd rather explicitly include the CONFIG_OF dependency, but I'm not too
opinionated.

	config SPI_QUP
		tristate "Qualcomm SPI Support with QUP interface"
		depends on OF
		depends on ARM
		depends on ARCH_MSM_DT || COMPILE_TEST

With Kumar's pending the ARCH_MSM_DT -> ARCH_QCOM rename, we'll
introduce a arm-soc/spi tree dependency here that we'll need to keep
track of.

Kumar-

How would you like to handle this?  Would it make sense for this to go
through the SPI tree with depending on ARCH_QCOM instead of ARCH_MSM_DT?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
