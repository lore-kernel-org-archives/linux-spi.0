From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 1/3 v2] [RESEND]spi: controller
 driver for Designware SPI core
Date: Tue, 29 Sep 2009 15:16:58 -0700
Message-ID: <20090929151658.702e2c63.akpm@linux-foundation.org>
References: <20090921164729.3e45744d@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090921164729.3e45744d@feng-desktop>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 21 Sep 2009 16:47:29 +0800
Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> >From 5d87c87105aba522468cabb6fe206a4515dc85e8 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date: Tue, 4 Aug 2009 16:23:47 +0800
> Subject: [PATCH 1/3] spi: controller driver for Designware SPI core
> 
> Driver for the Designware SPI core, it supports multipul interfaces
> like PCI/APB etc. User can use "dw_apb_ssi_db.pdf" from Synopsys as
> HW datasheet.

It appears that your email client replaced all the tabs with spaces - I
cannot apply these patches.


>
> ...
>
> +#define SPI_REGS_BUFSIZE       1024
> +static ssize_t  spi_show_regs(struct file *file, char __user *user_buf,
> +                               size_t count, loff_t *ppos)
> +{
> +       struct dw_spi *dws;
> +       char *buf;
> +       u32 len = 0;
> +       ssize_t ret;
> +
> +       dws = (struct dw_spi *)file->private_data;

Unneeded and undesirable cast of void*.

> +       buf = kzalloc(SPI_REGS_BUFSIZE, GFP_KERNEL);
> +       if (!buf)
> +               return 0;
> +
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "MRST SPI0 registers:\n");
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "=================================\n");
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "CTRL0: \t\t0x%08x\n", dw_readl(dws, ctrl0));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "CTRL1: \t\t0x%08x\n", dw_readl(dws, ctrl1));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "SSIENR: \t0x%08x\n", dw_readl(dws, ssienr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "SER: \t\t0x%08x\n", dw_readl(dws, ser));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "BAUDR: \t\t0x%08x\n", dw_readl(dws, baudr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "TXFTLR: \t0x%08x\n", dw_readl(dws, txfltr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "RXFTLR: \t0x%08x\n", dw_readl(dws, rxfltr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "TXFLR: \t\t0x%08x\n", dw_readl(dws, txflr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "RXFLR: \t\t0x%08x\n", dw_readl(dws, rxflr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "SR: \t\t0x%08x\n", dw_readl(dws, sr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "IMR: \t\t0x%08x\n", dw_readl(dws, imr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "ISR: \t\t0x%08x\n", dw_readl(dws, isr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "DMACR: \t\t0x%08x\n", dw_readl(dws, dmacr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "DMATDLR: \t0x%08x\n", dw_readl(dws, dmatdlr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "DMARDLR: \t0x%08x\n", dw_readl(dws, dmardlr));
> +       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +                       "=================================\n");
> +
> +       ret =  simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +       kfree(buf);
> +       return ret;
> +}
> +
>
> ...
>
> +static int flush(struct dw_spi *dws)
> +{
> +       unsigned long limit = loops_per_jiffy << 1;
> +
> +       while (dw_readw(dws, sr) & SR_RF_NOT_EMPT) {
> +               limit = loops_per_jiffy << 1;
> +               while ((dw_readw(dws, sr) & SR_BUSY) && limit--)
> +                       ;
> +               dw_readw(dws, dr);
> +       }
> +       return limit;
> +}

The duration of this timeout will have little relation to jiffies or
anything like that.  It'll mainly be dependent upon bus latencies.  You
may find that the upper bound to this delay is very large indeed.

If you really did intend to set some upper bound on the polling period,
it'd be better to do

	unsigned long end = jiffies + usecs_to_jiffies(1000);

	while (time_before(jiffies, end)) {
		...
	}

or something along those lines.

>
> ...
>
> +static int u16_reader(struct dw_spi *dws)
> +{
> +       u16 temp;
> +
> +       while ((dw_readw(dws, sr) & SR_RF_NOT_EMPT)
> +               && (dws->rx < dws->rx_end)) {
> +               temp = dw_readw(dws, dr);
> +               *(u16 *)(dws->rx) = temp;
> +               dws->rx += 2;
> +       }
> +
> +       while (dw_readw(dws, sr) & SR_BUSY)
> +               ;

The code does this a lot.

It's a bit of a worry - if the hardware is misbehaving or gets
hot-unplugged or powered off or such, the kernel will silently lock up.

Better practice would be to pull this into a separate function and to
at least emit a printk from that function when the hardware has locked
up.  Even better, handle that error and recover.

> +       return dws->rx == dws->rx_end;
> +}
> +
>
> ...
>
> +static inline void unmap_dma_buffers(struct dw_spi *dws)
> +{
> +       if (!dws->dma_mapped)
> +               return;
> +       dws->dma_mapped = 0;
> +}

One would think that a function called unmap_dma_buffers() would unmap
dma buffers.  But this doesn't do that.

>
> ...
>


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
