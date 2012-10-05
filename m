From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi: spi-rspi: fix build error for the latest shdma
 driver
Date: Fri, 5 Oct 2012 12:43:19 +0100
Message-ID: <20121005114319.GY4360@opensource.wolfsonmicro.com>
References: <501A379D.6060009@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	SH-Linux <linux-sh@vger.kernel.org>
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <501A379D.6060009@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 02, 2012 at 05:17:33PM +0900, Shimoda, Yoshihiro wrote:
> Because the latest shdma driver changed, it caused build error in
> the spi-rspi driver. This patch fixed the build error.

Applied, thanks.  This should really have been done as part of the shdma
update...
