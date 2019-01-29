From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH] spi: spi-mem: spi-fsl-qspi: typo fix in author name
Date: Tue, 29 Jan 2019 11:46:02 +0000
Message-ID: <4759d7a9-71a2-70a7-2704-0ef7fa37b2ca@kontron.de>
References: <1548755607-27544-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1548755607-27544-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Content-ID: <E72C4CE49EAAC148BF6512A7604DC5F6@snt-world.com>
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

On 29.01.19 10:55, Yogesh Narayan Gaur wrote:
> Typo fix in Author Boris Brezillon last name and update with new
> email address.
> 
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>

Oh, so this was my typo in the first place and you just copied it ;)
Thanks for sending the patch.

Mark, could you please squash this with the original commit 
(84d043185dbe spi: Add a driver for the Freescale/NXP QuadSPI 
controller) in spi-next?

Acked-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/spi/spi-fsl-qspi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index f0a340026ba4..6a713f78a62e 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -10,7 +10,7 @@
>    *
>    * Transition to SPI MEM interface:
>    * Authors:
> - *     Boris Brezillion <boris.brezillon@bootlin.com>
> + *     Boris Brezillon <bbrezillon@kernel.org>
>    *     Frieder Schrempf <frieder.schrempf@kontron.de>
>    *     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>    *     Suresh Gupta <suresh.gupta@nxp.com>
> @@ -959,7 +959,7 @@ module_platform_driver(fsl_qspi_driver);
>   
>   MODULE_DESCRIPTION("Freescale QuadSPI Controller Driver");
>   MODULE_AUTHOR("Freescale Semiconductor Inc.");
> -MODULE_AUTHOR("Boris Brezillion <boris.brezillon@bootlin.com>");
> +MODULE_AUTHOR("Boris Brezillon <bbrezillon@kernel.org>");
>   MODULE_AUTHOR("Frieder Schrempf <frieder.schrempf@kontron.de>");
>   MODULE_AUTHOR("Yogesh Gaur <yogeshnarayan.gaur@nxp.com>");
>   MODULE_AUTHOR("Suresh Gupta <suresh.gupta@nxp.com>");
> 
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
