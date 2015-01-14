From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] spi: sh-msiof: Update calculation of frequency dividing
Date: Wed, 14 Jan 2015 14:22:51 +0300
Message-ID: <54B6518B.4080607@cogentembedded.com>
References: <1421220335-22503-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-sh@vger.kernel.org, geert@glider.be,
	yoshihiro.shimoda.uh@renesas.com
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1421220335-22503-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello.

On 1/14/2015 10:25 AM, Nobuhiro Iwamatsu wrote:

> sh-msiof of frequency dividing does not perform the calculation, driver have
> to manage setting value in the table. It is not possible to set frequency
> dividing value close to the actual data in this way. This changes from
> frequency dividing of table management to setting by calculation.
> This driver is able to set a value close to the actual data.

> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>   drivers/spi/spi-sh-msiof.c | 39 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 22 deletions(-)

> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 96a5fc0..58b1bfe 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -241,42 +241,37 @@ static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
[...]
> -	k = min_t(int, k, ARRAY_SIZE(sh_msiof_spi_clk_table) - 1);
> -
> -	sh_msiof_write(p, TSCR, sh_msiof_spi_clk_table[k].scr);
> +	scr = sh_msiof_spi_div_table[k].brdv | (brps -1) << 8;

    You forgot a space after '-'.

[...]

WBR, Sergei

