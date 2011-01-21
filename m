From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] SPI: spi_sh_msiof: cosmetic clean-up
Date: Fri, 21 Jan 2011 12:12:12 -0700
Message-ID: <20110121191212.GE7477@angua.secretlab.ca>
References: <Pine.LNX.4.64.1101211654280.18867@axis700.grange>
 <20110121170247.GB7477@angua.secretlab.ca>
 <Pine.LNX.4.64.1101211806360.18867@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1101211806360.18867@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 21, 2011 at 06:10:50PM +0100, Guennadi Liakhovetski wrote:
> On Fri, 21 Jan 2011, Grant Likely wrote:
> 
> > On Fri, Jan 21, 2011 at 04:56:37PM +0100, Guennadi Liakhovetski wrote:
> > > 1. sort headers alphabetically
> > > 2. use fixed-size types u8, u16, u32 for register values and transferred data
> > > 3. simplify some arithmetic operations
> > > 4. remove leading spaces in front of labels
> > 
> > There's actually good reason to leave these labels alone.  Labels in
> > column zero confuse diff and it gives the wrong function name.  For
> > example:
> > 
> > diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
> > index 658bd05..840164b 100644
> > --- a/drivers/spi/spi_sh_msiof.c
> > +++ b/drivers/spi/spi_sh_msiof.c
> > @@ -682,7 +682,7 @@ err2:
> >         clk_put(p->clk);
> >  err1:
> >         spi_master_put(master);
> > -err0:
> > + err0:
> >         return ret;
> >  }
> > 
> > See how the function name in the @@ line is 'err2' instead of
> > sh_msiof_spi_probe() in this example?  Indenting the labels by one
> > space is an easy fix and is intentional.
> > 
> > I've picked up the patch, but I've dropped the last two hunks.
> 
> Strange, my "git diff" doesn't get confused - as in the patch, that 
> I've sent to you... Time to update your git?;) So, personally, I wouldn't 
> hold _that_ for a reason. Well, CodingStyle doesn't directly say anything 
> about those labels, but an example in it puts one at offset 0... Anyway, 
> that's not critical, of course.

Of course it didn't.  The diff hunk started before a label.  My
machine does the same with your patch, here:

diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
index 56f60c8..a81a836 100644
--- a/drivers/spi/spi_sh_msiof.c
+++ b/drivers/spi/spi_sh_msiof.c
@@ -617,13 +617,13 @@ static int sh_msiof_spi_probe(struct platform_device *pdev
                return 0;
 
        pm_runtime_disable(&pdev->dev);
- err3:
+err3:
        iounmap(p->mapbase);
- err2:
+err2:
        clk_put(p->clk);
- err1:
+err1:
        spi_master_put(master);
- err0:
+err0:
        return ret;
 }

However, try it with only changing the last label so that diff hunk
begins later.  Actually, what you need to try is apply your original
patch so that all the labels are in column zero, and then indent only
the last label so it looks like the example I sent you.  I'll bet you
a beer that it gets confused.  :-)

g.

> 
> Thanks
> Guennadi
> 
> > 
> > g.
> > 
> > 
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > ---
> > >  drivers/spi/spi_sh_msiof.c |   78 ++++++++++++++++++++++----------------------
> > >  1 files changed, 39 insertions(+), 39 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
> > > index 56f60c8..07b4ead 100644
> > > --- a/drivers/spi/spi_sh_msiof.c
> > > +++ b/drivers/spi/spi_sh_msiof.c
> > > @@ -9,22 +9,22 @@
> > >   *
> > >   */
> > >  
> > > -#include <linux/kernel.h>
> > > -#include <linux/init.h>
> > > +#include <linux/bitmap.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/completion.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/err.h>
> > > +#include <linux/gpio.h>
> > > +#include <linux/init.h>
> > >  #include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/kernel.h>
> > >  #include <linux/platform_device.h>
> > > -#include <linux/completion.h>
> > >  #include <linux/pm_runtime.h>
> > > -#include <linux/gpio.h>
> > > -#include <linux/bitmap.h>
> > > -#include <linux/clk.h>
> > > -#include <linux/io.h>
> > > -#include <linux/err.h>
> > >  
> > > +#include <linux/spi/sh_msiof.h>
> > >  #include <linux/spi/spi.h>
> > >  #include <linux/spi/spi_bitbang.h>
> > > -#include <linux/spi/sh_msiof.h>
> > >  
> > >  #include <asm/unaligned.h>
> > >  
> > > @@ -67,7 +67,7 @@ struct sh_msiof_spi_priv {
> > >  #define STR_TEOF  (1 << 23)
> > >  #define STR_REOF  (1 << 7)
> > >  
> > > -static unsigned long sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
> > > +static u32 sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
> > >  {
> > >  	switch (reg_offs) {
> > >  	case TSCR:
> > > @@ -79,7 +79,7 @@ static unsigned long sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
> > >  }
> > >  
> > >  static void sh_msiof_write(struct sh_msiof_spi_priv *p, int reg_offs,
> > > -			   unsigned long value)
> > > +			   u32 value)
> > >  {
> > >  	switch (reg_offs) {
> > >  	case TSCR:
> > > @@ -93,10 +93,10 @@ static void sh_msiof_write(struct sh_msiof_spi_priv *p, int reg_offs,
> > >  }
> > >  
> > >  static int sh_msiof_modify_ctr_wait(struct sh_msiof_spi_priv *p,
> > > -				    unsigned long clr, unsigned long set)
> > > +				    u32 clr, u32 set)
> > >  {
> > > -	unsigned long mask = clr | set;
> > > -	unsigned long data;
> > > +	u32 mask = clr | set;
> > > +	u32 data;
> > >  	int k;
> > >  
> > >  	data = sh_msiof_read(p, CTR);
> > > @@ -166,10 +166,10 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
> > >  }
> > >  
> > >  static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
> > > -				      int cpol, int cpha,
> > > -				      int tx_hi_z, int lsb_first)
> > > +				      u32 cpol, u32 cpha,
> > > +				      u32 tx_hi_z, u32 lsb_first)
> > >  {
> > > -	unsigned long tmp;
> > > +	u32 tmp;
> > >  	int edge;
> > >  
> > >  	/*
> > > @@ -187,7 +187,7 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
> > >  	tmp |= cpol << 30; /* TSCKIZ */
> > >  	tmp |= cpol << 28; /* RSCKIZ */
> > >  
> > > -	edge = cpol ? cpha : !cpha;
> > > +	edge = cpol ^ !cpha;
> > >  
> > >  	tmp |= edge << 27; /* TEDG */
> > >  	tmp |= edge << 26; /* REDG */
> > > @@ -197,11 +197,9 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
> > >  
> > >  static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
> > >  				       const void *tx_buf, void *rx_buf,
> > > -				       int bits, int words)
> > > +				       u32 bits, u32 words)
> > >  {
> > > -	unsigned long dr2;
> > > -
> > > -	dr2 = ((bits - 1) << 24) | ((words - 1) << 16);
> > > +	u32 dr2 = ((bits - 1) << 24) | ((words - 1) << 16);
> > >  
> > >  	if (tx_buf)
> > >  		sh_msiof_write(p, TMDR2, dr2);
> > > @@ -222,7 +220,7 @@ static void sh_msiof_reset_str(struct sh_msiof_spi_priv *p)
> > >  static void sh_msiof_spi_write_fifo_8(struct sh_msiof_spi_priv *p,
> > >  				      const void *tx_buf, int words, int fs)
> > >  {
> > > -	const unsigned char *buf_8 = tx_buf;
> > > +	const u8 *buf_8 = tx_buf;
> > >  	int k;
> > >  
> > >  	for (k = 0; k < words; k++)
> > > @@ -232,7 +230,7 @@ static void sh_msiof_spi_write_fifo_8(struct sh_msiof_spi_priv *p,
> > >  static void sh_msiof_spi_write_fifo_16(struct sh_msiof_spi_priv *p,
> > >  				       const void *tx_buf, int words, int fs)
> > >  {
> > > -	const unsigned short *buf_16 = tx_buf;
> > > +	const u16 *buf_16 = tx_buf;
> > >  	int k;
> > >  
> > >  	for (k = 0; k < words; k++)
> > > @@ -242,7 +240,7 @@ static void sh_msiof_spi_write_fifo_16(struct sh_msiof_spi_priv *p,
> > >  static void sh_msiof_spi_write_fifo_16u(struct sh_msiof_spi_priv *p,
> > >  					const void *tx_buf, int words, int fs)
> > >  {
> > > -	const unsigned short *buf_16 = tx_buf;
> > > +	const u16 *buf_16 = tx_buf;
> > >  	int k;
> > >  
> > >  	for (k = 0; k < words; k++)
> > > @@ -252,7 +250,7 @@ static void sh_msiof_spi_write_fifo_16u(struct sh_msiof_spi_priv *p,
> > >  static void sh_msiof_spi_write_fifo_32(struct sh_msiof_spi_priv *p,
> > >  				       const void *tx_buf, int words, int fs)
> > >  {
> > > -	const unsigned int *buf_32 = tx_buf;
> > > +	const u32 *buf_32 = tx_buf;
> > >  	int k;
> > >  
> > >  	for (k = 0; k < words; k++)
> > > @@ -262,7 +260,7 @@ static void sh_msiof_spi_write_fifo_32(struct sh_msiof_spi_priv *p,
> > >  static void sh_msiof_spi_write_fifo_32u(struct sh_msiof_spi_priv *p,
> > >  					const void *tx_buf, int words, int fs)
> > >  {
> > > -	const unsigned int *buf_32 = tx_buf;
> > > +	const u32 *buf_32 = tx_buf;
> > >  	int k;
> > >  
> > >  	for (k = 0; k < words; k++)
> > > @@ -272,7 +270,7 @@ static void sh_msiof_spi_write_fifo_32u(struct sh_msiof_spi_priv *p,
> > >  static void sh_msiof_spi_read_fifo_8(struct sh_msiof_spi_priv *p,
> > >  				     void *rx_buf, int words, int fs)
> > >  {
> > > -	unsigned char *buf_8 = rx_buf;
> > > +	u8 *buf_8 = rx_buf;
> > >  	int k;
> > >  
> > >  	for (k = 0; k < words; k++)
> > > @@ -282,7 +280,7 @@ static void sh_msiof_spi_read_fifo_8(struct sh_msiof_spi_priv *p,
> > >  static void sh_msiof_spi_read_fifo_16(struct sh_msiof_spi_priv *p,
> > >  				      void *rx_buf, int words, int fs)
> > >  {
> > > -	unsigned short *buf_16 = rx_buf;
> > > +	u16 *buf_16 = rx_buf;
> > >  	int k;
> > >  
> > >  	for (k = 0; k < words; k++)
> > > @@ -292,7 +290,7 @@ static void sh_msiof_spi_read_fifo_16(struct sh_msiof_spi_priv *p,
> > >  static void sh_msiof_spi_read_fifo_16u(struct sh_msiof_spi_priv *p,
> > >  				       void *rx_buf, int words, int fs)
> > >  {
> > > -	unsigned short *buf_16 = rx_buf;
> > > +	u16 *buf_16 = rx_buf;
> > >  	int k;
> > >  
> > >  	for (k = 0; k < words; k++)
> > > @@ -302,7 +300,7 @@ static void sh_msiof_spi_read_fifo_16u(struct sh_msiof_spi_priv *p,
> > >  static void sh_msiof_spi_read_fifo_32(struct sh_msiof_spi_priv *p,
> > >  				      void *rx_buf, int words, int fs)
> > >  {
> > > -	unsigned int *buf_32 = rx_buf;
> > > +	u32 *buf_32 = rx_buf;
> > >  	int k;
> > >  
> > >  	for (k = 0; k < words; k++)
> > > @@ -312,7 +310,7 @@ static void sh_msiof_spi_read_fifo_32(struct sh_msiof_spi_priv *p,
> > >  static void sh_msiof_spi_read_fifo_32u(struct sh_msiof_spi_priv *p,
> > >  				       void *rx_buf, int words, int fs)
> > >  {
> > > -	unsigned int *buf_32 = rx_buf;
> > > +	u32 *buf_32 = rx_buf;
> > >  	int k;
> > >  
> > >  	for (k = 0; k < words; k++)
> > > @@ -324,7 +322,8 @@ static int sh_msiof_spi_bits(struct spi_device *spi, struct spi_transfer *t)
> > >  	int bits;
> > >  
> > >  	bits = t ? t->bits_per_word : 0;
> > > -	bits = bits ? bits : spi->bits_per_word;
> > > +	if (!bits)
> > > +		bits = spi->bits_per_word;
> > >  	return bits;
> > >  }
> > >  
> > > @@ -334,7 +333,8 @@ static unsigned long sh_msiof_spi_hz(struct spi_device *spi,
> > >  	unsigned long hz;
> > >  
> > >  	hz = t ? t->speed_hz : 0;
> > > -	hz = hz ? hz : spi->max_speed_hz;
> > > +	if (!hz)
> > > +		hz = spi->max_speed_hz;
> > >  	return hz;
> > >  }
> > >  
> > > @@ -453,7 +453,7 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
> > >  
> > >  	return words;
> > >  
> > > - err:
> > > +err:
> > >  	sh_msiof_write(p, IER, 0);
> > >  	return ret;
> > >  }
> > > @@ -617,13 +617,13 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
> > >  		return 0;
> > >  
> > >  	pm_runtime_disable(&pdev->dev);
> > > - err3:
> > > +err3:
> > >  	iounmap(p->mapbase);
> > > - err2:
> > > +err2:
> > >  	clk_put(p->clk);
> > > - err1:
> > > +err1:
> > >  	spi_master_put(master);
> > > - err0:
> > > +err0:
> > >  	return ret;
> > >  }
> > >  
> > > -- 
> > > 1.7.2.3
> > > 
> > > 
> > > ------------------------------------------------------------------------------
> > > Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
> > > Finally, a world-class log management solution at an even better price-free!
> > > Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
> > > February 28th, so secure your free ArcSight Logger TODAY! 
> > > http://p.sf.net/sfu/arcsight-sfd2d
> > > _______________________________________________
> > > spi-devel-general mailing list
> > > spi-devel-general@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> > 
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
