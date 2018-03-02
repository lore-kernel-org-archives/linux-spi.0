From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] spi: Fix scatterlist elements size in spi_map_buf
Date: Fri, 2 Mar 2018 17:54:58 +0100
Message-ID: <20180302165458.GC8704@kroah.com>
References: <20180302145509.24563-1-maxime.chevallier@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180302145509.24563-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Mar 02, 2018 at 03:55:09PM +0100, Maxime Chevallier wrote:
> When SPI transfers can be offloaded using DMA, the SPI core need to
> build a scatterlist to make sure that the buffer to be transferred is
> dma-able.
> 
> This patch fixes the scatterlist entry size computation in the case
> where the maximum acceptable scatterlist entry supported by the DMA
> controller is less than PAGE_SIZE, when the buffer is vmalloced.
> 
> For each entry, the actual size is given by the minimum between the
> desc_len (which is the max buffer size supported by the DMA controller)
> and the remaining buffer length until we cross a page boundary.
> 
> Fixes: 65598c13fd66 ("spi: Fix per-page mapping of unaligned vmalloc-ed buffer")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/spi/spi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
