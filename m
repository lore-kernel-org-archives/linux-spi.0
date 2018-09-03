From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: Questions about the Freescale/NXP QuadSPI controller
Date: Mon, 3 Sep 2018 11:02:19 +0200
Message-ID: <121b89ad-712f-166b-83d2-6b0f1bdc750e@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-4-git-send-email-frieder.schrempf@exceet.de>
 <7e95c72c-2cd1-f138-a687-6cca362c95b7@exceet.de>
 <63462dd2-b61b-6522-0619-0cdc89148193@exceet.de>
 <VI1PR0401MB2221D006E89A06B7D343A5E5972C0@VI1PR0401MB2221.eurprd04.prod.outlook.com>
 <20180804153728.0a99d28f@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "richard@nod.at" <richard@nod.at>, Fabio Estevam <fabio.estevam@nxp.com>,
 David Wolfe <david.wolfe@nxp.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
To: Han Xu <han.xu@nxp.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180804153728.0a99d28f@bbrezillon>
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

Hi Han,

On 04.08.2018 15:37, Boris Brezillon wrote:
> Hi Han,
> 
> On Thu, 2 Aug 2018 21:58:48 +0000
> Han Xu <han.xu@nxp.com> wrote:
> 
>>> -----Original Message-----
>>> From: Frieder Schrempf [mailto:frieder.schrempf@exceet.de]
>>> Sent: Thursday, August 2, 2018 8:09 AM
>>> To: David Wolfe <david.wolfe@nxp.com>; Fabio Estevam
>>> <fabio.estevam@nxp.com>; Prabhakar Kushwaha
>>> <prabhakar.kushwaha@nxp.com>; Yogesh Narayan Gaur
>>> <yogeshnarayan.gaur@nxp.com>; Han Xu <han.xu@nxp.com>;
>>> shawnguo@kernel.org
>>> Cc: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com; linux-
>>> spi@vger.kernel.org; dwmw2@infradead.org;
>>> computersforpeace@gmail.com; marek.vasut@gmail.com; richard@nod.at;
>>> miquel.raynal@bootlin.com; broonie@kernel.org
>>> Subject: Re: Questions about the Freescale/NXP QuadSPI controller
>>>
>>> Ping.
>>>
>>> I'm not sure if my message below went out to you at all. At least I can't find it
>>> in the ML archive.
>>>
>>> I still hope someone can help with the questions below.
>>>
>>> Meanwhile for the second point I did some tests myself with one chip on
>>> each of the two buses and it worked fine with my latest v2 patches.
>>> So I'm not sure at all why Yogesh has problems with his setup (two chips on
>>> the first bus).
>>
>> Tried to test the v2 patch set on i.MX6SX SDB board but get the memory map failure.
>>
>> [    1.298633] fsl-quadspi 21e4000.qspi: ioremap failed for resource [mem 0x70000000-0x7fffffff]
>> [    1.307330] fsl-quadspi 21e4000.qspi: Freescale QuadSPI probe failed
>> [    1.313922] fsl-quadspi: probe of 21e4000.qspi failed with error -12
>>
>> This is the reason why dynamic ioremap added in previous driver, please refer to
>>   https://patchwork.ozlabs.org/patch/503655/
> 
> We can reduce the size of the iomap to 2k * 4, since this is all we use
> currently. Can you try to change the size of the ioremap call to 16k and
> tell us if it works.

Were you able to test with the reduced iomap size?
It would be great to know if it works on your board.

Thanks,
Frieder

> 
> Unrelated to this issue, we still have 2 questions left unanswered:
> 
> 1/ is there an easy way to invalidate AHB buffers? I mean, not
>     something that implies a full reset + several milliseconds of delay
>     after the reset. Right now we trick the caching logic by mapping a
>     portion that is twice the size of the buffer and switching from one
>     sub-portion to this other to trigger a real read on each read
>     access, but that's hack-ish, and I'd be surprised if HW
>     engineers hadn't planned for this "manual AHB buffer flush" case.
> 
> 2/ if we use DMA, do you know what happens when the TX FIFO runs out
>     of data while the TX request is not finished yet. In PIO mode, it
>     seems the engine sends garbage on the bus when that happens, and we
>     definitely don't want that.
> 
> While #1 is not blocking us, #2 is if we don't have those patches
> [1][2] applied, and Marek wanted to be sure there was no other
> ways to solve the "TX FIFO starvation" issue before considering these
> changes. So that'd be great if someone from NXP could have a look/ask
> around and give us answers to those 2 questions.
> 
> Thanks,
> 
> Boris
> 
> [1]http://patchwork.ozlabs.org/patch/928677/
> [2]http://patchwork.ozlabs.org/patch/928678/
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
