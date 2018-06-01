From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Fri, 1 Jun 2018 11:14:52 +0200
Message-ID: <a2f96430-d880-dea1-436c-191cddac431e@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <DB6PR0402MB2838F1DE06025F231537DD68996C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180530162439.7b5eec2b@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
 "richard@nod.at" <richard@nod.at>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, Han Xu <han.xu@nxp.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, David Wolfe <david.wolfe@nxp.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180530162439.7b5eec2b@bbrezillon>
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

Hi Yogesh,

On 30.05.2018 16:24, Boris Brezillon wrote:
> Hi Yogesh,
> 
> On Wed, 30 May 2018 13:50:51 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
>> Hi Frieder,
>>
>> Thanks for migrating the fsl-quadspi.c driver on the new SPI
>> framework. This patch is using dynamic LUT approach to create the LUT
>> at run time instead of fixed static LUT as being used in current
>> driver present at mtd/spi-nor/fsl-quadspi.c. I have pushed the
>> changes for dynamic LUT on mtd/spi-nor/fsl-quadspi.c and v10 has been
>> in review stage.
>>
>> Request you to please add 'signed-off' mentioned in those patches in
>> this patch, patchwork link is
>> https://patchwork.ozlabs.org/patch/896534/

So for reasons already given by Boris, I won't add your S-o-b tags. But 
I can add your name (and that of Suresh Gupta?) to the file header and 
as MODULE_AUTHOR in the next version.

Regards,

Frieder

> 
> First, I'd like to state that this work has not been based on your
> dynamic LUT code, and I actually asked you to adapt your code to match
> the way we were handling it in the new driver (which at that time was
> still under development). Then, even if you want to be cited as one of
> the author of the new code, SoB tag is not the right way to do it (see
> [1] for an explanation on when SoB should be added). Instead, you
> should add your name in the copyright header and maybe be add a
> MODULE_AUTHOR():
> 
> /*
>   * Copyright ...
>   * ...
>   * Authors:
>   *	...
>   *	Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
>   */
> 
> ...
> 
> MODULE_AUTHOR("Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>");
> 
> Regards,
> 
> Boris
> 
> [1]https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L429
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
