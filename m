From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: Questions about the Freescale/NXP QuadSPI controller
Date: Thu, 2 Aug 2018 15:09:03 +0200
Message-ID: <63462dd2-b61b-6522-0619-0cdc89148193@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-4-git-send-email-frieder.schrempf@exceet.de>
 <7e95c72c-2cd1-f138-a687-6cca362c95b7@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: boris.brezillon@bootlin.com, richard@nod.at, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, broonie@kernel.org, linux-mtd@lists.infradead.org,
 miquel.raynal@bootlin.com, computersforpeace@gmail.com, dwmw2@infradead.org
To: david.wolfe@nxp.com, fabio.estevam@nxp.com, prabhakar.kushwaha@nxp.com,
 yogeshnarayan.gaur@nxp.com, han.xu@nxp.com, shawnguo@kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <7e95c72c-2cd1-f138-a687-6cca362c95b7@exceet.de>
Content-Language: en-US
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

Ping.

I'm not sure if my message below went out to you at all. At least I 
can't find it in the ML archive.

I still hope someone can help with the questions below.

Meanwhile for the second point I did some tests myself with one chip on 
each of the two buses and it worked fine with my latest v2 patches.
So I'm not sure at all why Yogesh has problems with his setup (two chips 
on the first bus).

Thanks,
Frieder

On 11.07.2018 14:13, Frieder Schrempf wrote:
> Hi guys from NXP,
> 
> we still have some issues/questions concerning the FSL QSPI IP, that 
> somehow block the new driver under the SPI memory framework [1].
> 
> If anyone of you could comment on these, or help finding solutions, this 
> would be very much appreciated.
> 
> 1. The SPI NOR driver was using a reset of the flash and AHB domain to 
> invalidate the AHB buffer [2]. But this needs quite a lot of time, so we 
> have a hack to use two regions in memory and switch between them 
> alternately to invalidate the cache [3]. As this is not so nice, do you 
> know of any other possibility to invalidate the flash?
> 
> 2. We tried to reuse the mapped memory to access different chips on 
> different CS, by switching the QUADSPI_SFA1AD, QUADSPI_SFA2AD, etc. 
> accordingly [4]. This doesn't work as expected, but Yogesh found out, 
> that it works with a fixed memory map for each CS and by adding a 
> ioremap(), as the SPI NOR driver does [5]. Can someone explain this 
> behavior and why the ioremap is needed?
> 
> 3. In case of a NOR page program operation, the driver is expected to 
> write the full page, even if it's larger than the TX buffer size. Boris 
> explained this here: [6].
> So we need to find a way of triggering a refill of the TX buffer by CPU 
> or DMA if possible.
> 
> Thank you in advance for your help,
> 
> Frieder
> 
> [1] https://patchwork.ozlabs.org/cover/939864/
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mtd/spi-nor/fsl-quadspi.c?h=v4.18-rc4#n591 
> 
> [3] 
> https://github.com/fschrempf/linux/blob/fsl-qspi-next-2/drivers/spi/spi-fsl-qspi.c#L511 
> 
> [4] 
> https://github.com/fschrempf/linux/blob/fsl-qspi-next-2/drivers/spi/spi-fsl-qspi.c#L476 
> 
> [5] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mtd/spi-nor/fsl-quadspi.c?h=v4.18-rc4#n906 
> 
> [6] https://patchwork.ozlabs.org/patch/928677/#1950278

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
