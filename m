From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/8] mmc: spi: Add SPI driver for mx233/mx28
Date: Thu, 5 Jul 2012 08:51:45 +0800
Message-ID: <20120705005143.GF2595@S2101-09.ap.freescale.net>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
 <1340958180-2291-6-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Wolfgang Denk <wd@denx.de>,
 Detlev Zundel <dzu@denx.de>, Rob Herring <rob.herring@calxeda.com>,
 Grant Likely <grant.likely@secretlab.ca>, Stefano Babic <sbabic@denx.de>,
 spi-devel-general@lists.sourceforge.net, Chris Ball <cjb@laptop.org>,
 Dong Aisheng <b29396@freescale.com>, linux-arm-kernel@lists.infradead.org
To: Marek Vasut <marex@denx.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1340958180-2291-6-git-send-email-marex@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 29, 2012 at 10:22:58AM +0200, Marek Vasut wrote:
> +config SPI_MXS
> +	tristate "Freescale MXS SPI controller"
> +	depends on ARCH_MXS
> +	help
> +	  SPI driver for Freescale MXS devices.
> +

...

> +	stmp_reset_block(ssp->base);
> +
So SPI_MXS may need to select STMP_DEVICE.

-- 
Regards,
Shawn
