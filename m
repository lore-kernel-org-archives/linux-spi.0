From: andi@etezian.org
Subject: Re: [PATCH 6/6] spi: spi-s3c64xx: Allow higher transfer lengths in
 polling IO mode
Date: Tue, 17 Apr 2018 04:19:42 +0900
Message-ID: <93a6b80d599a40a39ae396f5dcd7c5b7@etezian.org>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154208epcas1p1774dd679e3564be916901a180315943b@epcas1p1.samsung.com>
 <20180416154021.25626-6-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 krzk@kernel.org, linux-spi@vger.kernel.org, broonie@kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180416154021.25626-6-s.nawrocki@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Sylwester,

On 17.04.2018 00:40, Sylwester Nawrocki wrote:
> Some variants of the SPI controller have no DMA support, in such case
> SPI transfers longer than the FIFO length are not currently properly
> handled by the driver. Fix it by doing multiple transfers in the
> s3c64xx_spi_transfer_one() function if the SPI transfer length exceeds
> the FIFO size.

this patch is a mix of cosmetics and what you are actually describing
in the commit log...

> @@ -634,11 +634,15 @@ static int s3c64xx_spi_transfer_one(struct
> spi_master *master,
>  				    struct spi_transfer *xfer)
>  {
>  	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
> +	const unsigned int fifo_len = (FIFO_LVL_MASK(sdd) >> 1) + 1;
> +	const void *tx_buf = NULL;
> +	void *rx_buf = NULL;
> +	int target_len = 0, origin_len = 0;
> +	bool use_dma = false;
>  	int status;
>  	u32 speed;
>  	u8 bpw;
>  	unsigned long flags;
> -	int use_dma;

... for example 'use_dma' bool instead of int or the 'fifo_len'. I agree
with these changes and, even though they are trivial, I would prefer
having them in separate patches.

Thanks,
Andi
