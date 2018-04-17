From: andi@etezian.org
Subject: Re: [PATCH v2 8/8] spi: spi-s3c64xx: Allow higher transfer lengths in
 polling IO mode
Date: Wed, 18 Apr 2018 03:27:16 +0900
Message-ID: <0401102d3363dae0cf2a19c3546428f2@etezian.org>
References: <20180417142954.5507-1-s.nawrocki@samsung.com>
 <CGME20180417143100epcas2p228d05e4de4ce06621635a523241d9824@epcas2p2.samsung.com>
 <20180417142954.5507-8-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 krzk@kernel.org, linux-spi@vger.kernel.org, broonie@kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180417142954.5507-8-s.nawrocki@samsung.com>
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

On 17.04.2018 23:29, Sylwester Nawrocki wrote:
> Some variants of the SPI controller have no DMA support, in such case
> SPI transfers longer than the FIFO length are not currently properly
> handled by the driver. Fix it by doing multiple transfers in the
> s3c64xx_spi_transfer_one() function if the SPI transfer length exceeds
> the FIFO size.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

thank you! it looks good.

Unfortunately I don't have right now the device with me
to test it, in any case you can add

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
