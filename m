From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 9/9] spi: bcm2835aux: make the polling duration limits
 configurable
Date: Mon, 25 Mar 2019 10:44:19 +0100
Message-ID: <4da737f4-acf2-c70d-59cd-0efdf2ec21d4@i2se.com>
References: <20190324175002.28969-1-kernel@martin.sperl.org>
 <20190324175002.28969-10-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel@martin.sperl.org, Mark Brown <broonie@kernel.org>,
 Eric Anholt <eric@anholt.net>, Hubert Denkmair <h.denkmair@intence.de>,
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190324175002.28969-10-kernel@martin.sperl.org>
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
> Under some circumstances the default 30 us polling limit is not optimal
> and may lead to long delays because we are waiting on an interrupt.
> with this patch we have the possibility to influence this policy.
>
> So make this limit (in us) configurable via a module parameters
> (but also modifyable via /sys/modules/...)
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>
> ---
> Changelog:
>   V1 -> V2: remove the dependency on a different patchset focused on
> 	    making cs_change delay configurable
>
> ---
>  drivers/spi/spi-bcm2835aux.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index d2b58060b333..df065108122b 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -37,6 +37,12 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spinlock.h>
>
> +/* define polling limits */
> +unsigned int polling_limit_us = 30;
> +module_param(polling_limit_us, uint, 0664);
> +MODULE_PARM_DESC(polling_limit_us,
> +		 "time in us to run a transfer in polling mode\n");
> +
could you please document the case polling_limit_us = 0 ?
