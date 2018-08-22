From: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Date: Wed, 22 Aug 2018 20:51:40 +0300
Message-ID: <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il>
References: <20180821095303.27664-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821095303.27664-1-geert+renesas@glider.be>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert

Thank you for keeping me informed.

I have to point at the following threat: a dynamically allocated ID may 
'squat' a bus ID that intended for a device with statically allocated 
ID. This scenario is possible since module loading order is uncertain.
This threat seems to be inevitable...

--
Best regards,
Kirill.


On 08/21/2018 12:53 PM, Geert Uytterhoeven wrote:
> If the SPI bus number is provided by a DT alias, idr_alloc() is called
> twice, leading to:
> 
>      WARNING: CPU: 1 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x11c/0x5d8
>      couldn't get idr
> 
> Fix this by moving the handling of fixed SPI bus numbers up, before the
> DT handling code fills in ctlr->bus_num.
> 
> Fixes: 1a4327fbf4554d5b ("spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Seen on e.g. r8a7791/koelsch, breaking both RSPI and MSIOF.
> ---
>   drivers/spi/spi.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index a00d006d4c3a1c5a..9da0bc5a036cfff6 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2143,8 +2143,17 @@ int spi_register_controller(struct spi_controller *ctlr)
>   	 */
>   	if (ctlr->num_chipselect == 0)
>   		return -EINVAL;
> -	/* allocate dynamic bus number using Linux idr */
> -	if ((ctlr->bus_num < 0) && ctlr->dev.of_node) {
> +	if (ctlr->bus_num >= 0) {
> +		/* devices with a fixed bus num must check-in with the num */
> +		mutex_lock(&board_lock);
> +		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
> +			ctlr->bus_num + 1, GFP_KERNEL);
> +		mutex_unlock(&board_lock);
> +		if (WARN(id < 0, "couldn't get idr"))
> +			return id == -ENOSPC ? -EBUSY : id;
> +		ctlr->bus_num = id;
> +	} else if (ctlr->dev.of_node) {
> +		/* allocate dynamic bus number using Linux idr */
>   		id = of_alias_get_id(ctlr->dev.of_node, "spi");
>   		if (id >= 0) {
>   			ctlr->bus_num = id;
> @@ -2170,15 +2179,6 @@ int spi_register_controller(struct spi_controller *ctlr)
>   		if (WARN(id < 0, "couldn't get idr"))
>   			return id;
>   		ctlr->bus_num = id;
> -	} else {
> -		/* devices with a fixed bus num must check-in with the num */
> -		mutex_lock(&board_lock);
> -		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
> -			ctlr->bus_num + 1, GFP_KERNEL);
> -		mutex_unlock(&board_lock);
> -		if (WARN(id < 0, "couldn't get idr"))
> -			return id == -ENOSPC ? -EBUSY : id;
> -		ctlr->bus_num = id;
>   	}
>   	INIT_LIST_HEAD(&ctlr->queue);
>   	spin_lock_init(&ctlr->queue_lock);
> 
