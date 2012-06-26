From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: [PATCH 7/9] I2C: MV64XXX: Add Device Tree support
Date: Tue, 26 Jun 2012 15:03:56 +0100
Message-ID: <4FE9C14C.2030804@codethink.co.uk>
References: <1339324322-29388-8-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, machael-QKn5cuLxLXY@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1339324322-29388-8-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 10/06/12 11:31, Andrew Lunn wrote:
> Extends the driver to get properties from device tree. Also extend the
> kirkwood DT support to supply the needed properties.
>
> Signed-off-by: Andrew Lunn<andrew-g2DYL2Zd6BY@public.gmane.org>
> ---
>   Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   35 +++++++++++++++++-
>   arch/arm/boot/dts/kirkwood.dtsi                    |   13 +++++++
>   arch/arm/mach-kirkwood/board-dt.c                  |    2 ++
>   drivers/i2c/busses/i2c-mv64xxx.c                   |   38 +++++++++++++++++---
>   4 files changed, 82 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> index b891ee2..89ef899 100644
> --- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> @@ -1,4 +1,4 @@
> -* I2C
> +* Marvell MMP I2C controller
>
>   Required properties :
>
> @@ -32,3 +32,36 @@ Examples:
>   		interrupts =<58>;
>   	};
>
> +* Marvell MV64XXX I2C controller
> +
> +Required properties :
> +
> + - reg         : Offset and length of the register set for the device
> + - compatible  : should be "marvell,mv64xxx-i2c"
> + - interrupts  : the interrupt number
> + - frequency-m : m factor in baud rate calculation
> +
> +Recommended properties :
> +
> + - frequency-n : n factor in baud rate calculation
> + - timeout-ms  : How long to wait for a transaction to complete
> +
> +Baud Rate:
> +
> +The baud rate is calculated thus:
> +
> +Fscl =          Ftclk
> +       ------------------------------------------
> +                                (frequency-n + 1)
> +       10 *(frequency-m + 1) * 2
> +
> +Examples:

I'd really rather see this calculated at run-time, given some
systems can quite easily change their clocks.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
