From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: do not disable the clock while configuring
 the spi
Date: Thu, 07 Jul 2016 11:41:49 +0200
Message-ID: <577E23DD.1040906@samsung.com>
References: <1467876237-12183-1-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org
To: Andi Shyti <andi.shyti@samsung.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1467876237-12183-1-git-send-email-andi.shyti@samsung.com>
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

On 07/07/2016 09:23 AM, Andi Shyti wrote:
> When the clock is coming from the cmu it is not required to be
> disabled and then re-enabled in order to change the rate.
> 
> Besides, some exynos chipsets (e.g. exynos5433) do not deliver
> any to the SFR if one from the pclk ("spi" in this case) or sclk
> ("busclk") is disabled.
> 
> Remove the clock disabling/enabling to avoid falling into this
> situation.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
> 
> Hi,
> 
> This patch has been tested by me and Sylwester on Trats2
> (exynos4412) and tm2(e) (exynos5433) boards, for big data
> (which use dma transfer) and small data.
> 
> It also fixes in exynos5433 a synchronus abort caused by the fact
> that the pclk (spi) doesn't get delivered if the sclk is disabled
> (busclk)
> 
> Thanks,
> Andi
> 
>  drivers/spi/spi-s3c64xx.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
