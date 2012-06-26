From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
Date: Tue, 26 Jun 2012 20:31:43 +0800
Message-ID: <20120626123141.GH8858@S2101-09.ap.freescale.net>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
 <1340477033-2761-7-git-send-email-marex@denx.de>
 <20120626074342.GA4928@S2101-09.ap.freescale.net>
 <201206261422.55005.marex@denx.de>
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
In-Reply-To: <201206261422.55005.marex@denx.de>
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

On Tue, Jun 26, 2012 at 02:22:54PM +0200, Marek Vasut wrote:
> > > +static int __devexit mxs_spi_remove(struct platform_device *pdev)
> > > +{
> > > +	struct spi_master *host;
> > > +	struct mxs_ssp *ssp;
> > > +
> > > +	host = platform_get_drvdata(pdev);
> > > +	if (host)
> > > +		return 0;
> > 
> > Hmm, why the check and return here?
> 
> If it's not set, things went _very_ wrong somewhere. Maybe BUG_ON() might be 
> better?
> 
So shouldn't it be "if (!host)"?

And I still do not understand how that could happen.  I think
mxs_spi_remove will only be called in case that mxs_spi_probe
succeeds, which means platform_set_drvdata must have been called
already?

-- 
Regards,
Shawn
