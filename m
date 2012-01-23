From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] spi: QUP based bus driver for Qualcomm MSM chipsets
Date: Mon, 23 Jan 2012 05:56:26 -0700
Message-ID: <20120123125626.GA23571@ponder.secretlab.ca>
References: <y>
 <1321307907-31508-1-git-send-email-harinij@codeaurora.org>
 <20111207223757.GE3744@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Harini Jayaraman <harinij@codeaurora.org>, bryanh@codeaurora.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kheitke@codeaurora.org, spi-devel-general@lists.sourceforge.net,
	davidb@codeaurora.org, linux-arm-kernel@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20111207223757.GE3744@pengutronix.de>
Content-Disposition: inline
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 07, 2011 at 11:37:58PM +0100, Wolfram Sang wrote:
> On Mon, Nov 14, 2011 at 02:58:27PM -0700, Harini Jayaraman wrote:
> > This bus driver supports the QUP SPI hardware controller in the Qualcomm
> > MSM SOCs. The Qualcomm Universal Peripheral Engine (QUP) is a general
> > purpose data path engine with input/output FIFOs and an embedded SPI
> > mini-core. The driver currently supports only FIFO mode.
> > 
> > Signed-off-by: Harini Jayaraman <harinij@codeaurora.org>
> 
> Wow, this driver is huge. This is a rough review only, mainly to see
> what can go away. This will make further reviews easier.
> 
> > ---
> > v2: Updated copyright information (addresses comments from Bryan Huntsman).
> >     Files renamed.
> > ---
> >  drivers/spi/Kconfig                   |   10 +
> >  drivers/spi/Makefile                  |    1 +
> >  drivers/spi/spi-qup.c                 | 1144 +++++++++++++++++++++++++++++++++
> >  drivers/spi/spi-qup.h                 |  436 +++++++++++++
> >  include/linux/platform_data/msm_spi.h |   19 +
> >  5 files changed, 1610 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/spi/spi-qup.c
> >  create mode 100644 drivers/spi/spi-qup.h

Why the separate header file?  From what I can tell, only spi-qup.c
uses it, so the definitions should be directly in spi-qup.c.

g.
