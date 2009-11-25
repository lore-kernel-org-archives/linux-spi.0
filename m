From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: linux-next: spi tree build warning
Date: Wed, 25 Nov 2009 07:30:19 -0700
Message-ID: <fa686aa40911250630h764c4f26xb2e7cc735261e987@mail.gmail.com>
References: <20091125212959.601673f5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?ISO-8859-1?Q?=22Richard_R=F6jfors=22?=
	<richard.rojfors@mocean-labs.com>,
	spi-devel-general@lists.sourceforge.net
To: Stephen Rothwell <sfr@canb.auug.org.au>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20091125212959.601673f5.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 25, 2009 at 3:29 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Grant,
>
> Today's linux-next build (x86_64 allmodconfig) produced this warning:
>
> drivers/spi/xilinx_spi.c: In function 'xilinx_spi_init':
> drivers/spi/xilinx_spi.c:411: warning: cast from pointer to integer of different size
>
> Maybe introduced by commit 8387f616c653f878b33d859310a8ed5c568505ee
> ("xilinx_spi: Split into of driver and generic part").

Trivial fix committed to next-spi branch:

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index b927812..9f38637 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -408,8 +408,8 @@ struct spi_master *xilinx_spi_init(struct device *dev, struc
                goto free_irq;
        }

-       dev_info(dev, "at 0x%08X mapped to 0x%08X, irq=%d\n",
-               (u32)mem->start, (u32)xspi->regs, xspi->irq);
+       dev_info(dev, "at 0x%08llX mapped to 0x%p, irq=%d\n",
+               (unsigned long long)mem->start, xspi->regs, xspi->irq);
        return master;

 free_irq:
