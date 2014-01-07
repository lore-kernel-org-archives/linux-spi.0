From: Chao Fu <B44548@freescale.com>
Subject: RE: [PATCH] spi:fsl-dspi:add support of DSPI IP in big endian
Date: Tue, 7 Jan 2014 03:54:25 +0000
Message-ID: <79669bf1a15247cb95a2609bad5e9c5d@BL2PR03MB163.namprd03.prod.outlook.com>
References: <1388388474-8662-1-git-send-email-b44548@freescale.com>
 <20131230134217.GC31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jingchang Lu <jingchang.lu@freescale.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131230134217.GC31886@sirena.org.uk>
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

> > +#define dspi_readb(c)		readb(c)
> > +#define dspi_readw(c)		({ u16 __v = (__force u16)
> __raw_readw(c); __iormb(); __v; })
> > +#define dspi_readl(c)		({ u32 __v = (__force u32)
> __raw_readl(c); __iormb(); __v; })
> > +#define dspi_writeb(v, c)	writeb(v, c)
> > +#define dspi_writew(v, c)	({ __iowmb(); __raw_writew((__force u16) v,
> c); })
> > +#define dspi_writel(v, c)	({ __iowmb(); __raw_writel((__force u32) v,
> c); })
> > +
> 
> For type safety and general legibility make these inline functions
> instead of macros, the generated code should be the same.  It's also not
> clear why you're adding iowmb()s that weren't in the code before, and see
> below...
> 
[Chao Fu] Thank you, Mark! I will put them into inline functions.
Here use iowmb for avoiding instruction reorder.

> > @@ -110,9 +120,10 @@ struct fsl_dspi {
> >
> >  	void __iomem		*base;
> >  	int			irq;
> > -	struct clk 		*clk;
> > +	struct clk		*clk;
> >
> > -	struct spi_transfer 	*cur_transfer;
> > +	bool			big_endian;
> > +	struct spi_transfer	*cur_transfer;
> 
> Seems like there's some whitespace changes crept in here and elsewhere
> which makes things harder to review.


[Chao Fu] Here is some coding style not in standard in former code, 
should I take this opportunity to modify here? 
