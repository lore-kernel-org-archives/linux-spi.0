From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: ls1021a-tsn: Use the DSPI controller in
 poll mode
Date: Mon, 26 Aug 2019 16:10:51 +0300
Message-ID: <CA+h21hqWGDCfTg813W1WaXFnRsMdE30WnaXw5TJvpkSp0-w5JA@mail.gmail.com>
References: <20190822211514.19288-1-olteanv@gmail.com> <20190822211514.19288-6-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822211514.19288-6-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, 23 Aug 2019 at 00:15, Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Connected to the LS1021A DSPI is the SJA1105 DSA switch. This
> constitutes 4 of the 6 Ethernet ports on this board.
>
> As the SJA1105 is a PTP switch, constant disciplining of its PTP clock
> is necessary, and that translates into a lot of SPI I/O even when
> otherwise idle.
>
> Switching to using the DSPI in poll mode has several distinct
> benefits:
>
> - With interrupts, the DSPI driver in TCFQ mode raises an IRQ after each
>   transmitted byte. There is more time wasted for the "waitq" event than
>   for actual I/O. And the DSPI IRQ count is by far the largest in
>   /proc/interrupts on this board (larger than Ethernet). I should
>   mention that due to various LS1021A errata, other operating modes than
>   TCFQ are not available.
>
> - The SPI I/O time is both lower, and more consistently so. For a TSN
>   switch it is important that all SPI transfers take a deterministic
>   time to complete.
>   Reading the PTP clock is an important example.
>   Egressing through the switch requires some setup in advance (an SPI
>   write command). Without this patch, that operation required a
>   --tx_timestamp_timeout 50 (ms), now it can be done with
>   --tx_timestamp_timeout 10.
>   Yet another example is reconstructing timestamps, which has a hard
>   deadline because the PTP timestamping counter wraps around in 0.135
>   seconds. Combined with other I/O needed for that to happen, there is
>   a real risk that the deadline is not always met.
>
> See drivers/net/dsa/sja1105/ for more info about the above.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> ---
>  arch/arm/boot/dts/ls1021a-tsn.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/ls1021a-tsn.dts b/arch/arm/boot/dts/ls1021a-tsn.dts
> index 5b7689094b70..1c09cfc766af 100644
> --- a/arch/arm/boot/dts/ls1021a-tsn.dts
> +++ b/arch/arm/boot/dts/ls1021a-tsn.dts
> @@ -33,6 +33,7 @@
>  };
>
>  &dspi0 {
> +       /delete-property/ interrupts;
>         bus-num = <0>;
>         status = "okay";
>
> --
> 2.17.1
>

I noticed you skipped applying this patch, and I'm not sure that Shawn
will review it/take it.
Do you have a better suggestion how I can achieve putting the DSPI
driver in poll mode for this board? A Kconfig option maybe?

Regards,
-Vladimir
