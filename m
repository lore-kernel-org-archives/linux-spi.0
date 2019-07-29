From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [RFC v1 0/3] *spi-mem: adding setup and callback function
Date: Mon, 29 Jul 2019 17:28:59 +0200
Message-ID: <20190729172859.4374a2ad@collabora.com>
References: <20190729142504.188336-1-tmaimon77@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org, yogeshnarayan.gaur@nxp.com,
        tudor.ambarus@microchip.com, gregkh@linuxfoundation.org,
        frieder.schrempf@exceet.de, tglx@linutronix.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Tomer Maimon <tmaimon77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729142504.188336-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Tomer,

On Mon, 29 Jul 2019 17:25:01 +0300
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Lately we have working on Flash interface unit (FIU) SPI driver that 
> using spi-mem interface, Our FIU HW module support direct Flash Rd//Wr.
> 
> In our SOC (32 bit dual core ARM) we have 3 FIU's that using memory mapping as follow:
> 
> FIU0 - have 2 chip select and each one have 128MB memory mapping (total 256MB memory mapping)
> FIU1 - have 4 chip select and each one have 128MB memory mapping (total 512MB memory mapping)
> FIU2 - have 4 chip select and each one have 16MB memory mapping (total 32MB memory mapping)
> 
> Totally 800MB memory mapping.
> 
> When the FIU driver probe it don't know the size of each Flash that 
> connected to the FIU, so the entire memory mapping is allocated for each FIU 
> according the FIU device tree memory map parameters.

Do you need those mappings to be active to support simple reg accesses?

> It means, if we enable all three FIU's the drivers will try to allocate totally 800MB.
> 
> In 32bit system it is problematic because the kernel have only 1GB 
> of memory allocation so the vmalloc cannot take 800MB.
> 
> When implementing the FIU driver in the mtd/spi-nor we allocating memory address only 
> for detected Flash with exact size (usually we are not using 128MB Flash), and in that case usually we allocating much less memory.
> 
> To solve this issue we needed to overcome two things:
> 
> 1.	Get argument from the upper layer (spi-mem layer) 
> 2.	Calling the get argument function after SPI_NOR_SCAN function. (the MTD Flash size filled in  SPI_NOR_SCAN function)

That's clearly breaking the layering we've tried to restore with the
spi-nor/spi-mem split, and I don't see why this is needed since we now
have a way to create direct mappings dynamically (with the dirmap API).
Have you tried implementing the dirmap hooks in your driver?

Regards,

Boris
