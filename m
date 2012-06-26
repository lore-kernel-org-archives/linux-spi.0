From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/7] ARM: mxs: Move SSP register definitions into
 separate file
Date: Tue, 26 Jun 2012 14:52:03 +0800
Message-ID: <20120626065201.GL2342@S2101-09.ap.freescale.net>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
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
In-Reply-To: <1340477033-2761-1-git-send-email-marex@denx.de>
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

We should not use prefix "ARM: mxs: ..." for patches in the series,
because it's not changing arch/arm/ part but mmc, spi and clk, and
it's not going to go through arm-soc tree (we could do it, but I'm
afraid that Grant and Chris would hardly agree).  So the best way to
go is, giving a proper subsystem prefix on individual patch, collecting
ACKs from Chris and Mike Turquette, and then asking Grant to have the
whole series go via spi tree.

On Sat, Jun 23, 2012 at 08:43:47PM +0200, Marek Vasut wrote:
> Move the definitions into separate file so separate SPI driver can be
> implemented. The SSP controller in MXS can act both as a MMC host and
> as a SPI host.
> 
> Based on previous attempt by:
> Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Detlev Zundel <dzu@denx.de>
> CC: Dong Aisheng <b29396@freescale.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  drivers/mmc/host/mxs-mmc.c  |   87 ++--------------------------------
>  include/linux/spi/mxs-spi.h |  109 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 84 deletions(-)
>  create mode 100644 include/linux/spi/mxs-spi.h

-- 
Regards,
Shawn
