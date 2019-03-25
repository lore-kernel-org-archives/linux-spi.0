From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 8/9] spi: bcm2835aux: add driver stats to debugfs
Date: Mon, 25 Mar 2019 10:28:44 +0100
Message-ID: <c2601fdb-3a5d-0a6c-eaea-54a332ec2027@i2se.com>
References: <20190324175002.28969-1-kernel@martin.sperl.org>
 <20190324175002.28969-9-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel@martin.sperl.org, Mark Brown <broonie@kernel.org>,
 Eric Anholt <eric@anholt.net>, Hubert Denkmair <h.denkmair@intence.de>,
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190324175002.28969-9-kernel@martin.sperl.org>
Content-Language: en-US
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

Hi Martin,

Am 24.03.19 um 18:50 schrieb kernel@martin.sperl.org:
> From: Martin Sperl <kernel@martin.sperl.org>
>
> To estimate efficiency add statistics on transfer types
> (polling and interrupt) used to debugfs.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/spi/spi-bcm2835aux.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index dd0446968da6..d2b58060b333 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -21,6 +21,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> @@ -102,8 +103,57 @@ struct bcm2835aux_spi {
>  	int tx_len;
>  	int rx_len;
>  	int pending;
> +
> +#if defined(CONFIG_DEBUG_FS)
> +#define BCM2835_AUX_INCR(field) ((field)++)
> +	u64 count_transfer_polling;
> +	u64 count_transfer_irq;
> +	u64 count_transfer_irq_after_poll;
> +
> +	struct dentry *debugfs_dir;
> +#else
> +#define BCM2835_AUX_INCR(field)
> +#endif /* CONFIG_DEBUG_FS */
>  };
>
is there a chance to avoid these ifdefs CONFIG_DEBUG_FS?
