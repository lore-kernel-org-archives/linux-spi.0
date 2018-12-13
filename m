From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
Date: Thu, 13 Dec 2018 10:04:56 +0100
Message-ID: <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
         <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2018-12-13 at 16:39 +0800, Sunny Luo wrote:
> The SPICC controller in Meson-AXG is capable of driving the CLK/MOSI/SS
> signal lines through the idle state (between two transmission operation),
> which avoid the signals floating in unexpected state.
> 
> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/spi/spi-meson-spicc.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index b56249d..0384c28 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -115,6 +115,13 @@
>  
>  #define SPICC_DWADDR	0x24	/* Write Address of DMA */
>  
> +#define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
> +#define SPICC_ENH_MOSI_OEN		BIT(25)
> +#define SPICC_ENH_CLK_OEN		BIT(26)
> +#define SPICC_ENH_CS_OEN		BIT(27)
> +#define SPICC_ENH_CLK_CS_DELAY_EN	BIT(28)
> +#define SPICC_ENH_MAIN_CLK_AO		BIT(29)
> +
>  #define writel_bits_relaxed(mask, val, addr) \
>  	writel_relaxed((readl_relaxed(addr) & ~(mask)) | (val), addr)
>  
> @@ -123,6 +130,7 @@
>  
>  struct meson_spicc_data {
>  	unsigned int			max_speed_hz;
> +	bool				has_oen;
>  };
>  
>  struct meson_spicc_device {
> @@ -145,6 +153,19 @@ struct meson_spicc_device {
>  	bool				is_last_burst;
>  };
>  
> +static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
> +{
> +	u32 conf;
> +
> +	if (!spicc->data->has_oen)
> +		return;
> +
> +	conf = readl_relaxed(spicc->base + SPICC_ENH_CTL0) |
> +		SPICC_ENH_MOSI_OEN | SPICC_ENH_CLK_OEN | SPICC_ENH_CS_OEN;
> +
> +	writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
> +}
> +
>  static inline bool meson_spicc_txfull(struct meson_spicc_device *spicc)
>  {
>  	return !!FIELD_GET(SPICC_TF,
> @@ -453,6 +474,8 @@ static int meson_spicc_prepare_message(struct spi_master
> *master,
>  
>  	writel_bits_relaxed(BIT(24), BIT(24), spicc->base + SPICC_TESTREG);
>  
> +	meson_spicc_oen_enable(spicc);
> +

Any specific reason for doing this in prepare_message() ? It looks like
something that could/should be done during the probe ?

>  	return 0;
>  }
>  
> @@ -610,11 +633,12 @@ static int meson_spicc_remove(struct platform_device
> *pdev)
>  }
>  
>  static const struct meson_spicc_data meson_spicc_gx_data = {
> -	.max_speed_hz	= 30000000,
> +	.max_speed_hz		= 30000000,
>  };
>  
>  static const struct meson_spicc_data meson_spicc_axg_data = {
> -	.max_speed_hz	= 80000000,
> +	.max_speed_hz		= 80000000,
> +	.has_oen		= true,
>  };
>  
>  static const struct of_device_id meson_spicc_of_match[] = {
