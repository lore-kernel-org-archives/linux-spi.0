From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 6/9] spi: bcm2835aux: warn in dmesg that native cs is
 not really supported
Date: Mon, 25 Mar 2019 11:28:01 +0100
Message-ID: <1e83f4f4-f9ae-2d77-3729-2343a4975e20@i2se.com>
References: <20190324175002.28969-1-kernel@martin.sperl.org>
 <20190324175002.28969-7-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel@martin.sperl.org, Mark Brown <broonie@kernel.org>,
 Eric Anholt <eric@anholt.net>, Hubert Denkmair <h.denkmair@intence.de>,
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190324175002.28969-7-kernel@martin.sperl.org>
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

Am 24.03.19 um 18:49 schrieb kernel@martin.sperl.org:
> From: Martin Sperl <kernel@martin.sperl.org>
>
> From personal bad experience (even as the author of the original driver)
> it shows that native-cs is "somewhat" supported by the spi bus driver
> when using a buggy device tree.
>
> So make sure that the driver is warning in dmesg about this fact
> that we are running in a not supported mode that may have surprizing
> limitations.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Fixes: 1ea29b39f4c812ece2f936065a0a3d6fe44a263e
please use a proper fixes tag.
> ---
>  drivers/spi/spi-bcm2835aux.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index c8acde017b6a..6af07dec5fdc 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -396,6 +396,38 @@ static void bcm2835aux_spi_handle_err(struct spi_master *master,
>  	bcm2835aux_spi_reset_hw(bs);
>  }
>
> +static int bcm2835aux_spi_setup(struct spi_device *spi)
> +{
> +	int ret;
> +
> +	if (spi->mode & SPI_NO_CS)
> +		return 0;
> +	/* sanity check for native cs */
> +	if (!gpio_is_valid(spi->cs_gpio)) {
> +		/* for dt-backwards compatibility: only support native on CS0
> +		 * known things not supported with broken native CS:
> +		 * * multiple chip-selects: cs0-cs2 are all
> +		 *     simultaniously asserted whenever there is a transfer
> +		 *     this even includes SPI_NO_CS
> +		 * * SPI_CS_HIGH: cs are always asserted low
> +		 * * cs_change: cs is deasserted after each spi_transfer
> +		 * * cs_delay_usec: cs is always deasserted one SCK cycle
> +		 *     after the last transfer
> +		 * probably more...
> +		 */
> +		if (spi->chip_select == 0) {
> +			dev_err(&spi->dev,
> +				"native CS is not supported but may work for some use-cases for cs = 0 -  please define a valid value cs-gpios in DT for complete feature set\n");
> +			return 0;

These messages are rather too long, please keep it in the ~ 80 char
limit (in source code and dmesg).
Or make it two lines ...

Since we return with 0, i prefer to use dev_warn instead of dev_err.

Thanks

> +		}
> +		dev_err(&spi->dev,
> +			"native CS is not supported for cs > 0 -  please define a valid value cs-gpios in DT to enable multiple cs\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
