From: Marek Vasut <marex@denx.de>
Subject: Re: Handling vmalloc'd buffers in spi-nor
Date: Sun, 26 Feb 2017 16:55:58 +0100
Message-ID: <14c04e25-cba3-ce68-3177-5afb4fab6cc2@denx.de>
References: <8cf1d1d9-38a1-cbef-9a9b-07d2ecf2727f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Frode Isaksen <fisaksen@baylibre.com>, Sekhar Nori <nsekhar@ti.com>,
 Russell King <linux@armlinux.org.uk>, linux-spi <linux-spi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>
To: Vignesh R <vigneshr@ti.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <8cf1d1d9-38a1-cbef-9a9b-07d2ecf2727f@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 02/21/2017 09:37 AM, Vignesh R wrote:
> Hi all,

Hi!

> I have come across couple of problems[1] when using m25p80 driver with
> SPI flash over SPI bus with DMA. Basically filesystems like UBIFS may
> pass vmalloc'd buffers to SPI NOR layer which will end up in SPI layer.
> SPI core does try to handle such buffers (see spi_map_buf()) by doing
> vmalloc_to_page() and creating scatterlist.
> But, its known that this does not work well with VIVT/aliasing cache
> architectures.
> This also fails when buffers are addressed using LPAE (buffers in region
> higher than 32 bit addressable region), if DMA is 32bit only.
> 
> IMO, it would be better if vmalloc'd buffers are handled in SPI NOR
> layer, just like nand, instead of passing them onto SPI layer.
> In order to deal with vmalloc'd buffers passed by higher layers (like
> UBIFS), I propose to use pre-allocated per flash bounce buffer equal to
> the sector size of the flash. This feature can be enabled using a flag
> similar to NAND_USE_BOUNCE_BUFFER. The changes will be mostly restricted
> to spi_nor_read/write functions. This will help SPI drivers to use DMA
> with NOR flashes with filesystems.
> 
> This would also enable other SPI NOR drivers to safely use DMA in their
> read/write callbacks.
> 
> Any thoughts/comments?

Code please :-)

Let's discuss this over a patch. With the recent spi-nor and spi-nand
controllers, I think this makes sense though.

> Thanks!
> 
> [1]https://www.spinics.net/lists/arm-kernel/msg563773.html
> 


-- 
Best regards,
Marek Vasut

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
