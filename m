From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/7] ARM: mxs: Add SPI clock into clk framwork
Date: Tue, 26 Jun 2012 20:24:26 +0800
Message-ID: <20120626122424.GG8858@S2101-09.ap.freescale.net>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
 <1340477033-2761-4-git-send-email-marex@denx.de>
 <20120626065428.GM2342@S2101-09.ap.freescale.net>
 <201206261416.11599.marex@denx.de>
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
In-Reply-To: <201206261416.11599.marex@denx.de>
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

On Tue, Jun 26, 2012 at 02:16:11PM +0200, Marek Vasut wrote:
> So why are those imx28-mmc there ? Shall these not be removed then ?
> 
They are still needed by those non-DT board files.  Once we have those
board files removed, these imx28-mmc lookups will not be needed any
longer.

-- 
Regards,
Shawn
